extends Node

class_name UnitAI


func choose_action(unit, targetable_units : Array = []):
	# Select an action to perform in combat
	# Can be based on state of the actor
	pass


func choose_target(unit, action : CombatAction, targetable_units : Array = []):
	# Chooses a target to perform an action on
	pass
