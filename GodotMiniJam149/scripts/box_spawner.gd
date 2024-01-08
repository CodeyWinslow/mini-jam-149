extends Node3D

@export var BoxPrefab : PackedScene
@export var BoxUIPrefab : PackedScene
@export var SpawnDistance = 3.0
@export var SpawnSpeed = 5.0

signal box_spawned(box : Node3D)

func spawn_box():
	var box : Node3D = BoxPrefab.instantiate() as Node3D
	var ui : Node3D = BoxUIPrefab.instantiate() as Node3D
	if (box):
		add_child(box)
		box.position = Vector3.FORWARD * SpawnDistance
		var rb = box as RigidBody3D
		if (rb):
			rb.linear_velocity = basis * Vector3.FORWARD * SpawnSpeed
		
		if (ui):
			add_child(ui)
			ui.start_tracking(box)
			box.delivered.connect(ui.on_tracked_node_destroyed)
			box.time_expired.connect(ui.on_tracked_node_destroyed)
			box.can_interact_changed.connect(ui.on_can_interact_changed)
			var progress_bar = ui.get_node("ProgressBar")
			progress_bar.set_time(box.TimeToDeliver)
			progress_bar.on_time_ended.connect(box.on_deliver_time_expired)
			
		($AudioStreamPlayer as AudioStreamPlayer).play()
		box_spawned.emit(box)
	
#func _process(delta):
	#if (Input.is_action_just_pressed("debug_spawn")):
		#spawn_box()
