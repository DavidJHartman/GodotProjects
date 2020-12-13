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
	player.animation_player.play("Idle")
	player.velocity.y = 0
	player.deltav.y = 0
	
	match motion_input:
		"DPR":
			state.update_state("Dragon Punch")
			pass
		"DPL":
			state.update_state("Dragon Punch")
			pass
	
	if Input.is_action_just_pressed("attack"):
		state.update_state("Light Jab 1")
		pass
	
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
