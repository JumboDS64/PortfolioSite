@tool
class_name Entity
extends CharacterBody2D

var mode
var room
var states:Dictionary
var curState:String
var nexState:String
var nexState_msg:Dictionary

var sprite:Node2D
var anim:AnimationPlayer
var facing:Vector2

var acceleration:Vector2
var friction:float

func _ready():
	room = get_node("../..")
	mode = get_node("../../..")
	sprite = $sprite
	anim = $sprite/anim
	facing = Vector2(1.0,0.0)
	acceleration = Vector2.ZERO
	friction = 0.05
	if(!Engine.is_editor_hint()):
		for s in $states.get_children():
			states[s.name] = s
		for n in states:
			states[n].init(self)

func _physics_process(delta):
	if(Engine.is_editor_hint()):
		return
	states[curState].act(delta)
	if(nexState != ""):
		states[curState].exit()
		curState = nexState
		states[curState].enter(nexState_msg)
		nexState = ""
	velocity += acceleration*delta
	move_and_slide()

func setNext(s:String,m:Dictionary={}):
	nexState = s
	nexState_msg = m

func flip():
	facing.x *= -1
	sprite.scale.x *= -1

func basicPhysics(delta):
	velocity.x *= 1-friction
	velocity.y += Global.GRAVITY*delta
