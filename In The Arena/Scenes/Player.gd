extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim = $Sprite/AnimHandler

var playerState

var DeltaV = Vector2()
var Velocity = Vector2()
var movementSpeed = 1000
var maxSpeed = 70

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	Velocity += DeltaV * delta
	if abs(Velocity.x) > maxSpeed:
		if Velocity.x > 0:
			Velocity.x = maxSpeed
		else:
			Velocity.x = -maxSpeed
	if abs(Velocity.y) > maxSpeed:
		if Velocity.y > 0:
			Velocity.y = maxSpeed
		else:
			Velocity.y = -maxSpeed
	move_and_slide(Velocity)
	
	playerState = "Stationary"
	
	DeltaV = Vector2()
	if Input.is_action_pressed("up"):
		DeltaV.y -= movementSpeed
		playerState = "walk"
	if Input.is_action_pressed("down"):
		DeltaV.y += movementSpeed
		playerState = "walk"
	if Input.is_action_pressed("right"):
		DeltaV.x += movementSpeed
		playerState = "walk"
	if Input.is_action_pressed("left"):
		DeltaV.x -= movementSpeed
		playerState = "walk"
	if DeltaV.x == 0:
		Velocity.x = 0
	if DeltaV.y == 0:
		Velocity.y = 0
	
	anim.play(playerState)
	
	pass
