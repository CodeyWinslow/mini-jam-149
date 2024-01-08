extends CharacterBody3D


#const SPEED = 5.0
@export var SPEED = 5.0
@export var ROT_SPEED = 1.0
const JUMP_VELOCITY = 4.5

signal speed_changed(newspeed)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 100

var target_rotation = 0
var helper_node : Node3D

func _ready():
	target_rotation = rotation.y
	helper_node = Node3D.new()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
	var newspeed = input_dir.length()
	var norm_dir = Vector3(input_dir.x, 0, input_dir.y)
	if (newspeed > 1.0):
		norm_dir = norm_dir.normalized()
		newspeed = 1
		
	newspeed *= SPEED
	if norm_dir:
		#velocity.x = direction.x * SPEED
		velocity.x = norm_dir.x * SPEED
		#velocity.z = direction.z * SPEED
		velocity.z = norm_dir.z * SPEED
		#look_at(position + norm_dir)
		
		# set new target rotation
		helper_node.look_at_from_position(Vector3.ZERO, norm_dir * 100)
		target_rotation = helper_node.rotation.y
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	speed_changed.emit(newspeed / SPEED)

	rotation.y = rotate_toward(rotation.y, target_rotation, delta * ROT_SPEED)
	move_and_slide()
