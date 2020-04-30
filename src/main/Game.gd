extends Node

onready var coliseum = $Coliseum

var _init_combat : bool = false


func _input(_event):
	if not _init_combat:
		if Input.is_key_pressed(KEY_SPACE):
			self._init_combat = true
			self.start_combat()


func load_coliseum(res_path: Resource):
	# TODO: change the coliseum node to another coliseum
	pass


func start_combat():
	"""
	Initializes Combat by initializing the Coliseum
	"""
	print("initializing coliseum")
	coliseum.initialize()
