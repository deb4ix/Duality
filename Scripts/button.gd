extends Area2D

signal pressed
signal released

var bodies_on_button : int = 0
var is_pressed : bool = false

@onready var sprite = $AnimatedSprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body):
	if body.name == "Player" or body.name == "Box":
		bodies_on_button += 1
		update_state()
		
func _on_body_exited(body):
	if body.name == "Player" or body.name == "Box":
		bodies_on_button -= 1
		update_state()
		
func update_state():
	if bodies_on_button > 0 and is_pressed:
		is_pressed = true
		sprite.play("Button_Pressed")
		emit_signal("pressed")
	elif bodies_on_button == 0 and is_pressed:
		is_pressed = false
		sprite.play("Button_Idle")
		emit_signal("released")
