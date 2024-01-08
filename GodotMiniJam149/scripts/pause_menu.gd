extends Control

signal resume;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resume_pressed():
	resume.emit()

func _on_quit_pressed():
	resume.emit()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
