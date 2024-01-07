extends Node3D

@export var AnimNode : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if AnimNode != null:
		AnimNode.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
