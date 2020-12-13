extends Node

class_name DragonPunch

export var jump : bool = false
export var falling : bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#public variables
var cancellable = true
var breaks_momentum = false
var motion_input : String

#private variables
var _state_name = "Dragon Punch"

#onready variables
onready var state = get_parent()
onready var player = state.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	state.state_dictionary[_state_name] = self
	pass # Replace with function body.

func update():
	if !player.animation_player.current_animation == "Dragon Punch":
		jump = false
		player.animation_player.play("Dragon Punch")
		player.velocity = Vector2.ZERO
		player.deltav = Vector2.ZERO
	if jump:
		player.velocity.x = 10
		player.velocity.y = -player.dragon_punch_speed
	player.deltav.y += player.GRAVITY
	player.velocity += player.deltav
	player.move_and_slide(player.velocity, Vector2(0,-1))
	if falling:
		state.update_state("Falling")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
