extends "res://GOAP.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var body = get_parent().bodyToActOn

func _init() :
	addEffect('foundTarget', false)

# Called when  node enters the scene tree for the first time.
func process():
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
	return 'ai_walk'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
