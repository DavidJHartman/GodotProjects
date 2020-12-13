extends Node

class_name Walking


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Walking"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass 

func update():
	player.deltav = Vector2.ZERO
	player.deltav.x = state.motion_direction.x * player.walking_speed
	if abs(player.velocity.x + player.deltav.x) < player.max_speed:
		player.velocity+=player.deltav
	else:
		player.velocity.x = player.max_speed * state.motion_direction.x
	
	if state.motion_direction.x == 0 and player.velocity.x != 0:
		player.velocity.x = floor(player.velocity.x * player.ground_friction)
		if abs(player.velocity.x) <= 1:
			player.velocity.x = 0
	player.deltav.y = player.GRAVITY
	
	player.move_and_slide_with_snap( player.velocity, Vector2(0,30), Vector2(0,-1) )
	
	# State Handling
	match motion_input:
		"Double Left":
			state.update_state("Dash")
			motion_input = ""
			pass
		"Double Right":
			state.update_state("Dash")
			motion_input = ""
			pass
	if !player.is_on_floor():
		state.update_state("Falling")
		pass
	else:
		player.velocity.y = 0
	if player.velocity == Vector2.ZERO:
		state.update_state( "Idle" )
		pass
	if state.motion_direction.y == 1:
		state.update_state("Jump")
		pass
	
	
	pass
