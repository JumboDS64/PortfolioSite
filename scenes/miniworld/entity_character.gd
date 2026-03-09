@tool
extends Entity

@export var texture:Texture2D

func _ready():
	initGFX()
	curState = "wander"
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)

func _process(delta):
	if(Engine.is_editor_hint()):
		initGFX()

func initGFX():
	$sprite/polys/arm_b.texture = texture
	$sprite/polys/leg_b.texture = texture
	$sprite/polys/torso.texture = texture
	$sprite/polys/head.texture = texture
	$sprite/polys/leg_f.texture = texture
	$sprite/polys/arm_f.texture = texture

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1):
			if(event.pressed):
				setNext("dragged")

func _input(event):
	if(event is InputEventMouseButton):
		if(event.button_index == 1):
			if(!event.pressed and curState == "dragged"):
				setNext("wander")
