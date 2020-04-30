extends Node
# Pathfinding.gd
# Author: Ethan Bovard (credit goes to tobias_k)
# Description: Breadth first search for pathfinding in a 2D array
# Thanks tobias_k on Stack Overflow for this worthwhile answer to this particular problem, which is used for this project:
# https://stackoverflow.com/questions/47896461/get-shortest-path-to-a-cell-in-a-2d-array-python

class_name Pathfinding

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

# return size in [row_len, col_len] order ([y, x])
func return_size (grid):
	return [len(grid), len(grid[0])]

# Given grid[row][col], starting point [y, x], and destination [y, x],
# return the walking path from starting to destination, or null if there is none
func bfs(grid, start, dest):
	var queue = [[start]]
	var seen = [[start]]
	
	var size = return_size(grid)
	var height = size[0]
	var width = size[1]
	
	print ("Grid <height, width>: " + str(size))
	print("Starting point and value: " + str(start) + ", " + str(grid[start[0]][start[1]]))
	print("Destination point and value: " + str(dest) + ", " + str(grid[dest[0]][dest[1]]))
	
	if grid[dest[0]][dest[1]] == 0:
		print("Destination invalid target, marked non-traversable")
		return null
	
	grid[dest[0]][dest[1]] = 2
	
	while queue:
		var elementRemoved = queue[0]
		queue.remove(0)
		var path = elementRemoved
		var lastElementInPath = path[-1]
		var y = lastElementInPath[0]
		var x = lastElementInPath[1]
		
#		# sanity check in iteration
#		if x >= width or y >= height:
#			return null
			
		if grid[y][x] == goal:
			return path
		for element in [[y,x+1], [y,x-1], [y+1,x], [y-1,x]]:
			var y2 = element[0]
			var x2 = element[1]
			var widthCondition = (x2 >= 0 and x2 < width)
			var heightCondition = (y2 >= 0 and y2 < height)
			var isNotSeen = !findInSeen(seen, element)
			if (widthCondition and heightCondition and grid[y2][x2] != wall and isNotSeen):
				queue.append(path + [[y2, x2]])
				seen.append([y2, x2])
