extends Node2D

export var stat_strength = 1
export var stat_vitality = 1

export var stat_charisma = 1
export var stat_confidence = 1

export var stat_speed = 5
export var stat_dexterity = 1

export var stat_move = 4

var tick_counter = 0


func _ready():
	_unit_update_loop()


func _unit_update_loop():
	while true:
		print("Creating Timer")
		yield(get_tree().create_timer(.5), "timeout")
		self.tick_counter += self.stat_speed
		print("Adding Speed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.tick_counter >= 50):
		print(self.name + " - TickCounter: " + str(self.tick_counter))
		self.tick_counter -= int(randf() * 50)


func progress_tick_counter(gametick_counter):
	self.tick_counter += self.stat_speed
