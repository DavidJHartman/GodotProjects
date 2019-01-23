extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var Position = int(0)
var Velocity = int(0)
var Gravity = .1

func jump(velocity):
	Velocity = velocity

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	Position += Velocity
	if Position >= 0:
		Velocity = 0
		Position = 0
		Gravity = .1
	position.y = Position
	Velocity += Gravity
