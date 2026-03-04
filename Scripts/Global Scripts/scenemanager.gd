extends Node

func go_to_level_number(level_number: int):
	var path = "res://Scenes/level_" + str(level_number) + ".tscn"
	get_tree().change_scene_to_file(path)
