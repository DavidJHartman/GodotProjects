
class_name Player
extends Node2D

#public variables
var initial_state : String
var facing_right : bool

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
#func _process(delta):
#	pass
