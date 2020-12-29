extends Node

class_name SwordJab2


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var attack_buffer_ready : bool
export var return_to_idle: bool

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "SwordJab2"
var _charge_counter = 0
var _charging = false

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
	if player.animation_player.current_animation != "SwordJab2":
		player.animation_player.play("SwordJab2")
		_charging = false
		_charge_counter = 0
	if Input.is_action_pressed("attack") and attack_buffer_ready:
		_charging = true
	if Input.is_action_just_released("attack") and _charging:
		_charging = false
		if _charge_counter > state._motion_input_frame_reset:
			_charge_counter = 0
			print("Charge Attack")
		else:
			_charge_counter = 0
			state.update_state("SwordJab3")
			pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
