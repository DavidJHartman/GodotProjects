extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ASTEROID_SIZES = [50, 100, 150]
var CenterOfMass = Vector2(0,0)

var GRAVITY = 15

# Called when the node enters the scene tree for the first time

onready var sphereOfInfluence = $map/GravitationalField

func gradient( var asteroidSize, var point ):
	var distance = sqrt(pow(point.x-ASTEROID_SIZES[asteroidSize]/2,2) + pow(point.y-ASTEROID_SIZES[asteroidSize]/2,2))
	return (distance/(ASTEROID_SIZES[asteroidSize]/2))

func get_gravity_vector( var Position ):
	
	var localized = Position - CenterOfMass
	localized /= sqrt(pow(localized.x,2)+pow(localized.y,2))
	
	localized *= GRAVITY
	
	return localized


func generateAsteroid( var inputSeed, var asteroidSize ):
	
	var asteroidBody = OpenSimplexNoise.new()
	asteroidBody.seed = randi()
	asteroidBody.octaves = 8
	asteroidBody.period = 256.0
	asteroidBody.persistence = .4
	asteroidBody.lacunarity = 4
	
	var asteroidNoise = OpenSimplexNoise.new()
	asteroidNoise.seed = randi()
	asteroidNoise.octaves = 1
	asteroidNoise.period = 8.0
	asteroidNoise.persistence = 0.0
	asteroidNoise.lacunarity = 4
	
	var numberOfBlocks = 0
	
	var occupied = []
	for x in range( ASTEROID_SIZES[asteroidSize] ):
		occupied.append( [] )
		for y in range( ASTEROID_SIZES[asteroidSize] ):
			var noiseAtPoint = asteroidBody.get_noise_2d(x,y)
			
			if ( ( noiseAtPoint - gradient( asteroidSize, Vector2(x,y) ) ) > -0.5 ):
				occupied[x].append(1)
				numberOfBlocks+=1
				CenterOfMass += Vector2(x,y)
			else:
				occupied[x].append(0)
	
	for x in range( ASTEROID_SIZES[asteroidSize] ):
		for y in range( ASTEROID_SIZES[asteroidSize] ):
			set_cellv(Vector2(x,y),-1)
			if (occupied[x][y] == 1):
				set_cellv(Vector2(x,y),0)
	CenterOfMass /= numberOfBlocks
	sphereOfInfluence.position = CenterOfMass * 16
	
	update_bitmask_region()

func _ready():
	randomize()
	generateAsteroid( 0, 1 )
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (Input.is_action_pressed("ui_accept")):
		
		generateAsteroid( 0, 1 )
	pass
