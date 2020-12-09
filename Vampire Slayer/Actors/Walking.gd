extends Node

class_name Walking


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false

#private variables
var _state_name = "Walking"

#onready variables
onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	parent.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(body):
	if parent.inputs.size() == 0:
		parent.update_state( "Idle" )
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
