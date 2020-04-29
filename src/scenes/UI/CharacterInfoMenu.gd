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
	
	$BaseHP.text = "25"
	$CurrentHP.text = str(healthz)
	 
	$BaseSTR.text = "8"
	$CurrentSTR.text = str(strengthz)
	 
	$BaseVIT.text = "1"
	$CurrentVIT.text = str(vital)
	 
	$BaseCHR.text = "1"
	$CurrentCHR.text = str(charisma)
	 
	$BaseCON.text = "1"
	$CurrentCON.text = str(confident)
	 
	$BaseDEX.text = "1"
	$CurrentDEX.text = str(dexter)
	 
	$BaseSPD.text = "10"
	$CurrentSPD.text = str(speedz)
	 
	



func attachunit(unit):
	self.unit = unit
	

func toggle_visibility (visibility):
	self.visible = visibility
