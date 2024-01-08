extends Node3D

@export var BoxPrefab : PackedScene
@export var BoxUIPrefab : PackedScene
@export var SpawnDistance = 3.0
@export var SpawnSpeed = 5.0

func spawn_box():
	var inst : Node3D = BoxPrefab.instantiate() as Node3D
	var uiinst : Node3D = BoxUIPrefab.instantiate() as Node3D
	if (inst):
		add_child(inst)
		inst.position = Vector3.FORWARD * SpawnDistance
		var rb = inst as RigidBody3D
		if (rb):
			rb.linear_velocity = basis * Vector3.FORWARD * SpawnSpeed
		
		if (uiinst):
			add_child(uiinst)
			uiinst.start_tracking(inst)

func _process(delta):
	if (Input.is_action_just_pressed("debug_spawn")):
		spawn_box()
