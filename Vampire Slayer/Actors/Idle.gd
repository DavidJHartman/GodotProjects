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

func update(delta):
	player.animation_player.play("Idle")
	match motion_input:
		"DPR":
			state.update_state("Dragon Punch")
			pass
		"DPL":
			state.update_state("Dragon Punch")
			pass
	
	if Input.is_action_just_pressed("attack"):
		state.update_state("SwordJab1")
		pass
	
	if !player.is_on_floor():
		state.update_state("Falling")
		pass
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state.update_state("Walking")
		pass
	else:
		player.velocity = Vector2.ZERO
		player.deltav = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		state.update_state("Jump")
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
