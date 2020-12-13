extends Node

class_name DoubleJump


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Double Jump"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update():
	player.deltav.y += player.GRAVITY
	player.velocity += player.deltav
	player.velocity.y = -player.jump_speed
	player.move_and_slide( player.velocity, Vector2(0,-1) )
	state.update_state("Falling")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
