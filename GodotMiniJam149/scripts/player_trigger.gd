extends Area3D

const PlayerGroupName = "player"

signal player_entered
signal player_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body : Node3D):
	if body.is_in_group(PlayerGroupName):
		player_entered.emit()


func _on_body_exited(body):
	if body.is_in_group(PlayerGroupName):
		player_exited.emit()
