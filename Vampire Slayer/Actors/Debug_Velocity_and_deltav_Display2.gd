extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var state = get_node("../../StateMachine")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = String(state.player.velocity.x) + "," + String(state.player.velocity.y)
	text += "\n"
	text += String(state.player.deltav.x) + "," + String(state.player.deltav.y)
