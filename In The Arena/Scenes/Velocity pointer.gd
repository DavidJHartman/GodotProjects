extends Node2D

var center = Vector2()
var radius = 1
var color = Color(1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	
	draw_circle(center, radius, color)
	pass
