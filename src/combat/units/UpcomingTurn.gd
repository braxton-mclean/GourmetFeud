class_name UpcomingTurn

var unit
var gametick : int
var tick_counter : int


func _init(given_unit, given_gametick : int, given_tick_counter : int):
	self.unit = given_unit
	self.gametick = given_gametick
	self.tick_counter = given_tick_counter
