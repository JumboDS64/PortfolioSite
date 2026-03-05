extends Mode

func _ready():
	super._ready()
func initPop():
	Global.MAIN.call_deferred("trans_warp", 0.0)
