extends Node3D

var DisplayMesh : Node3D

var cur_node : Node3D = null

func _ready():
	DisplayMesh = get_node("DummyMesh") as Node3D
	DisplayMesh.hide()

func _on_detected_grabbable_changed(node):
	if (cur_node != null):
		cur_node.change_can_interact(false)
		
	cur_node = node
	if (cur_node != null):
		cur_node.change_can_interact(true)
