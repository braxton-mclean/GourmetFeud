extends Camera2D

var input_buffer = {"left": false, "right": false, "up": false, "down": false}
export var speed : int

func _ready():
	self.make_current()

func _process(delta):
	if self.position.x < self.limit_left + 640:
		self.position.x = self.limit_left + 640
	
	if self.position.x > self.limit_right + 640:
		self.position.x = self.limit_right + 640
	
	if self.position.y < self.limit_top + 360:
		self.position.y = self.limit_top + 360
	
	if self.position.y > self.limit_bottom + 360:
		self.position.y = self.limit_bottom + 360
	# self.position = get_camera_position()
	
	if Input.is_key_pressed(KEY_LEFT):
		self.position.x -= speed * delta
	if Input.is_key_pressed(KEY_RIGHT):
		self.position.x += speed * delta
	if Input.is_key_pressed(KEY_UP):
		self.position.y -= speed * delta
	if Input.is_key_pressed(KEY_DOWN):
		self.position.y += speed * delta

