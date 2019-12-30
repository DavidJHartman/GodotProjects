extends Node2D
var unitVector = Vector2()
var screensize = Vector2()

var weaponName = String()
export var placeInCombo = 0
export var readyToQueue = false

var weaponFacingChance = {"Sword": 65}
var weaponDamage = {"Sword": 2}
var comboLengths = {"Sword": 2}

onready var anim = $AnimHandler
onready var hitbox = $Sprite/hitbox
onready var holder = null
# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	add_to_group('weapons')
	weaponName = "Sword"
	pass # Replace with function body.

func hitChance():
	return weaponFacingChance[weaponName]

func reset():
	placeInCombo = 0
	anim.play("Idle")
	readyToQueue = true

func parry():
	anim.play(weaponName + "Parry")
	for weapon in get_tree().get_nodes_in_group("weapons"):
		if weapon == self:
			continue
		if hitbox.overlaps_area( weapon.hitbox ) and weapon.placeInCombo != 0:
			if weapon.holder:
				weapon.holder.stunned = true
				weapon.holder.stunTimer.start()

func attack():
	if !readyToQueue:
		return
	
	placeInCombo+=1
	anim.play(weaponName + "Attack" + String(placeInCombo))
	if placeInCombo == comboLengths[weaponName]:
		placeInCombo = 0
	
	for actor in get_tree().get_nodes_in_group("actors"):
		if actor == holder:
			continue
		if hitbox.overlaps_area( actor.collisionShape ):
			actor.health -= 1

func _process(delta):
	
	pass

func set_angle(theta):
	rotation = theta