extends Node

class_name Dash


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false

#private variables
var _state_name = "Dash"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(delta):
	if !player.is_on_floor():
		state.update_state("Falling")
		pass
	state.update_state("Idle")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
