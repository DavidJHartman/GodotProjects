extends Node

var Time := float()
var G := float(6.67249e-11)
var StandardMass := float( 5.972e24 )

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_path())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
