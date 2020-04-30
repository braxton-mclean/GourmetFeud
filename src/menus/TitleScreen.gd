extends Node2D



func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer2/PressStartToPlay.grab_focus()
	OS.window_maximized = true
#Selects start play button on start of scene
func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer2/PressStartToPlay.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer2/PressStartToPlay.grab_focus()
#Adds hover and click functionality to button
	if $MarginContainer/VBoxContainer/VBoxContainer2/Exit.is_hovered() ==true:
		$MarginContainer/VBoxContainer/VBoxContainer2/Exit.grab_focus()
		
func _on_PressStartToPlay_pressed():
	get_tree().quit()
#Load scene on click
func _on_Exit_pressed():
	get_tree().quit()
