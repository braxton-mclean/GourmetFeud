extends Node2D

signal started_status_phase
signal finished_status_phase
signal started_charge_phase
signal finished_charge_phase
signal started_gt_phase
signal finished_gt_phase
signal started_action_phase
signal finished_action_phase

onready var intro_node = get_node("Intro")

var gametick_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize specific instance data that cannot wait for onready
	
	# Wait for level intro to be completed
	yield(intro_node.play_intro(), "finished_intro")
	
	# Begin gametick
	_gametick_loop()


func _gametick_loop():
	# Battle Phase Loop
	while true:
		# Status Phase
		emit_signal("started_status_phase")
		emit_signal("finished_status_phase")
		
		# Charge Phase / Held Action
		emit_signal("started_charge_phase")
		emit_signal("finished_charge_phase")
		
		# GameTick+ Phase
		self.gametick_counter += 1
		emit_signal("started_gt_phase", self.gametick_counter)
		print("Gametick Loop Iteration: " + self.gametick_counter)
		emit_signal("finished_gt_phase")
		
		# Action Phase
		emit_signal("started_action_phase")
		yield(get_tree().create_timer(2.0), "timeout")
		emit_signal("finished_action_phase")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
