extends Node2D

onready var units = self.get_children()
var readied_units = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ready_unit(unit):
	self.readied_units.append(unit)


func unready_unit(unit):
	self.readied_units.erase(unit)
