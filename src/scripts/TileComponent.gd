extends Node

export var is_traversable = true
export var move_cost = 1
var unit = null setget set_unit, get_unit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_unit(new_unit):
	# Make sure unit is valid
	unit = new_unit
	pass
	
func get_unit():
	return unit
