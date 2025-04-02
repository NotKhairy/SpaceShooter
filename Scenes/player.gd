extends CharacterBody2D

@export var max_speed: float = 500.0
@export var acceleration: float = 750.0

signal laser(pos, rot)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector.normalized() * max_speed, acceleration * delta)
	move_and_slide()

	# 4) Rotate to face the mouse
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = mouse_position - global_position
	rotation = direction_to_mouse.angle() + PI/2  # +PI/2 if your sprite faces “up” by default

	# 5) Check for shooting input
	if Input.is_action_just_pressed("Shoot Laser"):
		# emit the signal with the current position and rotation
		laser.emit(position, rotation)
