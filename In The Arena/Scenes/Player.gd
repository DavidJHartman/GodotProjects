extends KinematicBody2D

onready var anim = $sprite/AnimHandler
onready var weapon = $sprite/Weapon
onready var state_handler = $stateProcess

var Velocity = Vector2(0,0)
var DeltaV = Vector2()
var maxSpeed = 70
var moveSpeed = 500

var initialState

var body = self

# ai specific variables
export var AI = false
var target

onready var state_dictionary = {
	'idle' : $stateProcess/idle,
	'move' : $stateProcess/move
}

onready var ai_state_dictionary = {
	'ai_idle' : $stateProcess/ai_idle,
	'ai_search' : $stateProcess/ai_search,
	'ai_walk' : $stateProcess/ai_walk,
}

func _ready():
	if AI:
		state_handler.state_dictionary = ai_state_dictionary
		initialState = 'ai_idle'
	else:
		state_handler.state_dictionary = state_dictionary
		initialState = 'idle'

func _process(delta):
	Velocity += DeltaV * delta
	Velocity *= .9
	if abs(Velocity.x) < 1:
		Velocity.x = 0
	if abs(Velocity.y) < 1:
		Velocity.y = 0
	move_and_slide(Velocity)

func inputProcessing():
	DeltaV = Vector2(0,0)
	if Input.is_action_pressed('up'):
		DeltaV.y -= moveSpeed
	if Input.is_action_pressed('down'):
		DeltaV.y += moveSpeed
	if Input.is_action_pressed('right'):
		DeltaV.x += moveSpeed
	if Input.is_action_pressed('left'):
		DeltaV.x -= moveSpeed
	pass