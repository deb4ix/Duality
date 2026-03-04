extends Area2D

signal collected

var is_collected = false

func _on_body_entered(body):
	if is_collected:
		return
	
	if body.name == "Player":
		is_collected = true
		$Sprite2D.visible = false
		$CollisionShape2D.visible = false
		emit_signal("collected")
		$KeyParticles.emitting = true
