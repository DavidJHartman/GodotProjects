extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _process(delta):
	text = "Velocity: " + str(get_parent().Velocity.x) + "," + str(get_parent().Velocity.y) + "\nonGround: " + str(get_parent().onGround) + "\nstate: " + str(get_parent().playerState)
	pass
