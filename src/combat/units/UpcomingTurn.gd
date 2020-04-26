class_name UpcomingTurn

var unit
var gametick : int
var tick_counter : int


func _init(unit, gametick : int, tick_counter : int):
	self.unit = unit
	self.gametick = gametick
	self.tick_counter = tick_counter
