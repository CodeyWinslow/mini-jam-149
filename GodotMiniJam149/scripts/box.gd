extends RigidBody3D

@export var TimeToDeliver : float = 30.0

var expected_destination : Types.Destination = Types.Destination.DestinationA

signal delivered
signal time_expired
signal can_interact_changed(can_interact : bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	expected_destination = get_random_destination()


func get_random_destination():
	return randi() % Types.Destination.size() as Types.Destination
	
func on_deliver_time_expired():
	time_expired.emit()
	queue_free()
	
func change_can_interact(can_interact):
	can_interact_changed.emit(can_interact)
	

func deliver():
	delivered.emit()
	queue_free()
