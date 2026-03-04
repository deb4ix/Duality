extends CharacterBody2D

signal pressed
signal released

var bodies_on_top : int = 0
var is_pressed : bool = false

@onready var sprite = $AnimatedSprite2D
@onready var area = $Area2D

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	sprite.play("Button Idle")
	
func _on_body_entered(body):
	if body.name == "Player" or body.is_in_group("box"):
		bodies_on_top += 1
		update_state()
		
func _on_body_exited(body):
	if body.name == "Player" or body.is_in_group("box"):
		bodies_on_top -= 1
		update_state()
		
func update_state():
	if bodies_on_top > 0 and not is_pressed:
		is_pressed = true
		sprite.play("Button Pressed")
		emit_signal("pressed")
	elif bodies_on_top == 0 and is_pressed:
		is_pressed = false
		sprite.play("Button Idle")
		emit_signal("released")
