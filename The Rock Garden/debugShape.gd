tool

extends Node2D


export var NumberOfPoints := int()
export var LineColor := Color()
export var Radius := float()
var SideLength := int()


func _draw():
	var angleBetweenPoints = 2 * PI / NumberOfPoints
	var fromAngle = 0
	for x in NumberOfPoints:
		var toAngle = fromAngle + angleBetweenPoints
		var points = Array()
		points.push_back( Radius * Vector2( sin( fromAngle), cos( fromAngle ) ) )
		points.push_back( Radius * Vector2( sin( toAngle ), cos( toAngle ) ) )
		draw_line( points[0], points[1], Color.white )
		fromAngle = toAngle
	pass

func _ready( lineColor = Color.white, radius = 10.0 ):
	LineColor = lineColor
	Radius = radius
	SideLength = 2.0 * Radius * sin( 180.0 / float(NumberOfPoints) )
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
