extends Timer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	wait_time = 1 + ((randf()*2.0))
	one_shot = true
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
