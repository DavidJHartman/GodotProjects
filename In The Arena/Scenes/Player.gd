extends KinematicBody2D

onready var anim = $sprite/AnimHandler
onready var weapon = $sprite/Weapon
onready var state_handler = $stateProcess
onready var hitbox = $Hitbox
onready var stunTimer = $StunTimer

var Velocity = Vector2(0,0)
var DeltaV = Vector2()
var facing = Vector2()
var maxSpeed = 70
var moveSpeed = 400
var sprintMultiplier = 3

var stunned = false
var dead = false
var health = 30


var moveTowardsTarget = false
var initialState

var body = self

var swapDirection = 1
var equipment = Array()

# ai specific variables
export var AI = false
var target

var parryOn : int
var parryOff : int
var parryCounter : int

onready var state_dictionary = {
	'idle' : $stateProcess/idle,
	'move' : $stateProcess/move
}

func _ready():
	weapon.holder = self
	if AI:
		GOAP()
		parryOn = (randi()%20)+1
		parryOff = 60
		parryCounter = 0
	else:
		state_handler.state_dictionary = state_dictionary
		initialState = 'idle'

func _process(delta):
	if health == 0:
		dead = true

	if dead:
		anim.play("dead")
		return
	
	if stunned:
		anim.play("stunned")
		weapon.placeInCombo = 0
		yield($StunTimer, "timeout")
	
	if !AI:
		var unitVector
		facing = get_global_mouse_position() - position
		var mag = sqrt( pow(facing.x,2) + pow(facing.y,2))
		facing /= mag
		weapon.set_angle(atan2(facing.y, facing.x) + PI/2)
	
	else:
		
		# Aim at the target
		if target:
			facing = target.position - position
			var mag = sqrt( pow(facing.x,2) + pow(facing.y,2))
			facing /= mag
			facing.y *= -1
			weapon.set_angle(atan2(facing.x, facing.y))
	
	# Process movement
	Velocity += DeltaV * delta
	if abs(Velocity.x) > moveSpeed:
		Velocity.x == moveSpeed * sign(Velocity.x)
	if abs(Velocity.y) > moveSpeed:
		Velocity.y == moveSpeed * sign(Velocity.y)
	
	# Calculate friction coefficients
	if DeltaV == Vector2():
		Velocity *= .5
	else:
		Velocity *= .9
	#Stop moving when slow enough
	if abs(Velocity.x) < .01:
		Velocity.x = 0
	if abs(Velocity.y) < .01:
		Velocity.y = 0
	move_and_slide(Velocity)

func inputProcessing():
	DeltaV = Vector2(0,0)
	if Input.is_action_pressed('up'):
		DeltaV.y -= 1
	if Input.is_action_pressed('down'):
		DeltaV.y += 1
	if Input.is_action_pressed('right'):
		DeltaV.x += 1
	if Input.is_action_pressed('left'):
		DeltaV.x -= 1
	DeltaV.normalized()
	DeltaV *= moveSpeed
	if Input.is_action_pressed('sprint'):
		DeltaV *= sprintMultiplier
	if Input.is_action_just_pressed("leftClick"):
		weapon.attack()
	if Input.is_action_just_pressed("rightClick"):
		weapon.parry()

func rangetotarget():
	
	var p = target.position - position
	var mag  = sqrt( p.x * p.x + p.y * p.y )
	
	return mag

func walk_to():
	
	anim.play("walk")
	
	if !target:
		return false
	var p = target.position - position
	var mag  = sqrt( p.x * p.x + p.y * p.y )
	facing = p/mag
	
	if rangetotarget() > 50:
		DeltaV = facing * body.moveSpeed * sprintMultiplier
	else:
		return true
	return false

func find_target():
	var enemies = get_tree().get_nodes_in_group("actors")
	var closestEnemy
	var closestDistance = 99999999
	body.target = null
	for enemy in enemies:
		if enemy != body and !enemy.dead:
			
			var p = enemy.position - body.position 
			var mag = sqrt( p.x * p.x + p.y * p.y )
			if mag < closestDistance:
				closestDistance = mag
				closestEnemy = enemy
	
	body.target = closestEnemy
	return true

func melee_attack():
	DeltaV = Vector2(0,0)
	if target.dead:
		target = null
	if target != null:
		var p = target.position - position
		var mag  = sqrt( p.x * p.x + p.y * p.y )
		facing = p/mag
	
		var dot =  facing.x * target.facing.x + facing.y * target.facing.y
	
		var H = ((dot/2+1) * weapon.hitChance())
		
		
		parryCounter += 1
		if parryCounter < parryOn and weapon.anim.current_animation == "Idle":
			if target.weapon.anim.is_playing():
				weapon.parry()
				return false
		if parryCounter == parryOff:
			parryCounter = 0
		if randi()%100 < H and weapon.readyToQueue:
			weapon.attack()
		if !weapon.readyToQueue:
			DeltaV = facing * (body.moveSpeed * sprintMultiplier)
		elif weapon.anim.current_animation == "Idle":
			if randi()%10<8:
				var temp = facing
				var angle = (PI/2)
				facing.x = temp.x * cos(angle) - temp.y * sin(angle)
				facing.y = temp.x * sin(angle) + temp.y * cos(angle)
				DeltaV = facing * (body.moveSpeed)
	
	if Velocity != Vector2(0,0):
		anim.play("walk")
	
	return true

func idle():
	DeltaV = Vector2()
	moveTowardsTarget = false
	if anim.current_animation != "idle":
		anim.play("idle")
	return false

func GOAP():
	var start_time = OS.get_unix_time()
	#var count = 0
	var action_planner = get_node("GOAPActionPlanner")
	if !action_planner:
		pass
	while 1:
		if dead:
			return
		#count += 1
		if $StunTimer.is_stopped() == false:
			break
		var plan : Array = action_planner.plan(calculate_state(), calculate_goal())
		for action in plan:
			
			var error = false
			
			if has_method( action ):
				var status = call(action)
				while status is GDScriptFunctionState:
					status = yield(status, "completed")
				if typeof(status) != TYPE_BOOL:
					print("Return value of "+action+" is not a boolean")
					status = false
				error = !status
			else:
				print("Cannot perform action "+action)
				error = true
			if error: break
			$Timer.start()
			yield($Timer, "timeout")
		$Timer.start()
		yield($Timer, "timeout")

func calculate_goal():
	var goal = ""
	goal = "kill_target "
	
	if goal == "":
		goal = "idle "
	
	return goal

func calculate_state():
	var state = ""
	
	if target:
		state += "has_target "
	else:
		state += "!has_target "
	
	return state

func _on_ChangeDirection_timeout():
	swapDirection *= -1
	pass # Replace with function body.

func _on_StunTimer_timeout():
	stunned = false
	weapon.reset()
	target = null
	DeltaV = Vector2()
	GOAP()
	pass # Replace with function body.
