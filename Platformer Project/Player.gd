extends KinematicBody2D

# player state variables
var Health = 100.0
var previousHealth
var playerState
var nextAnim = true

# movement variables
var Velocity = Vector2()
var deltaV = Vector2()
var directionFacing = 1
var Gravity = Vector2( 0, 5 )
var moveSpeed = 5
var moveSpeedLimit = 70
var jumpStrength = 225
var friction = 0
var onGround = bool()
var airMoveFactor = .4

# timers for 
onready var damageTimer = $DamageTimer
onready var fallingTimer = $FallingGracePeriod

# player UI management
var healthbarOpacity = 0.0
var opacityChangeFactor = .02
onready var healthBar = $TextureProgress
var healthBarMaterial

enum { walking, idle, rising, falling, landed, damaged }

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	healthBarMaterial = healthBar.get_material()
	previousHealth = Health
	
	pass

func manage_health_bar():
	
	healthBar.set_value( Health )
	
	if previousHealth != Health:
		healthbarOpacity = 1.0
		deltaV.x = 0
		damageTimer.start()
	
	previousHealth = Health
	
	healthBarMaterial.set_shader_param( "opacity", healthbarOpacity )
	
	
	if playerState == idle:
		if healthbarOpacity < 1.0:
			healthbarOpacity += opacityChangeFactor
	if playerState != idle:
		if healthbarOpacity > 0:
			healthbarOpacity -= opacityChangeFactor
		if healthbarOpacity < 0:
			healthbarOpacity = 0

func _process(delta):
	
	Velocity += deltaV + Gravity
	
	move_and_slide( Velocity, Vector2(0, -1) )
	if is_on_floor():
		onGround = true
		Velocity.y = Gravity.y
	else:
		onGround = false
	
	
	#Velocity Calculation and clamping
	
	if Velocity.x > moveSpeedLimit:
		Velocity.x = moveSpeedLimit
	elif Velocity.x < -moveSpeedLimit:
		Velocity.x = -moveSpeedLimit
	
	# animation state calculation
	if damageTimer.time_left != 0:
		if playerState != damaged:
			Velocity.x = moveSpeed * 12 * -directionFacing
			Velocity.y = -150
			animPlayer.play("injured")
		playerState = damaged
		return
	
	deltaV = Vector2(0,0)
	
	# State calculation
	
	if Velocity.x == 0 and onGround:
		playerState = idle
	elif Velocity.x != 0 and onGround:
		playerState = walking
	elif abs(Velocity.y) < Gravity.y and !onGround:
		playerState = falling
	
	
	# MOVEMENT CALCULATION
	
	if Input.is_action_pressed( "move_left" ):
		deltaV.x -= moveSpeed if onGround else moveSpeed * airMoveFactor
		directionFacing = -1
	elif Input.is_action_pressed( "move_right" ):
		deltaV.x += moveSpeed if onGround else moveSpeed * airMoveFactor
		directionFacing = 1
	else:
		if onGround:
			Velocity.x *= friction
			if Velocity.x < .1:
				Velocity.x = 0
	if (Input.is_action_pressed( "jump" ) and onGround):
		deltaV.y = -jumpStrength
		playerState = rising
	
	if Velocity.x < 0:
		sprite.flip_h = true
	if Velocity.x > 0:
		sprite.flip_h = false
	
	#if playerState == fall:
		#Velocity.y = 70
	
	# Animation State Handling
	if playerState == idle:
		animPlayer.play("Idle")
	elif playerState == walking:
		if nextAnim:
			animPlayer.play("Walk")
			nextAnim = false
	elif playerState == rising:
		animPlayer.play("Jump")
	
	manage_health_bar()
	
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	nextAnim = true
	pass # replace with function body

func hit( damage ):
	Health -= damage

func _on_Area2D_body_entered(body):
	if body.get("is_enemy"):
		body.hit( 100 )
		Velocity.y = -jumpStrength/2
		playerState = rising
		
	pass # replace with function body
