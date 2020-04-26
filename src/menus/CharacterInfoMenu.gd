extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
onready var current_hp_node = get_node("CurrentHP")
onready var current_str_node = get_node("CurrentSTR")
onready var current_vit_node = get_node("CurrentVIT")
onready var current_chr_node = get_node("CurrentCHR")
onready var current_con_node = get_node("CurrentCON")
onready var current_dex_node = get_node("CurrentDEX")
onready var current_spd_node = get_node("CurrentSPD")

onready var max_hp_node = get_node("BaseHP")
onready var max_str_node = get_node("BaseSTR")
onready var max_vit_node = get_node("BaseVIT")
onready var max_chr_node = get_node("BaseCHR")
onready var max_con_node = get_node("BaseCON")
onready var max_dex_node = get_node("BaseDEX")
onready var max_spd_node = get_node("BaseSPD")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
