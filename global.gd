extends Node

var MAIN
var pieces:Dictionary
var piecesSorted_project:Dictionary
var piecesSorted_skill:Dictionary
var categories_project:Dictionary
var categories_skill:Dictionary

const WINDOW_WIDTH = 1152
const WINDOW_HEIGHT = 648
const WINDOW_CENTER = Vector2(Global.WINDOW_WIDTH/2.0, Global.WINDOW_HEIGHT/2.0)
const TWO_PI = PI*2

var PATH_MODES = "res://scenes/modes/"
var PATH_MUSIC = "res://assets/music/"
var PATH_SFX = "res://assets/sfx/"

var rng = RandomNumberGenerator.new()

var time = 0

func _ready():
	MAIN = get_node("/root/main")
	time = 0
func mode():
	return MAIN.mode

func _process(delta):
	time += delta

func load_data():
	piecesSorted_project = {}
	piecesSorted_skill = {}
	var dir := DirAccess.open("res://assets/pieces")
	dir.list_dir_begin()
	for filename: String in dir.get_files():
		var ex = filename.get_extension()
		if(ex != "json"): continue
		var na = filename.get_basename()
		var json = JSON.new()
		var file = FileAccess.open(dir.get_current_dir()+"/"+filename, FileAccess.ModeFlags.READ)
		json.parse(file.get_as_text())
		pieces[na] = json.data
		if(piecesSorted_project.has(json.data["project"])): piecesSorted_project[json.data["project"]].append(na)
		else: piecesSorted_project[json.data["project"]] = [na]
		for s in json.data["skills"]:
			if(piecesSorted_skill.has(s)): piecesSorted_skill[s].append(na)
			else: piecesSorted_skill[s] = [na]
	dir.list_dir_end()
	
	categories_project = {}
	categories_skill = {}
	dir = DirAccess.open("res://assets/categories")
	for filename: String in dir.get_files():
		var ex = filename.get_extension()
		if(ex != "json"): continue
		var na = filename.get_basename()
		var nam = na.substr(2)
		var json = JSON.new()
		var file = FileAccess.open(dir.get_current_dir()+"/"+filename, FileAccess.ModeFlags.READ)
		json.parse(file.get_as_text())
		if(na[0] == 'p'):
			categories_project[nam] = json.data
		else: # if not a project, assume its a skill
			categories_skill[nam] = json.data
	

func randf_range(min,max):
	return rng.randf_range(min,max)
func randi_range(min,max):
	return rng.randi_range(min,max)
