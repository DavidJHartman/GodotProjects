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
	text = String(state.player.is_on_floor())
	pass
