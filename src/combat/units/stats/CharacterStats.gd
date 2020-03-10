extends Node

class_name CharacterStats

signal health_changed(new_health)
signal health_depleted()

var modifiers = {}

var max_health : int setget set_max_health
var health : int
var strength : int
var vitality : int
var charisma : int
var confidence : int
var dexterity : int
var speed : int
var move : int
var _default_moves : int
var _default_actions : int


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
	self._default_moves = stats._default_moves
	self._default_actions = stats._default_actions


func set_max_health(value):
	self.max_health = max(0, value)


func take_damage(hit):
	self.health -= hit.damage
	self.health = max(0, health)
	emit_signal("health_changed", health)
	if self.health == 0:
		emit_signal("health_depleted")


func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", amount)
