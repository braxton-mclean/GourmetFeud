extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	generateMapGridComponent()

func generateMapGridComponent ():
	var dimensions = [5, 5] # dimensions defined by width and height respectively in the list
	var arr = [] # entire array, elements in the list will be treated as rows
	for _height in range(0, dimensions[1]): # dimensions[1] is the height
		var row = []
		for _width in range(0, dimensions[0]): # how many elements can go in one row?
			row.append(0)
		arr.append(row)
	# both lines below are used for debugging purposes, do NOT use in the actual game!
	# arr[1][3] = 1
	# print(arr)
