@tool
extends Control

var category_menu
var tag
var thumb
const TWEENTIME = 0.2
const TWEENSCALE = 3.5
var tween
#var debug

func _ready():
	thumb = $thumbnail
	category_menu = $"../../.."

func _process(delta):
	pass

func loadFromData(n:String):
	tag = n
	var data = Global.pieces[tag]
	$title.text = data["title"]
	#if(n == "fractal_block_world_3"): debug = true
	match data["filetype"]:
		"png":
			$thumbnail/texture_rect.texture = load("res://assets/pieces/"+tag+".png")

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 and event.pressed):
			if((tween != null and !tween.is_running()) or tween == null):
				if(category_menu.focusedPiece == null):
					category_menu.focusPiece(self)
				else:
					category_menu.unfocusPiece()

func tween_focus():
	category_menu.imageViewCont.visible = true
	thumb.reparent(category_menu.imageAnchor)
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(thumb, "global_position", category_menu.imageAnchor.global_position-Vector2(64*TWEENSCALE,64*TWEENSCALE), TWEENTIME)
	tween.parallel().tween_property(thumb, "scale", Vector2(TWEENSCALE,TWEENSCALE), TWEENTIME)
	tween.parallel().tween_property(category_menu.piecesCont, "modulate", Color(1.0, 1.0, 1.0, 0.0), TWEENTIME)
	tween.tween_callback(tween_focus_cb)
func tween_focus_cb():
	category_menu.desc.text = Global.pieces[tag]["description"]
func tween_unfocus():
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(thumb, "global_position", global_position+Vector2(56.0, 8.0), TWEENTIME)
	tween.parallel().tween_property(thumb, "scale", Vector2(1.0, 1.0), TWEENTIME)
	tween.parallel().tween_property(category_menu.piecesCont, "modulate", Color(1.0, 1.0, 1.0, 1.0), TWEENTIME)
	tween.tween_callback(tween_unfocus_cb)
func tween_unfocus_cb():
	thumb.reparent(self)
	thumb.position = Vector2(56.0, 8.0)
	thumb.scale = Vector2(1.0, 1.0)
	category_menu.imageViewCont.visible = false
	category_menu.desc.text = category_menu.getData_category()[category_menu.tag]["description"]
	
