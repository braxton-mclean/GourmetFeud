
extends Control


func _ready():
	$MarginContainer/Menu/Buttons/PlayButton.grab_focus()
	for button in $MarginContainer/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])


func _on_Button_pressed(scene_to_load):
	print(scene_to_load)
	get_tree().change_scene(scene_to_load)
