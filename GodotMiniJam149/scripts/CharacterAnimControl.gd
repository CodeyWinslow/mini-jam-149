extends Node

@export var Anim : AnimationTree
@export var TransitionSpeed_Move : float

var CurrentSpeedAlpha : float
var TargetSpeedAlpha : float

func UpdateSpeedAlpha(alpha : float):
	TargetSpeedAlpha = alpha
		
func _physics_process(delta):
	if (Anim == null):
		return
		
	if (CurrentSpeedAlpha != TargetSpeedAlpha):
		CurrentSpeedAlpha = move_toward(CurrentSpeedAlpha, TargetSpeedAlpha, TransitionSpeed_Move * delta)
		Anim.set("parameters/locomotion/blend_amount", CurrentSpeedAlpha)
