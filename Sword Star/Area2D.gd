extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var blink_distance = 50
var move_speed = 70
var blink_speed = 10 #number of frames
var Gravity = .5
var jump_strength = -4

var direction = Vector2()
var deltaP = Vector2()
var Velocity = Vector2(0,0)
var place_in_blink

enum { idle, walk, blink, jump }
var playerState

onready var camera = $PlayerCamera
onready var sprite = $player_sprite
onready var animation = $player_sprite/animation
onready var sword = $player_sprite/handle

func blink(delta):
	position += direction * (blink_distance / blink_speed)
	place_in_blink = place_in_blink + 1
	if place_in_blink == blink_speed:
		playerState = walk
	pass

func jump(delta):
	position += deltaP * delta
	Velocity.y += Gravity
	if sprite.get("Position") == 0:
		playerState = walk

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	place_in_blink = 1
	pass

func _process(delta):
	
	if playerState == blink:
		blink(delta)
		return
	place_in_blink = 0
	
	if playerState == jump:
		jump(delta)
		sprite.set("Gravity", .25)
		return
	
	position += deltaP * delta
	direction = Vector2()
	
	if Input.is_action_pressed( "move_up" ):
		direction.y -= 1
		playerState = walk
	if Input.is_action_pressed( "move_down"):
		direction.y += 1
		playerState = walk
	if Input.is_action_pressed( "move_left" ):
		direction.x -= 1
		playerState = walk
	if Input.is_action_pressed( "move_right" ):
		direction.x += 1
		playerState = walk
	if Input.is_action_just_pressed( "blink" ):
		playerState = blink
	if Input.is_action_just_pressed( "jump" ):
		sprite.jump(jump_strength)
		playerState = jump
	
	direction.normalized()
	
	if direction == Vector2( 0, 0 ):
		playerState = idle
	
	if playerState == walk:
		if sprite.get("Position") == 0:
			sprite.jump(-1)
			animation.play("walk")
	if playerState == blink:
		animation.play("blink")
	if playerState == jump:
		animation.play("jump")
	direction.normalized()
	deltaP = direction * move_speed
	pass
