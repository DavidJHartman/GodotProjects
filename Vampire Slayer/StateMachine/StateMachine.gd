extends Node

#constants

enum {
	JUST_PRESSED = 0,
	HELD = 1,
	JUST_RELEASED = 2,
	RELEASED = 3
}

var MOTION_INPUTS = {
	
	["Down","DownRight","Right"]: "QCR",
	["Down","DownLeft","Left"]: "QCL",
	["Right","DownRight","Down","DownLeft","Left"]:"HCL",
	["Left","DownLeft","Down","DownRight","Right"]:"HCR",
	["Right","Down","DownRight"]: "DPR",
	["Right","Neutral","Down","DownRight"]: "DPR",
	["Left","Down","DownLeft"]: "DPL",
	["Left","Neutral","Down","DownLeft"]: "DPL",
	
}
var directions = [
	["DownLeft","Down","DownRight"],
	["Left","Neutral","Right"],
	["UpLeft","Up","UpRight"],	
]




#public variables
var state_dictionary : Dictionary
# inputs and how long they've been held
var inputs : Dictionary
var motion_direction = Vector2(0.0,0.0)

#private variables
var _hold_frames : int = 5 #time to transition from a press to a hold
var _keys
var _motion_input_buffer : Array
var _motion_input_frame_reset : int = 7
var _motion_input_current_frame = 0
var _current_state
var _input_just_happened = false
var charge = false

#onready variables
onready var player = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	inputs["Up"] = 0
	inputs["Down"] = 0
	inputs["Left"] = 0
	inputs["Right"] = 0
	_current_state = get_parent().initial_state
	pass # Replace with function body.

func _process(delta):
	_input_just_happened = false
	if Input.is_action_just_pressed("move_up"):
		_input_just_happened = true
		motion_direction.y += 1
	elif Input.is_action_just_released("move_up"):
		_input_just_happened = true
		motion_direction.y -= 1
	
	if Input.is_action_just_pressed("move_down"):
		_input_just_happened = true
		motion_direction.y -= 1
	elif Input.is_action_just_released("move_down"):
		_input_just_happened = true
		motion_direction.y += 1
	
	if Input.is_action_just_pressed("move_right"):
		if Input.is_action_pressed("move_left"):
			charge = true
		else:
			_input_just_happened = true
			motion_direction.x += 1
	elif Input.is_action_just_released("move_right"):
		_input_just_happened = true
		if charge == false:
			motion_direction.x -= 1
		elif charge == true and motion_direction.x == 1:
			motion_direction.x = -1
		charge = false
	
	if Input.is_action_just_pressed("move_left"):
		if Input.is_action_pressed("move_right"):
			charge = true
		else:
			_input_just_happened = true
			motion_direction.x -= 1
	elif Input.is_action_just_released("move_left"):
		_input_just_happened = true
		if charge == false:
			motion_direction.x += 1
		elif charge == true and motion_direction.x == -1:
			motion_direction.x = 1
		charge = false
	
	if _input_just_happened:
		_motion_input_current_frame = 0
		_motion_input_buffer.append(directions[motion_direction.y+1][motion_direction.x+1])
	
	for motion_input in MOTION_INPUTS:
		if motion_input == _motion_input_buffer:
			print("")
	
	if _motion_input_current_frame == _motion_input_frame_reset:
		_motion_input_buffer.clear()
	
	_keys = inputs.keys()
	_motion_input_current_frame += 1

func update_state( new_state ):
	_current_state = new_state
