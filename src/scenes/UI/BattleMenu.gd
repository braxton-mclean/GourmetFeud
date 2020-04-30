extends Panel

var attached_unit
export var def_unit_offset : Vector2
onready var camera_node = get_parent().get_node("Camera2D")
var unit_offset

# TODO: Connect Battle Menu button events to Unit specifics like navigation etc.

func _process(delta):
	if attached_unit != null:
		set_position(attached_unit.position + unit_offset - (camera_node.position - Vector2(640, 360)))
	pass


func attach_to_unit(unit, uo = def_unit_offset):
	attached_unit = unit
	unit_offset = uo
	pass


func detach_from_unit():
	attached_unit = null
	set_position(Vector2(-100, -100))
	pass
