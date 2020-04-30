extends CombatAction
var movement

func _ready():
	pass

func traverse ():
	var attachedUnit = self.actor.attached_unit
	var pathfinding = preload("res://src/scripts/Pathfinding.gd").new()
	var offset = 48
	var position_on_map = Vector2(attachedUnit.position.x / offset, attachedUnit.position.y / offset) # relative to the mapgrid in Ground/TileMap
	# var radius = attachedUnit.stats.move  # how many squares around the unit? -- for later
	print ("Move action invoked on: " + str(attachedUnit))
	print ("Current location: " + str(position_on_map))
	var root = self.get_tree().get_root()
	var mapgrid = root.get_node("./Game/Coliseum/Ground/TileMap").get("map_grid")
	# print ("MapGrid: " + str(mapgrid.get("mapGrid"))) -- for debugging purposes
	# beginning traversal
	var dest = [10, 9]
	var temp_val = mapgrid[dest[0]][dest[1]]
	var pathway = pathfinding.bfs(mapgrid, [position_on_map.x, position_on_map.y], dest)
	print (pathway)
	mapgrid[dest[0]][dest[1]] = temp_val # remove the goal, we can't have two goals at the same time
	attachedUnit.position = position_on_map
	for coord in pathway:
		position_on_map = change_position(coord[0], coord[1], offset)
		attachedUnit.position = position_on_map
		print ("Moved to: " + str(coord))

func change_position (x, y, offset):
	return Vector2(x * offset, y * offset)

func set_position_on_mapgrid():
	pass

func _on_BMMoveButton_pressed():
	traverse()
