extends Area3D

const BoxGroupName = "box"

signal box_entered
signal box_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body : Node3D):
	if body.is_in_group(BoxGroupName):
		box_entered.emit()


func _on_body_exited(body):
	if body.is_in_group(BoxGroupName):
		box_exited.emit()
