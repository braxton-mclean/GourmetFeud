extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_gametick_loop()
	pass # Replace with function body.

func _gametick_loop():
	while true:
		yield(get_tree().create_timer(1.0), "timeout")
		print("Gametick Loop " + self.name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
