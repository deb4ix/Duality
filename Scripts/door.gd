extends StaticBody2D

enum {
	CLOSED,
	OPENING,
	OPENED,
	CLOSING
}

var state = CLOSED

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.play("closed")
	
func open():
	if state == CLOSED or state == CLOSING:
		state = OPENING
		sprite.play("opening")
		
func close():
	if state == OPENED or state == OPENING:
		state = CLOSING
		sprite.play("closing")
		
func _on_animation_finished():
	if sprite.animation == "opening":
		state = OPENED
		collision.disabled = true
		sprite.play("opened")
	elif sprite.animation == "closing":
		state = CLOSED
		collision.disabled = false
		sprite.play("closed")

func _on_white_button_pressed():
	open()

func _on_white_button_released():
	close()


func _on_black_button_pressed():
	open()


func _on_black_button_released():
	close()
