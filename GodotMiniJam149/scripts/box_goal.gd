extends Node3D

@export var GoalDestination : Types.Destination = Types.Destination.DestinationA

signal box_delivered_success(node: Node3D)
signal box_delivered_fail(node: Node3D)


func _on_area_3d_box_entered(box):
	if GoalDestination == box.expected_destination:
		box_delivered_success.emit(box)
	else:
		box_delivered_fail.emit(box)
		
	box.deliver()
