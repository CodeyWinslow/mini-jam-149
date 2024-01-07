extends Node3D

@export var AnimNode : AnimationPlayer
@export var AnimationToPlay : String

# Called when the node enters the scene tree for the first time.
func _ready():
	if AnimNode == null:
		AnimNode = get_node("MailMan/AnimationPlayer") as AnimationPlayer;
	
	if AnimNode != null:
		AnimNode.play(AnimationToPlay)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
