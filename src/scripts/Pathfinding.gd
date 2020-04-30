extends Node
# Pathfinding.gd
# Author: Ethan Bovard (credit goes to tobias_k)
# Description: Breadth first search for pathfinding in a 2D array
# Thanks tobias_k on Stack Overflow for this worthwhile answer to this particular problem, which is used for this project:
# https://stackoverflow.com/questions/47896461/get-shortest-path-to-a-cell-in-a-2d-array-python

var wall = 0
var clear = 1
var goal = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func findInSeen (seen, element):
	for list in seen:
		if list == element:
			return true
	return false

func return_size (grid):
	return [len(grid[0]), len(grid)]

func bfs(grid, start, dest):
	var queue = [[start]]
	var seen = [[start]]
	var size = return_size(grid)
	var width = size[0]
	var height = size[1]
	grid[dest[0]][dest[1]] = 2
	print ("Recognized width and height: " + str(size))
	print("Starting point and value: " + str(start) + ", " + str(grid[start[0]][start[1]]))
	print("Destination point and value: " + str(dest) + ", " + str(grid[dest[0]][dest[1]]))
	while queue:
		var elementRemoved = queue[0]
		queue.remove(0)
		var path = elementRemoved
		var lastElementInPath = path[-1]
		var x = lastElementInPath[0]
		var y = lastElementInPath[1]
		if grid[x][y] == goal:
			return path
		for element in [[x+1,y], [x-1,y], [x,y+1], [x,y-1]]:
			var x2 = element[0]
			var y2 = element[1]
			var widthCondition = (x2 >= 0 and x2 < width)
			var heightCondition = (y2 >= 0 and y2 < height)
			var isNotSeen = !findInSeen(seen, element)
			if (widthCondition and heightCondition and grid[y2][x2] != wall and isNotSeen):
				queue.append(path + [[x2, y2]])
				seen.append([x2, y2])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
