extends Node3D

@export var TimeBetweenBoxSpawn = 15.0
@export var Spawners : Array[Node3D] = []

var counter_label: Label
var language_label: Label
var pause_menu : Node
var spawn_timer : Timer;

var count: int

func _ready():
	pause_menu = get_node("Pause Menu")
	counter_label = get_node("Pauseable/Counter/CounterSubViewport/CounterLabel")
	language_label = get_node("Pauseable/LanguageDisplay/CounterSubViewport/CounterLabel")
	count = 0
	counter_label.text = str(count)
	language_label.text = ""
	
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(on_spawn_timer_finish)
	spawn_timer.start(TimeBetweenBoxSpawn)
	
func _process(_delta):
	check_input();

func check_input():
	if(Input.is_action_just_pressed("pause")):
		_resume_pause()

func _resume_pause():
	get_tree().paused = !get_tree().paused
	pause_menu.visible = !pause_menu.visible
	
	
func on_spawn_timer_finish():
	spawn_timer.start(TimeBetweenBoxSpawn)
	if (Spawners.size() > 0):
		var index = randi() % Spawners.size()
		var spawner = Spawners[index]
		spawner.spawn_box()
	
# gameplay events

func on_box_spawned(_node : Node3D):
	pass
