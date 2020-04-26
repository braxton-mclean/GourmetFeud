extends Node
# Called when the node enters the scene tree for the first time.

var activeUnit = []
var mapGrid = []

#func _ready():
#	pass

func _init (traversableName):
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

func parseCSV (value):
	if value == "TRUE":
		return 1 # 0 meaning, is traversable
	elif value == "FALSE":
		return 0 # 1 meaning, is not traversable
		

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
	print (arr)

func insertAtPosition (x, y, val, arr):
	arr[x][y] = val
