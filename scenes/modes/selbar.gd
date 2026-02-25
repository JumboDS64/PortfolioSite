@tool
extends Node2D

var selectPos

func _ready():
	selectPos = 0
	draw()

func _process(delta):
	draw()

func draw():
	for i in len(get_children()):
		var n = get_child(i)
		n.position.x = (i - selectPos)*256
		n.position.y = 0
