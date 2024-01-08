extends Node3D

@export var CharacterBody : PhysicsBody3D

signal dropped(node : Node3D)
signal picked_up(node : Node3D)

var joint : Joint3D = null
var current_node : Node3D = null

func is_full():
	return current_node != null
	
func is_empty():
	return !is_full()
	
func drop():
	if current_node != null:
		var node = current_node
		current_node = null
		
		if node is RigidBody3D:
			var rb = node as RigidBody3D
			#detach_physics()
			rb.reparent(get_tree().root)
			rb.freeze = false
		else:
			node.reparent(get_tree().root)
		
		dropped.emit(node)
		
func grab(node : Node3D):
	if is_full():
		drop()
	
	current_node = node
	if current_node is RigidBody3D and CharacterBody != null:
		var rb = current_node as RigidBody3D
		#attach_physics(rb)
		rb.reparent(self)
		rb.position = Vector3.ZERO
		rb.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
		rb.freeze = true
	else:
		current_node.reparent(self)
	current_node.position = Vector3.ZERO
	
	picked_up.emit(current_node)

func detach_physics():
	joint.node_a = ""
	joint.node_b = ""
	remove_child(joint)
	joint.queue_free()
	joint = null

func attach_physics(rb : RigidBody3D):
	joint = PinJoint3D.new()
	add_child(joint)
	rb.global_position = global_position
	joint.node_a = CharacterBody.get_path()
	joint.node_b = rb.get_path()
