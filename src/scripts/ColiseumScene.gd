extends Node

const mapGrid = preload("res://src/scripts/MapGridComponent.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print ("Ready called on Colosseum A")
	var inst = mapGrid.new("TraversablesColosseumA").mapGrid
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
