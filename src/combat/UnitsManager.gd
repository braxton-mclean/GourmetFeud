extends YSort

onready var units = self.get_children()
onready var battle_menu_node = get_parent().get_node("CanvasLayer/BattleMenu")

func get_party_members():
	var party_members = []
	for unit in units:
		if unit.party_member:
			party_members.append(unit)
	return party_members


func get_other_units():
	var other_units = []
	for unit in units:
		if not unit.party_member:
			other_units.append(unit)
	return other_units
