extends Node

onready var gametick = get_node("GameTick")
onready var units = get_node("Units")
onready var map = get_node("Map")

export var map_data : String

func initialize():
	# Initialize Map Grid
	# setting up the mapgrid
	print("set up mapgrid for TraversablesColosseumA")
	map.initialize(map_data)
	# done with mapgrid initialization
	
	# initialize GameTick, starting battle
	gametick.initialize()
	gametick.active = true
	print("calling gametick loop")
	gametick.gametick_loop()
