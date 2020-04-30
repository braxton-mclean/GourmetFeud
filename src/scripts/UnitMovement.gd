# UnitMovement.gd
# Author: Ethan Bovard
# Description: Gives a unit the ability to move wherever traversable on the map grid.

extends Node2D

var moving = false
var currentPosition = [0, 0] # x, y
var offset = 16
var originPoint = [0, 0]
var attached_unit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func initialize (unit):
	self.attached_unit = unit

func goUp ():
	set_y(get_y() - 1)

func returnPosition():
	return Vector2(get_x(), get_y())

func goDown ():
	set_y(get_y() + 1)

func goLeft ():
	set_x(get_x() - 1)
	
func goRight ():
	set_x(get_x() + 1)

func set_x (x):
	if (moving and x >= 0 and x <= originPoint[0]):
		currentPosition[0] = x
	
func set_y (y):
	if (moving and y >= 0 and y <= originPoint[1]):
		currentPosition[1] = y

func get_x ():
	return currentPosition[0]
	
func get_y ():
	return currentPosition[1]

func _input (ev):
	if (moving == true):
		moving = false
	else:
		var check_status = false
		moving = true
		if ev is InputEventKey and ev.scancode == KEY_UP:
			goUp()
		elif ev is InputEventKey and ev.scancode == KEY_DOWN:
			goDown()
		elif ev is InputEventKey and ev.scancode == KEY_LEFT:
			goLeft()
		elif ev is InputEventKey and ev.scancode == KEY_RIGHT:
			goRight()
		elif ev is InputEventKey and ev.scancode == KEY_SPACE:
			print ("Current position: " + str(currentPosition))
			check_status = true
		else:
			return # if you're not pressing the above keys, you don't move
		if !check_status:
			position = Vector2(originPoint[0] + (get_x() * offset), originPoint[1] - (get_y() * -offset))
			print ("Moved to position: " + str(currentPosition))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
