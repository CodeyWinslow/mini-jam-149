extends Node3D

@export var TimeBetweenBoxSpawn = 15.0
@export var Spawners : Array[Node3D] = []
@export var Goals : Array[Node3D] = []

var counter_label: Label
var language_reader_label: Label
var languageA_label: Label
var languageB_label: Label
var languageC_label: Label
var languageD_label: Label
var pause_menu : Node
var spawn_timer : Timer;

var count: int

func _ready():
	pause_menu = get_node("Pause Menu")
	counter_label = get_node("Pauseable/Counter/CounterSubViewport/CounterLabel")
	language_reader_label = get_node("Pauseable/LanguageDisplay/CounterSubViewport/CounterLabel")
	languageA_label = get_node("Pauseable/LanguageA/CounterSubViewport/CounterLabel")
	languageB_label = get_node("Pauseable/LanguageB/CounterSubViewport/CounterLabel")
	languageC_label = get_node("Pauseable/LanguageC/CounterSubViewport/CounterLabel")
	languageD_label = get_node("Pauseable/LanguageD/CounterSubViewport/CounterLabel")
	count = 0
	counter_label.text = str(count)
	language_reader_label.text = "" #☬〠☫☤
	languageA_label.text = "☬"
	languageB_label.text = "〠"
	languageC_label.text = "☫"
	languageD_label.text = "☤"
	
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(on_spawn_timer_finish)
	spawn_timer.start(TimeBetweenBoxSpawn)
	
	for goalindex in range(Goals.size()):
		var goal = Goals[goalindex]
		goal.box_delivered_success.connect(on_box_delivered_success)
		goal.box_delivered_fail.connect(on_box_delivered_fail)
		
	for spawnerindex in range(Spawners.size()):
		var spawner = Spawners[spawnerindex]
		spawner.box_spawned.connect(on_box_spawned)
	
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

func on_box_spawned(node : Node3D):
	print("box spawned")
	
func on_box_delivered_success(box):
	print("box delivered successfully")
	
func on_box_delivered_fail(box):
	print("box delivery FAILED")
