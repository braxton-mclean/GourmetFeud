extends Control

onready var label = get_node("Label")
onready var tween = get_node("Tween")
onready var camera_node = get_tree().get_root().get_node("./Game/Coliseum/CanvasLayer/Camera2D")

func initialize(dmg):
	print(dmg)
	self.set_position(get_parent().get_parent().position - (camera_node.position - Vector2(640, 360)))
	print(get_parent().get_parent().name)
	label.text = str(dmg)
	tween.interpolate_property(self, "rect_position", self.rect_position, self.rect_position + Vector2(0, -10), .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	self.queue_free()
