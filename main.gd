extends Node

var mode:Mode
var uiGlobal
var gfx_warp
var tween
const TWEENTIME = 0.5
var modeStack = []

func _ready():
	mode = $mode_none
	gfx_warp = $mode_none/cam2D/uiGlobal/warp
	uiGlobal = $mode_none/cam2D/uiGlobal
	Global.load_data()
	#print(Global.piecesSorted_project)
	#print(Global.piecesSorted_skill)
	set_mode("mainmenu")
	
func set_mode(obj):
	mode.get_node("cam2D").remove_child(uiGlobal)
	remove_child(mode)
	if(obj is String): mode = load(Global.PATH_MODES+"mode_"+obj+".tscn").instantiate()
	elif(obj is Mode): mode = obj
	add_child(mode)
	mode.get_node("cam2D").add_child(uiGlobal)
func push_mode(path):
	modeStack.push_back(mode)
	set_mode(path)
func pop_mode():
	var m = modeStack.pop_back()
	m.initPop()
	set_mode(m)

func trans_warp(v, dir=null, funcy=null):
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	if(v == 1.0): tween.set_ease(Tween.EaseType.EASE_OUT)
	else: tween.set_ease(Tween.EaseType.EASE_IN)
	tween.tween_property(gfx_warp, "modulate", Color(1.0,1.0,1.0,v), TWEENTIME)
	if(dir != null):
		gfx_warp.get_node("sprite_2d").material.set_shader_parameter("dir", dir)
	if(funcy != null):
		tween.tween_callback(funcy)
