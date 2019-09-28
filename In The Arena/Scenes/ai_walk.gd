extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func update(body):
	
	var p = body.target.position - body.position
	var mag  = sqrt( p.x * p.x + p.y * p.y )
	
	if mag <= 20:
		return 'ai_idle'
	
	if body.anim.current_animation != "walk":
		body.anim.play("walk")
	
	var normalizedDir = p/mag
	body.DeltaV = normalizedDir * body.moveSpeed
	
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
