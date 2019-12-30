extends RichTextLabel

onready var actor = null


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = String( actor.stunned ) + '\n' + String( actor.health ) + '\n' + String( actor.DeltaV )
	pass
