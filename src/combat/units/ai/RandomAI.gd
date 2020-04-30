extends UnitAI


onready var unit = get_parent()


func take_turn():
	yield(get_tree().create_timer(2), "timeout")


func choose_action(unit, targetable_units : Array = []):
	# Select an action to perform in combat
	# Can be based on state of the actor
	pass


func choose_move():
	pass


func choose_target(unit, action : CombatAction, targetable_units : Array = []):
	# Chooses a target to perform an action on
	pass
