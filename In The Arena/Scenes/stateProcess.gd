extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var body = get_owner()

var current_state = null
var state_name

var state_dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if current_state == null:
		current_state = body.initialState
		pass
	state_name = state_dictionary[current_state].update(body)
	if state_name:
		current_state = state_name
	return