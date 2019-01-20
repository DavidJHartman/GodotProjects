extends RigidBody

var Gravity = Vector3( 0, -9.81, 0 )
var Velocity = Vector3()

var nodePosition = Vector3()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	nodePosition = get_node("GrappleNode")
	
	Velocity += Gravity * delta
	pass
