extends Mode

var tween
var camera_2d
var selbar_skills
var selbar_projects
var selbarSelected
const TWEENTIME = 0.5

func _ready():
	camera_2d = $camera_2d
	selbar_skills = $selbar_skills
	selbar_projects = $selbar_projects
	selbarSelected = selbar_skills

func _process(delta):
	pass

func pressSkills():
	if(selbarSelected == selbar_skills): return
	else: tweenToSelbar(selbar_skills)

func pressProjects():
	if(selbarSelected == selbar_projects): return
	else: tweenToSelbar(selbar_projects)

func tweenToSelbar(bar):
	selbarSelected = bar
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TransitionType.TRANS_QUART)
	tween.set_ease(Tween.EaseType.EASE_OUT)
	tween.tween_property(camera_2d, "global_position", selbarSelected.global_position, TWEENTIME)

func _input(event) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 and event.pressed):
			if(event.position.x < 440): selbarSelected.scrollLeft()
			elif(event.position.x > 712): selbarSelected.scrollRight()
			else: Global.MAIN.set_mode("category_"+selbarSelected.get_child(selbarSelected.selectID).category)
