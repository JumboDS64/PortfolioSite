extends Control

@export var tag:String
@export var isSkill:bool

func _ready():
	var list
	if(isSkill): list = Global.piecesSorted_skill
	else: list = Global.piecesSorted_project
	var counter = 0
	for n in list[tag]:
		var widget = load("res://scenes/widgets/pieceWidget.tscn").instantiate()
		$scroll_container/control.add_child(widget)
		widget.loadFromData(n)
		counter += 1

func _process(delta):
	pass
