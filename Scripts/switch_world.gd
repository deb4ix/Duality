extends Node2D

var is_white_world = true

@onready var white_world = $WhiteWorld
@onready var black_world = $BlackWorld
@onready var white_objects = $WhiteObjects
@onready var black_objects = $BlackObjects
@onready var background = $Background
@onready var player : CharacterBody2D = $Player

func _process(delta):
	if Input.is_action_just_pressed("switch_dimension"):
		switch_world()
		
func set_dimension_active(group_name: String, active: bool):
	for node in get_tree().get_nodes_in_group(group_name):
		if node is CharacterBody2D:
			node.set_physics_process(active)

		if node is Area2D:
			node.monitoring = active

func switch_world():
	is_white_world = !is_white_world
	
	if is_white_world:
		white_world.visible = true
		white_objects.visible = true
		black_world.visible = false
		black_objects.visible = false
		
		
		$Player/DustParticles.modulate = Color(0.951, 0.948, 0.932, 1.0)
		$Player/JumpParticles.modulate = Color(0.951, 0.948, 0.932, 1.0)
		$Player/DeathParticles.modulate = Color(1.0, 1.0, 1.0, 1.0)
		background.color = Color(0.058, 0.058, 0.058, 1.0)
		$BackgroundParticles.modulate = Color(0.62, 0.62, 0.62, 0.784)

		player.collision_mask = 1
		set_dimension_active("white_dimension", true)
		set_dimension_active("black_dimension", false)
	else:
		white_world.visible = false
		white_objects.visible = false
		black_world.visible = true
		black_objects.visible = true
		
		$Player/DustParticles.modulate = Color(0.001, 0.001, 0.001, 1.0)
		$Player/JumpParticles.modulate = Color(0.001, 0.001, 0.001, 1.0)
		$Player/DeathParticles.modulate = Color(0.0, 0.0, 0.0, 1.0)
		background.color = Color(0.823, 0.823, 0.823, 1.0)
		$BackgroundParticles.modulate = Color(0.123, 0.123, 0.123, 0.784)
		
		player.collision_mask = 2
		set_dimension_active("white_dimension", false)
		set_dimension_active("black_dimension", true)
