extends Position2D

class_name Unit

signal unit_died(unit)
signal unit_ready(unit)
signal completed_turn(unit)

onready var actions = $Actions
onready var ai = $AI
onready var stats = $Stats
onready var sprite : Sprite = $Sprite
onready var anim_sprite : AnimatedSprite = $Sprite/AnimatedSprite

var selected : bool = false setget set_selected
var selectable : bool = false setget set_selectable
var display_name : String

var upcoming_turns = []

export var preview_sprite : Texture

export var job : Resource

export var party_member = false


func ready():
	selectable = true


func initialize():
	# Initialize skills
	# actions.initialize(skills.get_children())
	stats.initialize(job)
	stats.connect("health_depleted", self, "_on_health_depleted")
	pass


func take_active_turn():
	var sprite_frames = anim_sprite.get_sprite_frames()
	if (sprite_frames.has_animation("flourish")):
		anim_sprite.play("flourish")
		yield(anim_sprite, "animation_finished")
	else:
		yield(get_tree().create_timer(.1), "timeout")
	anim_sprite.play("active")


func take_ai_turn():
	return ai.take_turn()


func finish_active_turn():
	print("finishing turn")
	self.stats.tick_counter -= 100
	self.stats.remaining_actions = self.stats.default_actions
	self.stats.remaining_moves = self.stats.default_moves
	emit_signal("completed_turn", self)
	anim_sprite.play("default")


func progress_tick_counter(_gametick_counter):
	self.stats.tick_counter += self.stats.speed
	if self.stats.tick_counter >= 100:
		emit_signal("unit_ready", self)


func calculate_upcoming_turns(gametick):
	upcoming_turns.clear()
	var temp_tick_counter : int = get_tick_counter() 
	var temp_gametick : int = gametick
	while upcoming_turns.size() < 5:
		while temp_tick_counter < 100:
			temp_tick_counter += self.stats.speed
			temp_gametick += 1
		upcoming_turns.append(UpcomingTurn.new(self, temp_gametick, temp_tick_counter))
		temp_tick_counter -= 100
	pass


func get_tick_counter():
	return self.stats.tick_counter


func set_selected(value):
	selected = value


func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)


func take_damage(hit):
	stats.take_damage(hit)
	if stats.health > 0:
		
		# play hurt animation
		
		pass
	pass


func _on_health_depleted():
	selectable = false
	anim_sprite.flip_v = true
	
	# play death animation
	
	emit_signal("unit_died", self)
