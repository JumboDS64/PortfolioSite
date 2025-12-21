@tool
extends Control

func _ready():
	pass

func _process(delta):
	pass

func loadFromData(n:String):
	var data = Global.pieces[n]
	$title.text = data["title"]
	match data["filetype"]:
		"png":
			$thumbnail/texture_rect.texture = load("res://assets/pieces/"+n+".png")

#func setThumbnail(filetype:String, filepath:String):
	#$title.text = v
