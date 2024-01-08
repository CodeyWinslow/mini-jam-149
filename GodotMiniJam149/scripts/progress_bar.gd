extends Sprite3D

var progress_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar = get_node("SubViewport/ProgressBar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	progress_bar.value += 1
