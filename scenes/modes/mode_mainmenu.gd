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
