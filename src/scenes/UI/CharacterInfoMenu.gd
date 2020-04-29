extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var unit
var attached_unit
export var def_unit_offset : Vector2
onready var camera_node = get_parent().get_node("Camera2D")
var unit_offset

# Called when the node enters the scene tree for the first time.
func _update():

	var healthz = unit.stats.health
	var strengthz = unit.stats.strength
	var vital = unit.stats.vitality
	var charisma = unit.stats.charisma
	var confident = unit.stats.confidence
	var dexter = unit.stats.dexterity
	var speedz = unit.stats.speed
	
	$BaseHP.text = "30"
	$CurrentHP.text = str(healthz)
	 
	$BaseSTR.text = "10"
	$CurrentSTR.text = str(strengthz)
	 
	$BaseVIT.text = "5"
	$CurrentVIT.text = str(vital)
	 
	$BaseCHR.text = "5"
	$CurrentCHR.text = str(charisma)
	 
	$BaseCON.text = "5"
	$CurrentCON.text = str(confident)
	 
	$BaseDEX.text = "5"
	$CurrentDEX.text = str(dexter)
	 
	$BaseSPD.text = "15"
	$CurrentSPD.text = str(speedz)
	 
	



func attachunit(unit):
	self.unit = unit
	
#func attach_to_unit(unit, uo = def_unit_offset):
#	attached_unit = unit
#	unit_offset = uo
#	pass
	
#func _process(delta):
#	if attached_unit != null:
#		set_position(attached_unit.position + unit_offset - (camera_node.position - Vector2(640, 360)))
#	pass

#func detach_from_unit():
#	attached_unit = null
#	set_position(Vector2(-100, -100))
#	pass

#onready var current_hp_node = get_node("CurrentHP")
#onready var current_str_node = get_node("CurrentSTR")
#onready var current_vit_node = get_node("CurrentVIT")
#onready var current_chr_node = get_node("CurrentCHR")
#onready var current_con_node = get_node("CurrentCON")
#onready var current_dex_node = get_node("CurrentDEX")
#onready var current_spd_node = get_node("CurrentSPD")



#onready var max_hp_node = get_node("BaseHP")
#onready var max_str_node = get_node("BaseSTR")
#onready var max_vit_node = get_node("BaseVIT")
#onready var max_chr_node = get_node("BaseCHR")
#onready var max_con_node = get_node("BaseCON")
#onready var max_dex_node = get_node("BaseDEX")
##onready var max_spd_node = get_node("BaseSPD")

#func please_change_the_text(): 
#	var hp = 90
#	$BaseHP.set_the_text(hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



#func _on_Stats_health_changed(prev_health, new_health):
	#$BaseHP.text = "BaseHP\n"+str(prev_health, new_health)
