@tool
extends Node2D

var tween
var selectID
var selectPos
const SCALE_UNFOC = 0.5
const TWEENTIME = 0.3

func _ready():
	selectID = 0
	selectPos = 0
	draw()

func _process(delta):
	draw()

func draw():
	for i in get_child_count():
		var n = get_child(i)
		n.position.x = (i - selectPos)*256
		n.position.y = 0
		n.scale.x = SCALE_UNFOC
		n.scale.y = SCALE_UNFOC
	var selected = get_child(selectID)
	selected.scale.x = 1
	selected.scale.y = 1

func scrollLeft():
	scroll(selectID - 1)
func scrollRight():
	scroll(selectID + 1)

func scroll(i):
	selectID = i
	if(selectID < 0): selectID = 0
	if(selectID >= get_child_count()): selectID = get_child_count()-1
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(self, "selectPos", selectID, TWEENTIME)
