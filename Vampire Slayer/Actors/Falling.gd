extends Node

class_name Falling


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Falling"
var _coyote_time = 7
var _fall_timer = 0

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update():
	_fall_timer += 1
	if _fall_timer <= _coyote_time:
		if state.motion_direction.y == 1:
			state.update_state("Jump")
			pass
	player.deltav.y += player.GRAVITY
	player.velocity += player.deltav
	
	player.move_and_slide( player.velocity, Vector2(0,-1) )
	if player.is_on_floor():
		state.update_state("Idle")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
