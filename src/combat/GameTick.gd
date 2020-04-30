extends Node

class_name GameTick

"""
List of GameTick Signals | Keeps flow of combat strict in order processing
GameTick Signals should emit in this order:
	Started GameTick
	Started Status Phase
	Finished Status Phase
	Started Charge Phase
	Finished Charge Phase
	Started GTP Phase
	Finished GTP Phase
	Started Action Phase
	Finished Action Phase
	Finished GameTick
"""
signal started_gametick
signal started_status_phase
signal finished_status_phase
signal started_charge_phase
signal finished_charge_phase
signal started_gtp_phase
signal finished_gtp_phase
signal started_action_phase
signal finished_action_phase
signal finished_gametick

onready var coliseum = get_parent()
onready var units = coliseum.get_node("Units")
onready var battlemenu = get_parent().get_node("CanvasLayer/BattleMenu")
onready var bm_waitbutton = battlemenu.get_node("BMButtonContainer/BMWaitButton")
onready var almstatsmenu = get_parent().get_node("CanvasLayer/AlmMenu")
onready var celicastatsmenu = get_parent().get_node("CanvasLayer/CelicaMenu")
onready var map = get_parent().get_node("Map")

signal finished_active_turns
signal upcoming_turns_sorted

var active = false
var gametick_counter = 0

"""
	Queue of readied units to take their turns the next available Action Phase
"""
var readied_units = [] 
var upcoming_turns : Array = []

func _ready():

	# Wait for level intro to be completed
	#intro_node.animation_player.play_intro()
	#yield(intro_node.animation_player, "finished_intro")
	pass

func initialize():
	# Connect components to relevant signals
	for unit in units.units:
		unit.initialize()
		self.connect("started_gtp_phase", unit, "progress_tick_counter")
		unit.connect("completed_turn", self, "calculate_upcoming_turns")
		unit.connect("unit_ready", self, "ready_unit")
	self.connect("finished_gtp_phase", self, "sort_unit_queue")
	self.calculate_upcoming_turns()

	print("initialized gametick")

func gametick_loop():
	while active:
		# ===== Start of GameTick =====
		self.gametick_counter += 1
		emit_signal("started_gametick", self.gametick_counter)
		
		# ===== Status Phase =====
		emit_signal("started_status_phase")
		emit_signal("finished_status_phase")
		
		# ===== Charge / Held Action Phase =====
		emit_signal("started_charge_phase")
		emit_signal("finished_charge_phase")
		
		# ===== GameTick+ Phase =====
		emit_signal("started_gtp_phase", self.gametick_counter)
		print("Gametick Loop Iteration: " + str(self.gametick_counter))
		for unit in units.units:
			print(unit.stats.tick_counter, "\t| ", unit.name)
		
		emit_signal("finished_gtp_phase")
		
		# ===== Action Phase =====
		emit_signal("started_action_phase")
		
		if not readied_units.empty():
			yield(self.take_active_turns(), "completed")
		
		emit_signal("finished_action_phase")
		
		# ===== Finished GameTick =====
		emit_signal("finished_gametick")


func ready_unit(unit):
	self.readied_units.append(unit)


func sort_unit_queue():
	if not self.readied_units.empty():
		self.readied_units.sort_custom(self, "sort_units_by_tick_counter")



func sort_units_by_tick_counter(unit_1, unit_2):
	var unit_1_tick = unit_1.get_tick_counter()
	var unit_2_tick = unit_2.get_tick_counter()
	if unit_2_tick < unit_1_tick:
		return true
	else:
		if unit_2.name > unit_1.name:
			return true
		else:
			return false


func take_active_turns():
	while not self.readied_units.empty():
		var unit = self.readied_units.front()
		print(unit.name + "'s Turn!")
		
		"""
			Have Unit set up anything particular with start of turn 
			(ie. flourish, wind-up) 
			Then finish with unit cleaning up its end of turn
			(ie. wind-down)
		"""
		#Allows the different battle menus to appear on their turn
		if unit.name == "Alm":
			almstatsmenu.attachunit(unit)
			almstatsmenu._update()
			almstatsmenu.toggle_visibility(true)
			celicastatsmenu.toggle_visibility(false)
		elif unit.name == "Celica":
			celicastatsmenu.attachunit(unit)
			celicastatsmenu._update()
			almstatsmenu.toggle_visibility(false)
			celicastatsmenu.toggle_visibility(true)
		
		yield(unit.take_active_turn(), "completed")
		
		if (unit.party_member):
			# Tell BattleMenu to attach to Unit: 
			# Sets tracking, assigns button connections, etc.
			battlemenu.attach_to_unit(unit)
			
			# Set yield to UI's turn complete signal (The player selects "Wait")
			yield(bm_waitbutton, "pressed")
			
			# Once complete signal received, let unit finish its active turn (ie. wind down)
			battlemenu.detach_from_unit()
		else:
			yield(unit.take_ai_turn(), "completed")

		unit.finish_active_turn()
		
		# Finally, remove the unit from the queue of readied units
		# Need to do this here so if the unit cancels its action we can instead
		# start the turn over cleanly at a previous point (nothing selected, 
		# after move+before attack, before move+after attack)
		# TODO: Be aware of how to distinguish what move the unit can currently do
		# Currently the Unit has a couple of stat variables distinguishing how many
		# move and attack actions it has left this turn. 
		# It gets reset on the .resume() call above
		self.readied_units.pop_front()
	emit_signal("finished_active_turns")

func calculate_upcoming_turns(_unit = null):
	print("======= Turn Order =======")
	print("Sorting Upcoming Turns")
	upcoming_turns.clear()
	for unit in units.units:
		unit.calculate_upcoming_turns(self.gametick_counter)
		for turn in unit.upcoming_turns:
			upcoming_turns.append(turn)
	self.upcoming_turns.sort_custom(self, "sort_upcoming_turns")
	
	emit_signal("upcoming_turns_sorted")


func sort_upcoming_turns(turn1 : UpcomingTurn, turn2 : UpcomingTurn):
	if turn2.gametick < turn1.gametick:
		return false
	elif turn1.gametick < turn2.gametick:
		return true
	else:
		if turn2.tick_counter < turn1.tick_counter:
			return true
		else:
			if turn2.unit.name > turn1.unit.name:
				return true
			else:
				return false
