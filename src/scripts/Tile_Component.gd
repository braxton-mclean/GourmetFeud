extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	generateTileComponent()



func generateTileComponent ():
	var is_Traversable = true
	var Move_cost = 1
	var unit = null
	var x 
	var y
	var pos = [x,y]
	var size_of_tile = 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
