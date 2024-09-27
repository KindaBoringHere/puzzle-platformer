extends CharacterBody2D
var player_moveable: bool = true
const SPEED = 300.0
var gravity_direction: String = "down"
var start_pos
var flips_left: int = 1
var total_flips: int = 1

func _ready() -> void:
	start_pos = position 
	add_to_group("player")

func _physics_process(delta: float) -> void:
	print(flips_left)
	var gravity = get_gravity().y * delta  # Use the y component of gravity
	if Global.player_finished:
		player_moveable = false
		
	if self.is_on_floor():
		flips_left = total_flips
			
		
	# Handle gravity direction switch
	if player_moveable and Input.is_action_just_pressed("gravity") and flips_left > 0:
		if gravity_direction == "up":
			gravity_direction = "down"
			$sprite.flip_v = false
			up_direction = Vector2(0, -1)
			flips_left -= 1
		elif gravity_direction == "down":
			gravity_direction = "up"
			$sprite.flip_v = true
			up_direction = Vector2(0, 1)
			flips_left -= 1

	# Apply gravity
	if gravity_direction == "down":
		velocity.y += gravity  # Normal gravity pulling down
	elif gravity_direction == "up":
		velocity.y -= gravity  # Reverse gravity pulling up

	# Stick to the ground logic
	if is_on_floor() and gravity_direction == "down":
		velocity.y = 0  # Reset velocity if on the floor and gravity is down

	if player_moveable:
		move_and_slide()

	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("ui_left", "ui_right")

	# Only allow movement if not attacking or dead
	if player_moveable:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation and flipping logic
	if player_moveable:
		if velocity.x != 0:
			$sprite.play("run")
		elif velocity == Vector2.ZERO:
			$sprite.play("idle")
		elif velocity.y != 0:
			$sprite.play("reset")

		# Flip sprite based on direction
		if velocity.x > 0:
			$sprite.flip_h = false
		elif velocity.x < 0:
			$sprite.flip_h = true

	# Prevent attacking while in the air




	
func _on_death_barrier_death() -> void:
	$death_animation.start()
	$sprite.play("death")
	player_moveable = false
	print("touched bottom barrier")

	#makes the player go back after dying :)
	
func _on_death_animation_timeout():
	print("going back")
	position = start_pos
	gravity_direction = "down"
	player_moveable = true
	


func _on_death_barrier_3_death() -> void:
	$death_animation.start()
	$sprite.play("death")
	player_moveable = false
	print("touched wall")


func _on_death_barrier_2_death() -> void:
	$death_animation.start()
	$sprite.play("death")
	player_moveable = false
	print("touched ceiling")
