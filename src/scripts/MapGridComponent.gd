# MapGridComponent.gd
# Author: Ethan Bovard
# Description: Generates a MapGrid based on the traversable defined in _init.

extends Node2D

signal destination_chosen

onready var tile_map = $TileMap

export var debug_map : bool
export var map_grid = []
var tile_scene = preload("res://src/scenes/TileView.tscn")
onready var camera_node = get_parent().get_node("CanvasLayer/Camera2D")
onready var coliseum = get_parent()

var detecting_mouse : bool = false

func initialize (traversableName):
	var traversable = File.new()
	if traversable.open("res://src/scenes/Traversables/" + traversableName + ".csv", File.READ) != 1: # this file can be read
		traversable = traversable.get_as_text()
		# print ("Traversable data: " + traversable)
		var lines = traversable.split('\n', false, 0)
		var columns = lines[0].split(',', false, 0)
		var heightLength = len(lines)
		var widthLength = len(columns)
		if heightLength > 0 and widthLength > 0:
			print ("Height: " + str(heightLength) + ", width: " + str(widthLength))
			generateMapGridComponent (traversable, [widthLength, heightLength])
		else:
			print ("Please check your traversables file, it may be empty.")
	else:
		print ("Traversable not found. Please check your scenes/Traversables directory.")
	if debug_map:
		visualize_map()


func get_mapgrid():
	return self.map_grid


func parseCSV (value):
	if value == "TRUE":
		return 1 # 1 meaning, is traversable
	elif value == "FALSE":
		return 0 # 0 meaning, is not traversable


func generateMapGridComponent (mapGridCSV, mapGridSize):
	mapGridCSV = mapGridCSV.split('\n', false, 0)
	var dimensions = mapGridSize # dimensions defined by width and height respectively in the list
	var arr = [] # entire array, elements in the list will be treated as rows
	for _height in range(0, dimensions[1]): # dimensions[1] is the height
		var row = []
		var line = mapGridCSV[_height].split(',', false, 0)
		for _width in range(0, dimensions[0]): # how many elements can go in one row?
			row.append(parseCSV(line[_width]))
		arr.append(row)
	map_grid = arr


func visualize_map():
	for row in range(0, len(map_grid)):
		for col in range(0, len(map_grid[0])):
			var tile = tile_scene.instance()
			tile.position = Vector2(col * 48, row * 48)
			if map_grid[row][col] == 0:
				tile.modulate = Color(1,0,0)
			add_child(tile)
	pass


func enable_mouse_detection():
	detecting_mouse = true

func _unhandled_input(event):
	if detecting_mouse and event is InputEventMouseButton:
		var mouse_pos = get_global_mouse_position() / 3
		print(mouse_pos)
		var tile_pos = tile_map.world_to_map(mouse_pos)
		print(tile_pos)
		detecting_mouse = false
		emit_signal("destination_chosen", Vector2(tile_pos.y, tile_pos.x))
