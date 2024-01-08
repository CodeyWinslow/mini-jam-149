extends Node3D

@export var TimeBetweenBoxSpawn = 15.0
@export var Spawners : Array[Node3D] = []
@export var Goals : Array[Node3D] = []

signal game_lost

var counter_label: Label
var language_reader_label: Label
var strikes_label : Label
var languageA_label: Label
var languageB_label: Label
var languageC_label: Label
var languageD_label: Label
var pause_menu : Node
var lose_menu : Node
var spawn_timer : Timer;

var destination_text = ["☬", "〠", "☫", "☤"]

var total_score: int
var total_strikes: int

func _ready():
	pause_menu = get_node("Pause Menu")
	lose_menu = get_node("Lose Menu")
	counter_label = get_node("Pauseable/Counter/CounterSubViewport/CounterLabel")
	language_reader_label = get_node("Pauseable/LanguageDisplay/CounterSubViewport/CounterLabel")
	strikes_label = get_node("Pauseable/Strikes/CounterSubViewport/CounterLabel")
	languageA_label = get_node("Pauseable/LanguageA/CounterSubViewport/CounterLabel")
	languageB_label = get_node("Pauseable/LanguageB/CounterSubViewport/CounterLabel")
	languageC_label = get_node("Pauseable/LanguageC/CounterSubViewport/CounterLabel")
	languageD_label = get_node("Pauseable/LanguageD/CounterSubViewport/CounterLabel")
	update_score(0)
	set_strikes(0)
	language_reader_label.text = "Translator: " #☬〠☫☤
	languageA_label.text = destination_text[0]
	languageB_label.text = destination_text[1]
	languageC_label.text = destination_text[2]
	languageD_label.text = destination_text[3]
	
	spawn_timer = Timer.new()
	get_node("Pauseable").add_child(spawn_timer)
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
	if total_strikes < 3:
		get_tree().paused = !get_tree().paused
		pause_menu.visible = !pause_menu.visible
	
func update_score(score):
	total_score = score
	counter_label.text = "Packages sent: " + str(total_score)
	
func set_strikes(strikes):
	total_strikes = strikes
	strikes = ""
	for i in range(total_strikes):
		strikes += "X"
	strikes_label.text = strikes
	# todo: update text in game
	
func increment_strike():
	set_strikes(total_strikes + 1)
	if total_strikes >= 3:
		print('YOU LOSE')
		#game_lost.emit()
		lose_menu.visible = true
		get_tree().paused = !get_tree().paused
	
func on_spawn_timer_finish():
	spawn_timer.start(TimeBetweenBoxSpawn)
	if (Spawners.size() > 0):
		var index = randi() % Spawners.size()
		var spawner = Spawners[index]
		spawner.spawn_box()
	
# gameplay events

func on_box_spawned(node : Node3D):
	node.time_expired.connect(on_box_expired)
	print("box spawned")
	
func on_box_expired():
	print("box expired!")
	
func on_box_delivered_success(box):
	print("box delivered successfully")
	update_score(total_score + 1)
	
func on_box_delivered_fail(box):
	increment_strike()
	print("box delivery FAILED")
	
func on_box_enter_translator(box):
	var dest = box.expected_destination
	language_reader_label.text = "Translator: " + destination_text[dest]
	
func on_box_exit_translator(box):
	language_reader_label.text = "Translator: "

func _on_lose_menu_resume():
	get_tree().paused = false
