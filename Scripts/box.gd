extends CharacterBody2D

var gravity : float = 900.0
var friction : float = 1200.0
var push_speed : float = 250.0
var pushed : bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	move_and_slide()
	handle_step_up()
	pushed = false

func handle_step_up():
	if not is_on_floor():
		return
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		var collider = collision.get_collider()
		
		if collider.is_in_group("stepable") and abs(normal.x) > 0.9:
			var step_height = 10
			
			var original_position = global_position
			global_position.y -= step_height
			
			var check = move_and_collide(Vector2(0,0))
			
			if check == null:
				return
			else:
				global_position = original_position
