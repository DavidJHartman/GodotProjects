extends Node

class_name DoubleJump

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Double Jump"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(delta):
	player.deltav.x = state.motion_direction.x * player.air_speed
	if abs(player.velocity.x + player.deltav.x) < player.max_speed:
		player.velocity+=player.deltav
	else:
		player.velocity.x = player.max_speed * state.motion_direction.x
	player.velocity.y = -player.jump_speed*2
	player.move_and_slide( player.velocity, Vector2(0,-1) )
	state.update_state("Falling")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
