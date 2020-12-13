extends Node

class_name Idle


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Idle"
var _keys

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	state.update_state(_state_name)
	pass # Replace with function body.

func update():
	player.velocity = Vector2.ZERO
	player.deltav = Vector2.ZERO
	
	if !player.is_on_floor():
		state.update_state("Falling")
		pass
	elif state.motion_direction.x != 0:
		state.update_state("Walking")
		pass
	elif state.motion_direction.y == 1:
		state.update_state("Jump")
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
