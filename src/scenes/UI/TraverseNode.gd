extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var unitMovement = preload("res://src/scripts/UnitMovement.gd")
var pathfindingModule = preload("res://src/scripts/UnitMovement.gd")
var attached_unit
var coords
var mapgrid

func _ready():
	pass

func _init(unit, mapgrid, coords):
	self.attached_unit = unit
	self.coords = coords
	self.mapgrid = mapgrid

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	var unit_movement = unitMovement.new(attached_unit)
	var pathfinding = pathfindingModule.new().bfs(mapgrid, coords)
	for dest in pathfinding:
		unit_movement.set_x(dest[0])
		unit_movement.set_y(dest[1])
		var timer = Timer.new()
		timer.set_wait_time(1)
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		yield(timer, "timeout")
		timer.queue_free()
		print("hello")
