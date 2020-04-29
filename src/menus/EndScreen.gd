extends Node2D


func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer2/MainMenu.grab_focus()
	OS.window_maximized = true
#Selects start play button on start of scene
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer2/MainMenu.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer2/MainMenu.grab_focus()
#Adds hover and click functionality to button
	if $MarginContainer/VBoxContainer/VBoxContainer2/EndGame.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer2/EndGame.grab_focus()
		
func _on_MainMenu_pressed():
	get_tree().change_scene("res://src/menus/TitleScreen.tscn")
#Load scene on click
func _on_EndGame_pressed():
	get_tree().quit()
