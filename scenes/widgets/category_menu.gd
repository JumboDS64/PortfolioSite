extends Control

@export var tag:String
@export var isSkill:bool
var mode
var focusedPiece = null
var tween
var piecesCont
var desc
var imageViewCont
var imageAnchor

func _ready():
	mode = $".."
	piecesCont = $piecesCont
	desc = $desc
	imageViewCont = $imageViewCont
	imageAnchor = $imageViewCont/imageView/imageAnchor
	$back.texture = load("res://assets/themes/universe_"+tag+".png")
	var list_pie = getData_pieces()
	var list_cat = getData_category()
	var counter = 0
	for n in list_pie[tag]:
		var widget = load("res://scenes/widgets/pieceWidget.tscn").instantiate()
		$piecesCont/control.add_child(widget)
		widget.loadFromData(n)
		counter += 1
	desc.text = list_cat[tag]["description"]

func getData_pieces():
	if(isSkill):
		return Global.piecesSorted_skill
	else:
		return Global.piecesSorted_project
func getData_category():
	if(isSkill):
		return Global.categories_skill
	else:
		return Global.categories_project

func _process(delta):
	pass

func focusPiece(piece):
	focusedPiece = piece
	focusedPiece.tween_focus()

func unfocusPiece():
	focusedPiece.tween_unfocus()
	focusedPiece = null
