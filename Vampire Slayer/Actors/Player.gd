
class_name Player
extends KinematicBody2D

var GRAVITY
var SLOW_GRAVITY

#public variables
var initial_state : String
var facing_right : bool
var deltav = Vector2(0,0)
var velocity = Vector2(0,0)
var jump_speed
var walking_speed = 35
var running_speed = 50
var dash_speed = 70
var max_speed = 250
var max_fall_speed = 600
var ground_friction = 0.4
var air_friction = 0.8
var air_speed = 15

var dragon_punch_speed = 400

#private variables
var jump_height = 5
var jump_distance = 6
var block_dimension = 16


#onready variables
onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_speed = (2 * (jump_height * block_dimension) * (jump_distance * block_dimension))/((jump_distance * block_dimension)/2)
	SLOW_GRAVITY = (-2 * (jump_height * block_dimension) * pow((jump_distance * block_dimension),2))/(pow((jump_distance * block_dimension)/2, 2))
	GRAVITY = 3*SLOW_GRAVITY
	print(SLOW_GRAVITY)
	print(jump_speed)
	initial_state = "Idle"
	facing_right = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
