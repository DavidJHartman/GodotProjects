extends Node

#constants

enum {
	JUST_PRESSED = 0,
	HELD = 1,
	JUST_RELEASED = 2,
	RELEASED = 3
}

var MOTION_INPUTS = {
	
	["Down","DownRight","Right","Attack"]: "QCR",
	["Down","DownLeft","Left","Attack"]: "QCL",
	["Right","DownRight","Down","DownLeft","Left","Attack"]:"HCL",
	["Left","DownLeft","Down","DownRight","Right","Attack"]:"HCR",
	["Right","Down","DownRight","Attack"]: "DPR",
	["Right","Neutral","Down","DownRight","Attack"]: "DPR",
	["Left","Down","DownLeft","Attack"]: "DPL",
	["Left","Neutral","Down","DownLeft","Attack"]: "DPL",
	["Right", "Right"]: "Double Right",
	["Left", "Left"]: "Double Left",
	["Down","DownRight","Right","Down","DownRight","Right","Attack"]: "DQCR",
	["Down","DownLeft","Left","Down","DownLeft","Left","Attack"]: "DQCL",
	
}
var directions = [
	["DownLeft","Down","DownRight"],
	["Left","Neutral","Right"],
	["UpLeft","Up","UpRight"],	
]




#public variables
var state_dictionary : Dictionary
var motion_direction = Vector2(0.0,0.0)


#private variables
var _hold_frames : int = 5 #time to transition from a press to a hold
var _keys
var _motion_input_buffer : Array
var _motion_input_frame_reset : int = 7
var _motion_input_current_frame = 0
var _current_state
var _input_just_happened
var _execute_motion_input
var _charge

#onready variables
onready var player = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	_charge = false
	motion_direction = Vector2(0,0)
	for key in state_dictionary.keys():
		print(key)
	pass # Replace with function body.

func _process(delta):
	input_handling()
	_current_state.update()

func _unhandled_input(event):
	if event.is_pressed() and !event.is_echo():
		_input_just_happened = true
	elif !event.is_pressed():
		_input_just_happened = true

func input_handling():
	motion_direction = Vector2.ZERO
	_execute_motion_input = false
	if Input.is_action_pressed("attack"):
		_motion_input_buffer.append("Attack")
		_execute_motion_input = true
	
	if Input.is_action_pressed("move_up"):
		motion_direction.y += 1
	
	if Input.is_action_pressed("move_down"):
		motion_direction.y -= 1
	
	if Input.is_action_just_pressed("move_right"):
		motion_direction.x += 1
	
	if Input.is_action_just_pressed("move_left"):
		motion_direction.x -= 1
	
	if (_motion_input_current_frame == _motion_input_frame_reset) or _execute_motion_input:
		for motion_input in MOTION_INPUTS:
			if motion_input == _motion_input_buffer:
				_current_state.motion_input = MOTION_INPUTS[motion_input]
		_motion_input_buffer.clear()
	
	if _input_just_happened:
		_input_just_happened = false
		_motion_input_current_frame = 0
		if motion_direction != Vector2.ZERO:
			_motion_input_buffer.append(directions[motion_direction.y+1][motion_direction.x+1])
	
	_motion_input_current_frame += 1

func update_state( new_state ):
	_current_state = state_dictionary[new_state]
