extends Node

var actions_available : Array
var bodyToActOn

func _ready():
	
	actions_available = get_children()
	bodyToActOn = get_parent()
	
	pass

var root = treeNode.new( null )

class treeNode :
	
	var action
	var parent
	var children : Array
	var cost
	
	func resetCost() :
		if action:
			cost = action.cost
		cost = 0
	
	func _init( action ):
		if action == null:
			pass
		self.action == action

func _process( delta ):
	if root == null:
		pass	

func plan( requirement : Array ) :
	
	root = treeNode.new( null )
	
	recursiveTreeGen( root , requirement )
	
	pass

func findOptimalPath( node ) :
	
	var searched = Array()
	var frontier = Array()
	
	for currentNode in frontier:
		searched.append(currentNode)
		var tempList = currentNode.children
		
		for tempTile in tempList:
		

func recursiveTreeGen( node, requirements ) :
	
	if requirements.size() == 0:
		return null
	
	for action in actions_available :
		if action.effects.has_all( requirements ):
			node.children.push_front( treeNode.new( action ) )
			node.children[0].resetCost()
			recursiveTreeGen( node.children[0], node.action.requirements.keys() )
	
	return node