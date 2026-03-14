@tool
extends Node2D

@export var texture:Texture2D
@export var textureUV:Vector2
@export var textureScale:Vector2
@export var rangeLeft:float #pixels leftwards of center of lip texture that the lips extend to
@export var rangeRight:float #pixels rightwards of center of lip texture that the lips extend to

@export var smileU:float
@export var smileB:float

func _ready():
	initGFX()
	

func _process(delta):
	if(Engine.is_editor_hint()):
		initGFX()
	smileU = clamp(smileU, -1, 1)
	smileB = clamp(smileB, -1, 1)
	$mouth.material.set_shader_parameter("offU", smileU/2.5)
	$mouth.material.set_shader_parameter("offB", smileB/2.5)

func initGFX():
	$mouth.texture = texture
	$mouth.region_rect.position = textureUV
	$mouth.region_rect.size = textureScale
	$mouth.region_rect.size.y *= 2.0
	$mouth.material.set_shader_parameter("uvP", $mouth.region_rect.position / texture.get_size())
	$mouth.material.set_shader_parameter("uvS", $mouth.region_rect.size / texture.get_size())
	$mouth.material.set_shader_parameter("p", Vector2(1.0/texture.get_size().x, 1.0/texture.get_size().y))
	$mouth.material.set_shader_parameter("rangeLeft", rangeLeft)
	$mouth.material.set_shader_parameter("rangeRight", rangeRight)
