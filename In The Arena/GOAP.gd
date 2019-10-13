extends Node

var requirements := Dictionary()
var effects := Dictionary()

# In the event a function needs to be performed on an object
var target
var in_range := bool(false)

func checkWorldState():
	pass

func deleteRequirements():
	requirements = Dictionary()

func deleteEffects():
	effects = Dictionary()

func complete():
	pass

func process():
	pass

func addRequirement( name : String, condition ):
	requirements[name] = condition
	pass
func addEffect( name, condition ):
	effects[name] = condition
	pass

func deleteRequirement( name ):
	while requirements.has( name ):
		requirements.erase( name )
	pass

func deleteEffect( name ):
	while effects.has( name ):
		effects.erase( name )
	pass