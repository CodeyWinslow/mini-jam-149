extends RigidBody3D

@export var TimeToDeliver : float = 30.0

var expected_destination : Types.Destination = Types.Destination.DestinationA

signal delivered
signal time_expired

# Called when the node enters the scene tree for the first time.
func _ready():
	expected_destination = get_random_destination()
	print("box has destination ", expected_destination)


func get_random_destination():
	return randi() % Types.Destination.size() as Types.Destination
	
func on_deliver_time_expired():
	time_expired.emit()
	queue_free()

func deliver():
	delivered.emit()
	queue_free()
