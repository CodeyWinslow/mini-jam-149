extends Node3D

enum TrackType {
	Frame,
	Physics
}

@export var track_type : TrackType = TrackType.Physics
@export var offset : Vector3 = Vector3.ZERO
@export var initial_tracked_node : Node3D

var tracked_node : Node3D

# public interface
func start_tracking(node : Node3D):
	tracked_node = node
	
func stop_tracking():
	tracked_node = null
	
func set_offset(new_offset : Vector3):
	offset = new_offset

# hooks
func _ready():
	start_tracking(initial_tracked_node)

func _process(_delta):
	if (track_type == TrackType.Frame):
		update_position()

func _physics_process(_delta):
	if (track_type == TrackType.Physics):
		update_position()

# private
func update_position():
	if (tracked_node != null):
		global_position = tracked_node.global_position + offset
		
func on_tracked_node_destroyed():
	queue_free()
	
func on_can_interact_changed(can_interact : bool):
	$Sprite3D/SubViewport/Label.visible = can_interact
