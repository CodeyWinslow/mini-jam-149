extends Node3D

signal dropped(node : Node3D)
signal picked_up(node : Node3D)

var current_node : Node3D = null

func is_full():
	return current_node != null
	
func is_empty():
	return !is_full()
	
func drop():
	if current_node != null:
		var node = current_node
		current_node = null
		node.reparent(get_tree().root)
		#place on ground!
		
		dropped.emit(node)
		
func grab(node : Node3D):
	if is_full():
		drop()
	
	current_node = node
	
	current_node.reparent(self)
	current_node.position = Vector3.ZERO
	
	picked_up.emit(current_node)
