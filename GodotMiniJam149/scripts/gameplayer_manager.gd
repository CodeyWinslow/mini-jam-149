extends Node3D

var counter_label: Label
var count: int

var pause_menu : Node

func _ready():
	pause_menu = get_node("Pause Menu")
	counter_label = get_node("Pauseable/Counter/CounterSubViewport/CounterLabel")
	count = 0
	counter_label.text = str(count)
	
func _process(_delta):
	check_input();

func check_input():
	if(Input.is_action_just_pressed("pause")):
		_resume_pause()

func _resume_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = !pause_menu.visible
	
# gameplay events

func on_box_spawned(_node : Node3D):
	pass
