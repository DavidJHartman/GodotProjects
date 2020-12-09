extends Node

#constants

var MOTION_INPUTS = {
	
	["Down","DownRight","Right"]: "QCR",
	["Down","DownLeft","Left"]: "QCL",
	["Right","DownRight","Down","DownLeft","Left"]:"HCL",
	["Left","DownLeft","Down","DownRight","Right"]:"HCR",
	
}


#public variables
var state_dictionary : Dictionary
# inputs and how long they've been held
var inputs : Dictionary

#private variables
var _hold_frames : int = 5 #time to transition from a press to a hold
var _keys
var _motion_input_buffer : Array
var _motion_input_frame_reset : int = 15
var _motion_input_current_frame = 0
var _current_state

#onready variables

# Called when the node enters the scene tree for the first time.
func _ready():
	inputs["Up"] = 0
	inputs["Down"] = 0
	inputs["Left"] = 0
	inputs["Right"] = 0
	_current_state = get_parent().initial_state
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		inputs[event.as_text()] = 1
	
	if inputs["Down"] > 0 and inputs["Left"] > 0 and !_motion_input_buffer.has("DownLeft"):
		_motion_input_buffer.append("DownLeft")
		_motion_input_current_frame = 0
	elif inputs["Down"] > 0 and inputs["Right"] > 0 and !_motion_input_buffer.has("DownRight"):
		_motion_input_buffer.append("DownRight")
		_motion_input_current_frame = 0
	elif inputs["Up"] > 0 and inputs["Left"] > 0 and !_motion_input_buffer.has("UpLeft"):
		_motion_input_buffer.append("UpLeft")
		_motion_input_current_frame = 0
	elif inputs["Up"] > 0 and inputs["Right"] > 0 and !_motion_input_buffer.has("UpRight"):
		_motion_input_buffer.append("UpRight")
		_motion_input_current_frame = 0
	elif inputs["Down"] > 0 and !_motion_input_buffer.has("Down"):
		_motion_input_buffer.append("Down")
		_motion_input_current_frame = 0
	elif inputs["Up"] > 0 and !_motion_input_buffer.has("Up"):
		_motion_input_buffer.append("Up")
		_motion_input_current_frame = 0
	elif inputs["Left"] > 0 and !_motion_input_buffer.has("Left"):
		_motion_input_buffer.append("Left")
		_motion_input_current_frame = 0
	elif inputs["Right"] > 0 and !_motion_input_buffer.has("Right"):
		_motion_input_buffer.append("Right")
		_motion_input_current_frame = 0
	
	if event is InputEventKey and !event.pressed:
		inputs[event.as_text()] = 0
	
	for motion_input in MOTION_INPUTS.keys():
		if motion_input == _motion_input_buffer:
			print(MOTION_INPUTS[motion_input])
			_motion_input_current_frame = _motion_input_frame_reset
	
	if _motion_input_current_frame == _motion_input_frame_reset:
		_motion_input_buffer.clear()
	
	_keys = inputs.keys()
	_motion_input_current_frame += 1
func update_state( new_state ):
	_current_state = new_state

func _process(delta):
	
	pass
