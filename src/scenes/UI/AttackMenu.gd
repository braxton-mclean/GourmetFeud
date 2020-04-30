extends Button

onready var battlemenu = get_parent().get_parent()
onready var map = get_tree().get_root().get_node("./Game/Coliseum/Map")
onready var coliseum = get_tree().get_root().get_node("./Game/Coliseum")

func attack():
	var target = yield(get_target(), "completed")
	if target:
		battlemenu.attached_unit.actions.get_node("Attack").execute([target])
		battlemenu.attached_unit.stats.remaining_actions -= 1
	else:
		pass


func get_target():
	map.enable_mouse_detection()
	var loc = yield(map, "destination_chosen")
	for unit in coliseum.units.units:
		if unit.location == Vector2(loc.y, loc.x):
			return unit
	return null


func _on_BMAttackButton_pressed():
	print(battlemenu.attached_unit.stats.remaining_actions)
	if battlemenu.attached_unit.stats.remaining_actions > 0:
		attack()
