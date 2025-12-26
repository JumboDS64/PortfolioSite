@tool
extends Control

var thumb
const TWEENTIME = 0.2
const TWEENSCALE = 4.0
var tween

func _ready():
	thumb = $thumbnail

func _process(delta):
	pass

func loadFromData(n:String):
	var data = Global.pieces[n]
	$title.text = data["title"]
	match data["filetype"]:
		"png":
			$thumbnail/texture_rect.texture = load("res://assets/pieces/"+n+".png")

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 and event.pressed):
			if((tween != null and !tween.is_running()) or tween == null):
				if(Global.mode().focusedPiece == null):
					Global.mode().focusedPiece = self
					tween_focus()
				else:
					Global.mode().focusedPiece.tween_unfocus()
					Global.mode().focusedPiece = null

func tween_focus():
	thumb.reparent(Global.mode())
	Global.mode().focusFade.visible = true
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(thumb, "position", Global.WINDOW_CENTER-Vector2(64*TWEENSCALE,64*TWEENSCALE), TWEENTIME)
	tween.parallel().tween_property(thumb, "scale", Vector2(TWEENSCALE,TWEENSCALE), TWEENTIME)
	tween.parallel().tween_property(Global.mode().focusFade, "color", Color(0.0, 0.0, 0.0, 0.25), TWEENTIME)
func tween_unfocus():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(thumb, "position", global_position+Vector2(56.0, 8.0), TWEENTIME)
	tween.parallel().tween_property(thumb, "scale", Vector2(1.0, 1.0), TWEENTIME)
	tween.parallel().tween_property(Global.mode().focusFade, "color", Color(0.0, 0.0, 0.0, 0.0), TWEENTIME)
	tween.tween_callback(rep)
func rep():
	thumb.reparent(self)
	thumb.position = Vector2(56.0, 8.0)
	thumb.scale = Vector2(1.0, 1.0)
	Global.mode().focusFade.visible = false
	
