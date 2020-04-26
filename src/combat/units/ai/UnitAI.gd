extends Node

class_name UnitAI


func choose_action(actor : Unit, battlers : Array = []):
	# Select an action to perform in combat
	# Can be based on state of the actor
	pass


func choose_target(actor : Unit, action : CombatAction, battlers : Array = []):
	# Chooses a target to perform an action on
	pass
