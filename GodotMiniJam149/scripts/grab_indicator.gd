extends Node3D

var DisplayMesh : Node3D

func _ready():
	DisplayMesh = get_node("DummyMesh") as Node3D
	DisplayMesh.hide()

func _on_detected_grabbable_changed(node):
	if node == null:
		DisplayMesh.hide()
	else:
		DisplayMesh.show()
