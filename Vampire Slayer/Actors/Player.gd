
class_name Player
extends KinematicBody2D

const GRAVITY = 7

#public variables
var initial_state : String
var facing_right : bool
var deltav = Vector2(0,0)
var velocity = Vector2(0,0)
var jump_speed = 600
var walking_speed = 35
var running_speed = 50
var dash_speed = 70
var max_speed = 250
var max_fall_speed = 120
var ground_friction = 0.4
var air_friction = 0.8

#private variables


#onready variables
onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_state = "Idle"
	facing_right = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
