extends Node

var listOfActions := Array()

class Action:
	
	var Name := String()
	var Cost := int()
	var Requires := Array()
	
	var Children := Array()
	var Parent
	
	#if Sets.length() == 0, Action is base of tree
	var Sets := Array()
	
	# stores an instance of a node with script to run
	var ToTake
	
	func update():
		ToTake.update()
	
	func _init( Name : String, Cost : int, ToTake ):
		self.Name = Name
		self.Cost = Cost
		self.ToTake = ToTake
	
	func populateRequirementsList( requires : Array, listOfActions : Array ):
		for action in listOfActions:
			for requirement in requires:
				
				var inSet = false
				
				for sets in action.sets:
					if requirement == sets:
						inSet = true
						break
				if inSet == false:
					break
				
				Children.push_back(action)