extends Node

class_name LightJab1Charge


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var attack_buffer_ready : bool = false
export var return_to_idle: bool = false

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Light Jab 1 Charge"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(delta):
	if player.animation_player.current_animation != _state_name:
		player.animation_player.play("Light Jab 1 Charge")
	if Input.is_action_just_released("attack_left"):
		state.update_state("Light Jab 1 Release")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
