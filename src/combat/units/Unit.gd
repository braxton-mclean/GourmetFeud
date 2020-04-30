extends Position2D

class_name Unit

signal unit_died(unit)
signal unit_ready(unit)
signal completed_turn(unit)

var damage_score = preload("res://src/scenes/DamageScore.tscn")
var is_dead : bool = false
onready var actions = $Actions
onready var ai = $AI
onready var stats = $Stats
onready var sprite : Sprite = $Sprite
onready var tween : Tween = $Tween
onready var anim_sprite : AnimatedSprite = $Sprite/AnimatedSprite

var selected : bool = false setget set_selected
var selectable : bool = false setget set_selectable
var display_name : String

var upcoming_turns = []

export var preview_sprite : Texture

export var job : Resource

export var party_member = false

var location : Vector2
var offset = 48

func ready():
	selectable = true


func initialize():
	# Initialize skills
	for action in actions.get_children():
		action.initialize(self)
	stats.initialize(job)
	stats.connect("health_depleted", self, "_on_health_depleted")
	print(position)
	location = Vector2(position.x / offset, position.y / offset)
	position = location * 48
	pass


func travel(path):
	for coord in path:
		var target_position = Vector2(coord[1] * offset, coord[0] * offset)
		var direction = position - target_position
		if direction.x < 0:
			anim_sprite.play("move_right")
		elif direction.x > 0:
			anim_sprite.play("move_left")
		elif direction.y < 0:
			anim_sprite.play("move_down")
		elif direction.y > 0:
			anim_sprite.play("move_up")
		
		tween.interpolate_property(self, "position", position, target_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_completed")
		print ("Moved to: " + str(coord))
		location = Vector2(coord[1], coord[0])
	anim_sprite.play("active")
	


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
	if not is_dead:
		self.stats.tick_counter += self.stats.speed
		if self.stats.tick_counter >= 100:
			emit_signal("unit_ready", self)


func calculate_upcoming_turns(gametick):
	upcoming_turns.clear()
	if not is_dead:
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
	var dmg_node = damage_score.instance()
	get_node("CanvasLayer").add_child(dmg_node)
	dmg_node.initialize(hit.damage)
	if stats.health > 0:
		# play hurt animation
		pass
	pass


func _on_health_depleted():
	selectable = false
	anim_sprite.flip_v = true
	is_dead = true
	
	# play death animation
	
	emit_signal("unit_died", self)
