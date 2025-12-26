extends Control

@export var tag:String
@export var isSkill:bool

func _ready():
	var list_pie
	var list_cat
	if(isSkill):
		list_pie = Global.piecesSorted_skill
		list_cat = Global.categories_skill
	else:
		list_pie = Global.piecesSorted_project
		list_cat = Global.categories_project
	var counter = 0
	for n in list_pie[tag]:
		var widget = load("res://scenes/widgets/pieceWidget.tscn").instantiate()
		$scroll_container/control.add_child(widget)
		widget.loadFromData(n)
		counter += 1
	$desc.text = list_cat[tag]["description"]

func _process(delta):
	pass
