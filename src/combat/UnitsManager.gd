extends YSort

onready var units = self.get_children()
onready var battle_menu_node = get_parent().get_node("CanvasLayer/BattleMenu")

var readied_units = [] # Queue of readied Units


func ready_unit(unit):
	self.readied_units.append(unit)


func sort_unit_queue():
	self.readied_units.sort_custom(self, "sort_units_by_tick_counter")


func sort_units_by_tick_counter(unit_1, unit_2):
	var unit_1_tick = unit_1.get_tick_counter()
	var unit_2_tick = unit_2.get_tick_counter()
	if unit_2_tick < unit_1_tick:
		return true
	else:
		return false


func take_active_turns():
	for unit in self.units:
		print(unit.get_tick_counter())
		
	if self.readied_units.empty():
		return null
	else:
		while not self.readied_units.empty():
			var unit = self.readied_units.front()
			print(unit.name + "'s Turn!")
			# Play Unit Turn animation
			
			# Instead of Unit taking control:
			#unit.take_turn()
			#yield(unit, "completed_turn")
			# Have Unit set up anything particular with start of turn (ie. animate, wind-up) 
			# which yields a state to resume once the turn is completed (ie. wind-down)
			var unit_active_turn_state = unit.take_active_turn()
			
			# Set up battle menu at Unit location w/ small offset
			battle_menu_node.set_position(Vector2(unit.position.x + 10, unit.position.y + 10))
			# TODO: Connect Battle Menu button events to Unit specifics like navigation etc.
			
			# Set yield to UI's turn complete signal (The player selects "Wait")
			yield(battle_menu_node.get_node("BMButtonContainer/BMWaitButton"), "pressed")
			
			# Once complete signal received, let unit finish its active turn (ie. wind down)
			unit_active_turn_state.resume()
			
			# Finally, remove the unit from the queue of readied units
			# Need to do this here so if the unit cancels its action we can instead
			# start the turn over cleanly at a previous point (nothing selected, 
			# after move+before attack, before move+after attack)
			# TODO: Be aware of how to distinguish what move the unit can currently do
			# Currently the Unit has a couple of stat variables distinguishing how many
			# move and attack actions it has left this turn. 
			# It gets reset on the .resume() call above
			self.readied_units.pop_front()
		print("emitting")
		emit_signal("finished_active_turns")


func unit_take_turn(unit):
	pass
