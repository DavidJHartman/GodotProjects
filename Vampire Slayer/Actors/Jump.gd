extends Node

class_name Jump


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Jump"
var _ready = false
var _first_run = true

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update(delta):
	player.deltav = Vector2.ZERO
	
	if _first_run == true:
		_first_run = false
		player.velocity.y = -player.jump_speed
	
	if state.motion_direction.y == 0:
		_ready = true
	if Input.is_action_pressed("move_up"):
		player.deltav.y -= player.SLOW_GRAVITY * delta
	else:
		player.deltav.y -= player.GRAVITY * delta
	player.velocity += player.deltav
	if player.velocity.y > player.max_fall_speed:
		player.velocity.y = player.max_fall_speed
	if Input.is_action_pressed("move_left"):
		player.deltav.x -= player.air_speed * player.air_friction
	if Input.is_action_pressed("move_right"):
		player.deltav.x += player.air_speed * player.air_friction
	
	if abs(player.velocity.x + player.deltav.x) < player.max_run_speed:
		player.velocity.x+=player.deltav.x
	else:
		if Input.is_action_pressed("move_left"):
			player.velocity.x = -player.max_run_speed
		if Input.is_action_pressed("move_right"):
			player.velocity.x = player.max_run_speed
	if player.deltav.x == 0 and player.velocity.x != 0:
		player.velocity.x = floor(player.velocity.x)
		if abs(player.velocity.x) <= 1:
			player.velocity.x = 0
	
	player.move_and_slide( player.velocity, Vector2(0,-1) )
	
	if player.is_on_ceiling():
		_first_run = true
		player.velocity.y = 0
		state.update_state("Falling")
	if player.velocity.y == player.max_fall_speed:
		state.update_state("Falling")
		_first_run = true
		pass
	if state.motion_direction.y == 1 and _ready == true:
		_ready = false
		#state.update_state("Double Jump")
		_first_run = true
		pass
	if player.is_on_floor():
		_first_run = true
		state.update_state("Idle")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
