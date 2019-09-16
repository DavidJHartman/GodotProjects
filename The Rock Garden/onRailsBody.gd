extends Node2D

export var Static := bool(false)
export var mass := float()

#variables necessary to define most orbital characteristics
export var SemiMajorAxis := float(0)
export var Eccentricity := float(0.001)
export var Inclination := float(0)

var Position := Vector2()

#variables acquired through analysis
var AverageAngularVelocity := float()
var MeanAnomaly := float()
var MeanAnomalyAtStart := float()
var EccentricAnomaly := float()
var TrueAnomaly := float()

var ArgumentOfPerihelion := float()
var TimeOfPeriapsisPassage := float()
var LongitudeOfAscendingNode := float()

# Called when the node enters the scene tree for the first time.
func _ready():
	if Static:
		return
	
	AverageAngularVelocity = SystemVariables.G * SystemVariables.StandardMass * get_parent().mass
	AverageAngularVelocity /= pow( SemiMajorAxis, 2 )
	AverageAngularVelocity = sqrt(AverageAngularVelocity)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Static:
		pass
	
	MeanAnomaly = AverageAngularVelocity * SystemVariables.Time
	
	EccentricAnomaly = MeanAnomaly + Eccentricity * sin( MeanAnomaly ) * (1.0 + Eccentricity * cos( MeanAnomaly ) )
	
	TrueAnomaly = 2 * atan2( sqrt(1+Eccentricity) * sin( Eccentricity / 2), sqrt( 1 - Eccentricity ) * cos( Eccentricity/2) )
	
	##########################
	
	
	var l = SemiMajorAxis * (1.0 - pow(Eccentricity, 2))
	var c = cos(TrueAnomaly)
	var s = sin(TrueAnomaly)
	var r = l / (1.0 + Eccentricity * c)
	var rprime = s * r * r / l
	var position = 
	
	
	##########################
	
	
	var dist = SemiMajorAxis * ( 1 - Eccentricity * cos(EccentricAnomaly) )
	
	var xv = SemiMajorAxis * (cos ( EccentricAnomaly ) - Eccentricity )
	var yv = SemiMajorAxis * ( sqrt( 1.0 - pow( Eccentricity, 2 )) * sin( Eccentricity ) )
	
	var v = atan2( yv, xv )
	var r = sqrt( xv * xv + yv * yv )
	
	Position.x = SemiMajorAxis * ( cos( LongitudeOfAscendingNode ) * cos( v + ArgumentOfPerihelion ) - sin( LongitudeOfAscendingNode ) * sin( v + ArgumentOfPerihelion ) * cos( 0 ) )
	Position.y = SemiMajorAxis * ( sin( LongitudeOfAscendingNode ) * cos( v + ArgumentOfPerihelion ) + cos( LongitudeOfAscendingNode ) * sin( v + ArgumentOfPerihelion ) * cos( 0 ) )
	
	position = Position / 1e3
	
	pass