extends Node

class_name CombatAction

var initialized = false

onready var actor : Unit = get_parent().get_owner()


func initialize(unit : Unit):
	actor = unit
	initialized = true


func execute():
	assert(initialized)
	print("%s missing overwrite of the execute method" % name)
	return false


func can_use():
	return true
