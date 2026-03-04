extends CharacterBody2D

var speed : float = 250.0
var jump_force : float = -550.0
var gravity : float = 900.0
var is_dead = false
var key = false
var is_white_world = true

@onready var sprite = $AnimatedSprite2D
@onready var dust = $DustParticles
@onready var jump_particles = $JumpParticles
@onready var death_particles = $DeathParticles
		
func switch_world():
	is_white_world = !is_white_world
	
func _physics_process(delta):
	if is_dead:
		return
	
	if Input.is_action_just_pressed("switch_dimension"):
		switch_world()
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
		
	move_and_slide()
	
	var moving = abs(velocity.x) > 10 and is_on_floor()
	dust.emitting = moving
	
	var jumping = abs(velocity.y) > 10 and not is_on_floor()
	jump_particles.emitting = jumping
	
	push_boxes(direction)
	handle_step_up()
	update_animation(direction)
	
func push_boxes(direction):
	if direction == 0:
		return

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
			
		if body.is_in_group("box"):
				body.velocity.x = 0
				body.velocity.y = 0
				
				if global_position.x > body.global_position.x and direction < 0:
					body.velocity.x = -body.push_speed
					body.pushed = true
				elif global_position.x < body.global_position.x and direction > 0:
					body.velocity.x = body.push_speed
					body.pushed = true

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
				
func die():
	if is_dead:
		return
	is_dead = true
	
	velocity = Vector2.ZERO
	
	sprite.visible = false
	
	death_particles.emitting = true
	dust.emitting = false
	jump_particles.emitting = false
	
	await get_tree().create_timer(0.7).timeout
	get_tree().reload_current_scene()
		
func update_animation(direction):
	if is_white_world:
		if not is_on_floor():
			sprite.play("WhiteJump")
			sprite.flip_h = direction < 0
			return
			
		if direction != 0:
			sprite.play("WhiteWalk")
			sprite.flip_h = direction < 0
			return
		else:
			sprite.play("WhiteIdle")
			return
			
	if !is_white_world:
		if not is_on_floor():
			sprite.play("BlackJump")
			sprite.flip_h = direction < 0
			return
			
		if direction != 0:
			sprite.play("BlackWalk")
			sprite.flip_h = direction < 0
			return
		else:
			sprite.play("BlackIdle")


func _on_area_2d_area_entered(area):
	if area.is_in_group("key"):
		key = true

func _on_black_key_area_entered(area):
	if area.is_in_group("key"):
		key = false
