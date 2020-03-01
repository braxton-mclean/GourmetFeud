extends Node2D

signal completed_turn
signal unit_ready

onready var unit_stats = self.get_node("UnitStatComponent")
onready var unit_sprite = self.get_node("UnitSpriteComponent")

# Called when the node enters the scene tree for the first time.
func _ready():
	#_unit_update_loop()
	pass 


func take_turn():
	unit_sprite.flip_v = true
	yield(get_tree().create_timer(3), "timeout")
	unit_sprite.flip_v = false
	self.unit_stats.tick_counter = 0
	emit_signal("completed_turn", self)


func progress_tick_counter(gametick_counter):
	self.unit_stats.tick_counter += self.unit_stats.stat_speed
	if self.unit_stats.tick_counter > 100:
		emit_signal("unit_ready", self)


#func _unit_update_loop():
#	while true:
#		print("Creating Timer")
#		yield(get_tree().create_timer(.5), "timeout")
#		self.tick_counter += self.stat_speed
#		print("Adding Speed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#	if (self.tick_counter >= 50):
#		print(self.name + " - TickCounter: " + str(self.tick_counter))
#		self.tick_counter -= int(randf() * 50)
