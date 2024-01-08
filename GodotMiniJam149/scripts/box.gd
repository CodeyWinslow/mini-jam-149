extends RigidBody3D



enum Destination {
	A,
	B,
	C,
	D
}

var expected_destination : Destination = Destination.A

# Called when the node enters the scene tree for the first time.
func _ready():
	expected_destination = get_random_destination()
	print("box has destination ", expected_destination)


func get_random_destination():
	return randi() % Destination.size() as Destination
