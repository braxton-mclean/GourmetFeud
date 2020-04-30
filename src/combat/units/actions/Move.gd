extends Node

onready var battlemenu = get_parent().get_parent()
onready var map = get_tree().get_root().get_node("./Game/Coliseum/Map")

export var offset = 48
var pathfinding = Pathfinding.new()


func traverse():
	var attached_unit = battlemenu.attached_unit
	var map_grid = map.map_grid
	var position_on_map = Vector2(attached_unit.position.x / offset, attached_unit.position.y / offset) # relative to the mapgrid in Ground/TileMap
	# var radius = attached_unit.stats.move  # how many squares around the unit? -- for later
	print ("Move action invoked on: " + str(attached_unit.name))
	print ("Current map location: " + str(position_on_map))
	
	# beginning traversal
	# destination: [row, col]
	var dest = [9, 21]
	var temp_val = map_grid[dest[0]][dest[1]]

	var pathway = pathfinding.bfs(map_grid, [position_on_map.y, position_on_map.x], dest)
	print (pathway)
	
	map_grid[dest[0]][dest[1]] = temp_val # remove the goal, we can't have two goals at the same time
	if pathway == null:
		print("cannot move there!")
	else:
		for coord in pathway:
			position_on_map = change_position(coord[0], coord[1], offset)
			attached_unit.position = position_on_map
			print ("Moved to: " + str(coord))

func change_position (y, x, offset):
	return Vector2(x * offset, y * offset)

func set_position_on_mapgrid():
	pass

func _on_BMMoveButton_pressed():
	traverse()
