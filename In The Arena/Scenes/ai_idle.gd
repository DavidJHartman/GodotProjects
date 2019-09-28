extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update(body):
	
	if body.anim.current_animation != "idle":
		body.anim.play("idle")
	
	body.DeltaV = Vector2()
	return 'ai_search'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
