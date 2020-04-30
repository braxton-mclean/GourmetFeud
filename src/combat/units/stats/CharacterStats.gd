extends Node

class_name CharacterStats

signal health_changed(prev_health, new_health)
signal health_depleted()

var modifiers = {}
var strength_attributes = []
var speed_attributes = []

var max_health : int setget set_max_health
var health : int
var strength : int setget , get_strength
var vitality : int
var charisma : int
var confidence : int
var dexterity : int
var speed : int setget , get_speed
var move : int
var remaining_actions : int
var remaining_moves : int
var default_moves : int
var default_actions : int

var tick_counter = 0

func initialize(stats : StartingStats):
	self.max_health = stats.max_health
	self.health = max_health
	self.strength = stats.strength
	self.vitality = stats.vitality
	self.charisma = stats.charisma
	self.confidence = stats.confidence
	self.dexterity = stats.dexterity
	self.speed = stats.speed
	self.move = stats.move
	self.default_moves = stats.default_moves
	self.default_actions = stats.default_actions

func get_strength ():
	return strength

func get_speed ():
	return speed

func set_max_health(value):
	max_health = max(0, value)

func add_strength_attr(value):
	self.strength_attributes.append(value)

func add_speed_attr(value):
	self.speed_attributes.append(value)

func take_damage(hit):
	var prev_health = self.health
	self.health -= hit.damage
	self.health = max(0, health)
	emit_signal("health_changed", prev_health, health)
	if self.health == 0:
		emit_signal("health_depleted")

func heal(amount):
	var prev_health = self.health
	self.health += amount
	self.health = max(self.health, self.max_health)
	emit_signal("health_changed", prev_health, health)
