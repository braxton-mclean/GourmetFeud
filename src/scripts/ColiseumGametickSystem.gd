extends Node2D

signal started_gametick
signal started_status_phase
signal finished_status_phase
signal started_charge_phase
signal finished_charge_phase
signal started_gt_phase
signal finished_gt_phase
signal started_action_phase
signal finished_action_phase
signal finished_gametick

onready var units_node = get_node("Units")

var start_gametick = false
var gametick_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize specific instance data that cannot wait for onready
	
	# Wait for level intro to be completed
	#intro_node.animation_player.play_intro()
	#yield(intro_node.animation_player, "finished_intro")
	
	# Connect components to relevant signals
	for unit in units_node.units:
		self.connect("started_gt_phase", unit, "progress_tick_counter")
		unit.connect("completed_turn", units_node, "unready_unit")
		unit.connect("unit_ready", units_node, "ready_unit")


func _gametick_loop():
	# Battle Phase Loop
	while true:
		self.gametick_counter += 1
		emit_signal("started_gametick", self.gametick_counter)
		# ===== Status Phase =====
		emit_signal("started_status_phase")
		emit_signal("finished_status_phase")
		
		# ===== Charge / Held Action Phase =====
		emit_signal("started_charge_phase")
		emit_signal("finished_charge_phase")
		
		# ===== GameTick+ Phase =====
		emit_signal("started_gt_phase", self.gametick_counter)
		print("Gametick Loop Iteration: " + str(self.gametick_counter))
		emit_signal("finished_gt_phase")
		
		# ===== Action Phase =====
		emit_signal("started_action_phase")
		
		# Dummy logic just to see processing Unit.
		# This logic should be moved out of GameTick and into Units
		for unit in self.units_node.readied_units:
			var unit_stats = unit.get_node("UnitStatComponent")
			print(unit.name + "'s Turn!")
			unit.take_turn()
			yield(unit, "completed_turn")
		
		emit_signal("finished_action_phase")
		
		# ===== Finished GameTick =====
		emit_signal("finished_gametick")


func _input(event):
	if not start_gametick:
		if Input.is_key_pressed(KEY_SPACE):
			start_gametick = true
			_gametick_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
