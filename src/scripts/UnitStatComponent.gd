extends Node2D

export var stat_strength = 1
export var stat_vitality = 1

export var stat_charisma = 1
export var stat_confidence = 1

export var stat_speed = 5
export var stat_dexterity = 1

export var stat_move = 4

var tick_counter = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	_unit_update_loop()
	pass # Replace with function body.

func _unit_update_loop():
	while true:
		yield(get_tree().create_timer(.5), "timeout")
		self.tick_counter += self.stat_speed
		print("Adding Speed")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.tick_counter >= 50):
		print(self.name + " - TickCounter: " + str(self.tick_counter))
		self.tick_counter -= int(randf() * 50)
	
	pass
