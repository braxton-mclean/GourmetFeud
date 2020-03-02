extends Node2D

onready var units = self.get_children()
var readied_units = [] # Queue of readied Units


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ready_unit(unit):
	self.readied_units.append(unit)


func unready_unit(unit):
	#self.readied_units.erase(unit)
	pass


func sort_unit_queue(unit_1, unit_2):
	var unit_1_tick = unit_1.get_tick_counter()
	var unit_2_tick = unit_2.get_tick_counter()
	if unit_2_tick < unit_1_tick:
		return true
	else:
		return false
