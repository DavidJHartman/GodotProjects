extends Node2D

#variables necessary to define most orbital characteristics
var SemiMajorAxis := float(100000)
var Eccentricity := float(0)
var Inclination := float(0)

#variables acquired through analysis
var AverageAngularVelocity := float()
var MeanAnomaly := float()
var MeanAnomalyAtStart := float()
var EccentricAnomaly := float()
var TrueAnomaly := float()

var ArgumentOfPeriapsis := float()
var TimeOfPeriapsisPassage := float()
var LongitudeOfAscendingNode := float()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	MeanAnomaly = AverageAngularVelocity * SystemVariables.Time
	
	TrueAnomaly = MeanAnomaly
	TrueAnomaly += 2 * Eccentricity * sin( MeanAnomaly )
	TrueAnomaly += 1.25 * pow( Eccentricity, 2 ) * sin( MeanAnomaly * 2 )
	
	pass
