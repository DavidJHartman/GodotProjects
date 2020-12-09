
class_name Player
extends Node2D

#public variables
var initial_state : String

#private variables

#onready variables
onready var state_machine = $StateMachine
onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_state = "Idle"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
