extends State

const CHAR_WALKSPEED = 300
var move:bool
var timer:float

func enter(msg:Dictionary):
	move = false
	timer = 1
	mount.anim.play("idle")

func act(delta):
	# Movement
	timer -= delta
	if(move):
		if(timer <= 0):
			move = false
			mount.acceleration.x = 0
			mount.friction = 0.2
			timer = Global.randf_range(1,3)
			mount.anim.play("idle")
	else:
		if(timer <= 0):
			move = true
			if(Global.randi_range(0,2) < 1): mount.flip()
			mount.acceleration.x = mount.facing.x * CHAR_WALKSPEED
			mount.friction = 0.05
			timer = Global.randf_range(0.5,2.0)
			mount.anim.play("walk")
	mount.basicPhysics(delta)

func exit():
	mount.velocity.x = 0
	mount.acceleration.x = 0
	mount.friction = 0.05
