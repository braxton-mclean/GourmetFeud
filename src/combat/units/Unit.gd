extends Position2D

class_name Unit

signal unit_died(unit)

export var stats : Resource
onready var actions = $Actions
onready var ai = $AI

var selected : bool = false setget set_selected
var selectable : bool = false setget set_selectable
var display_name : String

export var player_party = false


func ready():
	selectable = true


func set_selected(value):
	selected = value


func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)


func initialize():
	pass
