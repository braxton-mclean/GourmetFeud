extends Node

onready var battlemenu = get_parent().get_parent()
onready var map = get_tree().get_root().get_node("./Game/Coliseum/Map")

var pathfinding = Pathfinding.new()


func traverse():
	var attached_unit = battlemenu.attached_unit
	var map_grid = map.map_grid
	var position_on_map = Vector2(attached_unit.location.x, attached_unit.location.y) # relative to the mapgrid in Ground/TileMap
	# var radius = attached_unit.stats.move  # how many squares around the unit? -- for later
	print ("Move action invoked on: " + str(attached_unit.name))
	print ("Current map location: " + str(position_on_map))
	
	# beginning traversal
	# destination: [row, col]
	
	var dest = yield(get_destination(), "completed")
	
	var temp_val = map_grid[dest[0]][dest[1]]

	map_grid[position_on_map.y][position_on_map.x] = 1
	var path = pathfinding.bfs(map_grid, [position_on_map.y, position_on_map.x], dest)
	print (path)
	
	map_grid[dest[0]][dest[1]] = 0
	if path == null:
		print("cannot move there!")
	else:
		attached_unit.travel(path)
		attached_unit.stats.remaining_moves -= 1


func get_destination():
	map.enable_mouse_detection()
	var val = yield(map, "destination_chosen")
	return val


func _on_BMMoveButton_pressed():
	print(battlemenu.attached_unit.stats.remaining_moves)
	if battlemenu.attached_unit.stats.remaining_moves > 0:
		traverse()
