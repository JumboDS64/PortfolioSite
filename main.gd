extends Node

var mode:Mode

func _ready():
	mode = $mode_none
	Global.sort_pieces()
	#print(Global.piecesSorted_project)
	#print(Global.piecesSorted_skill)
	set_mode("universe_null")
	
func set_mode(path):
	remove_child(mode)
	mode = load(Global.PATH_MODES+"mode_"+path+".tscn").instantiate()
	add_child(mode)
	move_child(mode, 1)
