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


func initialize():
	# Initialize skills
	# actions.initialize(skills.get_children())
	stats = stats.copy()
	stats.connect("health_depleted", self, "_on_health_depleted")
	pass


func set_selected(value):
	selected = value


func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)


func take_damage(hit):
	stats.take_damage(hit)
	if stats.health > 0:
		# play hurt animation
		pass


func _on_health_depleted():
	selectable = false
	# play death animation
	emit_signal("unit_died", self)
