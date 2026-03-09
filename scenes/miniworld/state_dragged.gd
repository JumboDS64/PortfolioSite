extends State

func enter(msg:Dictionary):
	pass

func act(delta):
	mount.anim.play("dragged")
	var targ = get_viewport().get_mouse_position()
	targ.y += 48
	mount.velocity = ((targ - mount.global_position)/delta)/10.

func exit():
	pass
