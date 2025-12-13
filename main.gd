extends Node

var mode:Mode

func _ready():
	mode = $mode_none
	set_mode("base")
	
func set_mode(path):
	remove_child(mode)
	mode = load(Global.PATH_MODES+"mode_"+path+".tscn").instantiate()
	add_child(mode)
	move_child(mode, 1)
