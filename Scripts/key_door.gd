extends StaticBody2D

enum {
	CLOSED,
	OPENING,
	OPENED
}

var state = CLOSED

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)
	sprite.play("closed")
	
func open():
	if state == CLOSED:
		state = OPENING
		sprite.play("opening")

func _on_animation_finished():
	if sprite.animation == "opening":
		state = OPENED
		collision.disabled = true
		sprite.play("opened")

func _on_white_key_collected():
	open()

func _on_black_key_collected() -> void:
	open()
