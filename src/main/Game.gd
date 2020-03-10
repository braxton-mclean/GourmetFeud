extends Node

onready var coliseum = $Coliseum

var _init_combat : bool = false


func start_combat():
	"""
	Initializes Combat by starting the GameTick of the current Coliseum
	"""
	print("initializing gametick")
	coliseum.gametick.initialize()
	coliseum.gametick.active = true
	print("calling gametick loop")
	coliseum.gametick.gametick_loop()
	pass


func load_coliseum(res_path: Resource):
	# TODO: change the coliseum node to another coliseum
	pass

func _input(event):
	if not _init_combat:
		if Input.is_key_pressed(KEY_SPACE):
			self._init_combat = true
			self.start_combat()
