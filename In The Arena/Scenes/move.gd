extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update(body):
	if body.anim.current_animation != "walk":
		body.anim.play("walk")
	body.inputProcessing()
	if body.Velocity == Vector2():
		return 'idle'
	return null
