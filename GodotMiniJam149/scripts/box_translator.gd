extends Node3D


signal box_entered(box)
signal box_exited(box)

func _on_area_3d_box_entered(box):
	box_entered.emit(box)
	($AudioStreamPlayer as AudioStreamPlayer).play()


func _on_area_3d_box_exited(box):
	box_exited.emit(box)
