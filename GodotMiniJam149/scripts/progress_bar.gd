extends Sprite3D

var progress_bar: ProgressBar

var time_to_add_from_timer : float = 1.0

var time_elapsed = 0.0
var total_time_expiration = 10.0
signal on_time_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar = get_node("SubViewport/ProgressBar")
	time_to_add_from_timer = (get_node("SubViewport/Timer") as Timer).wait_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_time(seconds : float):
	total_time_expiration = seconds
	progress_bar.value = 0
	time_elapsed = 0

func _on_timer_timeout():
	time_elapsed += time_to_add_from_timer
	progress_bar.value = min(time_elapsed / total_time_expiration, 1.0) * 100
	
	if time_elapsed >= total_time_expiration:
		print("time is up!")
		on_time_ended.emit()
