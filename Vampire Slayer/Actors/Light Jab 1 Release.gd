extends Node

class_name LightJab1Release

export var attack_buffer_ready : bool = false
export var return_to_idle: bool = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Light Jab 1 Release"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(delta):
	if return_to_idle:
		state.update_state("Idle")
		return_to_idle = false
		return
	if player.animation_player.current_animation != _state_name:
		player.animation_player.play(_state_name)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
