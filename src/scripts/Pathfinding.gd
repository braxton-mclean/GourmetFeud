extends Node
# Breadth first search for pathfinding in a 2D array
# Thanks tobias_k on Stack Overflow for this worthwhile answer to this particular problem, which is used for this project:
# https://stackoverflow.com/questions/47896461/get-shortest-path-to-a-cell-in-a-2d-array-python

var goal = 2
var wall = 1
var clear = 0
var width = 10
var height = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var grid = [[0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,2,0],
		[0,0,0,0,0,0,0,0,0,0]]
	print (bfs(grid, [5, 2]))

func findInSeen (seen, element):
	for list in seen:
		if list == element:
			return true
	return false

func bfs(grid, start):
	var queue = [[start]]
	var seen = [[start]]
	while queue:
		var elementRemoved = queue[0]
		queue.remove(0)
		var path = elementRemoved
		var lastElementInPath = path[-1]
		var x = lastElementInPath[0]
		var y = lastElementInPath[1]
		if grid[y][x] == goal:
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
