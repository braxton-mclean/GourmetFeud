extends Control

onready var gametick_node : GameTick = get_parent().get_parent().get_node("GameTick")
onready var preview_sprites = get_node("TurnOrderBox").get_children()


func _ready():
	gametick_node.connect("upcoming_turns_sorted", self, "sort_preview_list")


func sort_preview_list():
	var count = 0
	
	for sprite_node in preview_sprites:
		if count < gametick_node.upcoming_turns.size():
			var upcoming_unit = gametick_node.upcoming_turns[count].unit
			sprite_node.set_texture(upcoming_unit.preview_sprite)
		else:
			sprite_node.set_texture(null)
		count += 1
