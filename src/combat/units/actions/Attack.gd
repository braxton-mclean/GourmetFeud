extends CombatAction


func execute(targets):
	assert(initialized)
	if not targets:
		return false
	
	for target in targets:
		var hit = Hit.new(self.actor.stats.strength)
		print("Unit Attacking: " + actor.name)
		print("Unit Attacked: " + target.name)
		print("Target heatlh: " + str(target.stats.health))
		print("Hit occurring!")
		target.take_damage(hit)
		print("Target new heatlh: " + str(target.stats.health))
		
	return true
