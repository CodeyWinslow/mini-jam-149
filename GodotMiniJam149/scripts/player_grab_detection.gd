extends Area3D

@export var GrabbableGroupName = "grabbable"

signal detected_grabbable_changed(node : Node3D)
signal try_grab(node : Node3D)
signal try_drop

var IsHolding = false
var CurrentGrabbable : Node3D
var Grabbables : Array

func _physics_process(_delta):
	if CurrentGrabbable != null and Input.is_action_just_pressed("grab"):
		try_grab.emit(CurrentGrabbable)
	elif Input.is_action_just_pressed("grab"):
		try_drop.emit()

func _on_body_entered(body):
	if body.is_in_group(GrabbableGroupName):
		Grabbables.append(body)
		if not IsHolding:
			CurrentGrabbable = body
			detected_grabbable_changed.emit(CurrentGrabbable)
		

func _on_body_exited(body):
	if body.is_in_group(GrabbableGroupName):
		Grabbables.erase(body)
		
		if not IsHolding and CurrentGrabbable == body:
			CurrentGrabbable = null
			if (Grabbables.size() > 0):
				CurrentGrabbable = Grabbables[0]
			detected_grabbable_changed.emit(CurrentGrabbable)


func _on_grab_socket_picked_up(_node):
	CurrentGrabbable = null
	IsHolding = true
	detected_grabbable_changed.emit(CurrentGrabbable)


func _on_grab_socket_dropped(_node):
	IsHolding = false
	if (Grabbables.size() > 0):
		CurrentGrabbable = Grabbables[0]
		detected_grabbable_changed.emit(CurrentGrabbable)
