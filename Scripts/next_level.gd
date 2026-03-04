extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameStates.next_level += 1
		call_deferred("go_to_next_level")
		
func go_to_next_level():
	SceneManager.go_to_level_number(GameStates.next_level)
