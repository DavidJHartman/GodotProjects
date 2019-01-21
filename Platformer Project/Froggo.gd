extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer
onready var jumptimer = $jumpTimer
onready var hitbox = $hitbox.get_node("CollisionShape2D")
onready var gib = $gibs

var is_enemy = true
var dead = false

var Velocity = Vector2()
var Gravity = Vector2( 0, 5 )
var direction = -1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	
	if dead:
		sprite.visible = false
		$CollisionShape2D.disabled = true
		hitbox.disabled = true
		gib.emitting = true
		set_process(false)
		return
	
	Velocity += Gravity
	move_and_slide( Velocity, Vector2(0, -1) )
	
	
	
	if is_on_floor():
		animPlayer.play( "idle" )
		Velocity.x = 0
		hitbox.disabled = true
	
	if jumptimer.time_left == 0:
		sprite.flip_h = randi()%2
		direction = 1 if sprite.flip_h else -1
		animPlayer.play( "jump" )
		jumptimer.start()
		Velocity = Vector2( (randi()%76+25) * direction, -100 )
		hitbox.disabled = false
	
	pass


func _on_hitbox_body_entered(body):
	if body.get_name() == "Player":
		body.hit( 10 )
	pass # replace with function body

func hit( damage ):
	dead = true