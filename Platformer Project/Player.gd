extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var Velocity = Vector2()
#var Gravity = Vector2(0,9.8)
var Gravity = Vector2( 0, 5 )

var moveSpeed = 5
var moveSpeedLimit = 70
var jumpStrength = 225
var friction = 0
var onGround = bool()
var playerState
var airMoveFactor = .4

enum { walk, walking, idle, jump, rising, fall, falling, landed }

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
onready var floorColliderRay = $floorCast

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	
	Velocity += Gravity
	move_and_slide( Velocity, Vector2(0, -1) )
	if is_on_floor():
		onGround = true
		Velocity.y = 0
	else:
		onGround = false
	
	# animation state calculation
	if Velocity.x != 0 and onGround:
		if playerState != walking:
			playerState = walk
	if Velocity.x == 0 and onGround:
		playerState = idle
	if playerState == rising and Velocity.y > 0:
		playerState = fall
	
	var deltaV = Vector2()
	
	if Input.is_action_pressed( "move_left" ):
		deltaV.x -= moveSpeed if onGround else moveSpeed * airMoveFactor
	elif Input.is_action_pressed( "move_right" ):
		deltaV.x += moveSpeed if onGround else moveSpeed * airMoveFactor
	else:
		if onGround:
			Velocity.x *= friction
			if Velocity.x < .1:
				Velocity.x = 0
	if Input.is_action_pressed( "jump" ) and onGround:
		deltaV.y = -jumpStrength
		playerState = jump
	
	if Velocity.x < 0:
		sprite.flip_h = true
	if Velocity.x > 0:
		sprite.flip_h = false
	
	if Velocity.y > 0 and playerState == fall:
		deltaV.y += 70
	
	
	# Animation State Handling
	if playerState == idle:
		animPlayer.play("Idle")
	elif playerState == walk:
		animPlayer.play("Walk")
		playerState = walking
	elif playerState == jump:
		animPlayer.play("Jump")
		playerState = rising
	elif playerState == fall:
		animPlayer.play("falling")
		playerState = falling
	
	
	
	Velocity += deltaV
	if Velocity.x > moveSpeedLimit:
		Velocity.x = moveSpeedLimit
	elif Velocity.x < -moveSpeedLimit:
		Velocity.x = -moveSpeedLimit
	
	pass
