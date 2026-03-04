extends Area2D

var is_player_inside : bool = false

@onready var label = $Clue

func _ready():
	label.visible_characters = 0

func _on_body_entered(body):
	if body.name == "Player":
		is_player_inside = true
		start_dialog()
		
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside = false
		hide_text()

func start_dialog():
	for i in range(label.text.length()):
		
		if not is_player_inside:
			return
		
		label.visible_characters += 1
		await get_tree().create_timer(0.03).timeout

func hide_text():
	while label.visible_characters > 0:
		
		if is_player_inside:
			return
		
		label.visible_characters -= 1
		await get_tree().create_timer(0.002).timeout
