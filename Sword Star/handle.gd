extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var blade = $blade
onready var tip  = $blade/tip
onready var collisionbox = $hitbox/shape

var bladeLength = 4
var collisionlengthscale = .5

var unitVector = Vector2(0,0)

var screensize = Vector2()

func set_angle():
	var mousePos = get_viewport().get_mouse_position() - screensize/2
	mousePos.normalized()
	mousePos.y *= -1
	unitVector = mousePos

func changeLength(deltaL):
	bladeLength += deltaL
	if bladeLength < 4:
		bladeLength = 4
	collisionbox.shape.set_extents( Vector2( 3 * collisionlengthscale, bladeLength * collisionlengthscale ) )
	

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	screensize = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	pass

func _process(delta):
	set_angle()
	rotation = atan2(unitVector.x, unitVector.y)
	pass
