extends Node

class_name SwordJab1


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
var _state_name = "SwordJab1"
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
	if player.animation_player.current_animation != "SwordJab1":
		player.animation_player.play("SwordJab1")
		_charging = false
		_charge_counter = 0
	if Input.is_action_pressed("attack_left") :
		_charge_counter += 1
		if _charge_counter == 30:
			state.update_state("Light Jab 1 Charge")
			pass
	if Input.is_action_just_pressed("attack") and _charge_counter < 20 and attack_buffer_ready:
		_charging = false
		_charge_counter = 0
		state.update_state("SwordJab2")
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
