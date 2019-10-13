extends KinematicBody2D

onready var anim = $sprite/AnimHandler
onready var weapon = $sprite/Weapon
onready var state_handler = $stateProcess

var Velocity = Vector2(0,0)
var DeltaV = Vector2()
var maxSpeed = 70
var moveSpeed = 500

var moveTowardsTarget = false
var initialState

var body = self

var equipment = Array()

# ai specific variables
export var AI = false
var target

onready var state_dictionary = {
	'idle' : $stateProcess/idle,
	'move' : $stateProcess/move
}

func _ready():
	if AI:
		GOAP()
	else:
		state_handler.state_dictionary = state_dictionary
		initialState = 'idle'

func _process(delta):
	if AI:
		if moveTowardsTarget:
			print(target.position)
			var p = target.position - position
			var mag  = sqrt( p.x * p.x + p.y * p.y )
			var normalizedDir = p/mag
			DeltaV = normalizedDir * body.moveSpeed
		else:
			DeltaV = Vector2()
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

func rangetotarget():
	
	var p = target.position - position
	var mag  = sqrt( p.x * p.x + p.y * p.y )
	
	return mag

func walk_to():
	
	if rangetotarget() < 20:
		moveTowardsTarget = false
	
	if anim.current_animation != "walk":
		anim.play("walk")
	moveTowardsTarget = true
	return false

func find_target():
	var enemies = get_tree().get_nodes_in_group("actors")
	var closestEnemy
	var closestDistance = 99999999
	for enemy in enemies:
		if enemy == body:
			continue
		var p = enemy.position - body.position 
		var mag = abs(sqrt( p.x * p.x + p.y * p.y ))
		if mag < closestDistance:
			closestEnemy = enemy
	body.target = closestEnemy
	return true

func GOAP():
	var start_time = OS.get_unix_time()
	#var count = 0
	var action_planner = get_node("GOAPActionPlanner")
	if !action_planner:
		pass
	while 1:
		#count += 1
		
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
	if target and rangetotarget() > 20:
		goal = "in_range "
	
	return goal

func calculate_state():
	var state = ""
	
	if target:
		state += "has_target "
	else:
		state += "!has_target "
	
	return state