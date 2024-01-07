extends Node3D

func _ready():
	var pauseMenu = get_node("Pause Menu")
	pauseMenu.resume.connect(_resume_pause)

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		_resume_pause()

func _resume_pause():
	get_tree().paused = !get_tree().paused
	var pauseMenu = get_node("Pause Menu")
	pauseMenu.visible = !pauseMenu.visible
