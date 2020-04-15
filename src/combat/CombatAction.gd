extends Node

class_name CombatAction

var initialized = false

onready var actor = get_parent().get_owner()


func initialize(unit):
	actor = unit
	initialized = true


func execute(targets : Array):
	assert(initialized)
	print("%s missing overwrite of the execute method" % name)
	return false


func can_use():
	return true
