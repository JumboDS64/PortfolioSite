extends Mode

var tween
var selbar_skills
var selbar_projects
var selbarSelected
const TWEENTIME = 0.5

func _ready():
	selbar_skills = $selbar_skills
	selbar_projects = $selbar_projects
	selbarSelected = selbar_skills
	super._ready()
func initPop():
	Global.MAIN.call_deferred("trans_warp", 0.0)

func _process(delta):
	pass

func tweenToSelbar(bar):
	selbarSelected = bar
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(cam2D, "global_position", selbarSelected.global_position, TWEENTIME)
	tween.parallel().tween_property(cam2D.get_node("world"), "surfaceMorph", (0.0 if bar == selbar_skills else 1.0), TWEENTIME)

func _input(event) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 and event.pressed):
			if(event.position.y <= 160):
				if(selbarSelected == selbar_skills): return
				else: tweenToSelbar(selbar_skills)
			elif(event.position.y >= Global.WINDOW_HEIGHT-160):
				if(selbarSelected == selbar_projects): return
				else: tweenToSelbar(selbar_projects)
			else:
				if(event.position.x < 440): selbarSelected.scrollLeft()
				elif(event.position.x > 712): selbarSelected.scrollRight()
				else: Global.MAIN.trans_warp(1.0, 1.0, Global.MAIN.push_mode.bind("category_"+selbarSelected.get_child(selbarSelected.selectID).category))
