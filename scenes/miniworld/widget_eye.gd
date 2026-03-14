@tool
class_name FeatureEye
extends Node2D

@export var texture:Texture2D
@export var textureUV:Vector2
@export var textureScale:int
@export var bounds:Vector2
@export var browRest:Vector2

@export var gazeAngle:float # 0 to Global.TWO_PI
@export var gazeDist:float # 0 to 1

func _ready():
	initGFX()

func _process(delta):
	if(Engine.is_editor_hint()):
		initGFX()
	gazeAngle = fposmod(gazeAngle, Global.TWO_PI)
	gazeDist = clamp(gazeDist, 0, 1)
	$inner/ball.position.x = cos(gazeAngle) * gazeDist * bounds.x
	$inner/ball.position.y = sin(gazeAngle) * gazeDist * bounds.y

func initGFX():
	var s = Vector2(textureScale,textureScale)
	$inner.texture = texture
	$inner.region_rect.position = textureUV
	$inner.region_rect.size = s
	$inner/ball.texture = texture
	$inner/ball.region_rect.position = textureUV + Vector2.DOWN*textureScale
	$inner/ball.region_rect.size = s
	$frame.texture = texture
	$frame.region_rect.position = textureUV
	$frame.region_rect.size = s
	$brow.texture = texture
	$brow.region_rect.position = textureUV + Vector2.RIGHT*textureScale + Vector2.DOWN*textureScale
	$brow.region_rect.size = s
	$brow.position = browRest

func look(pos):
	var dir = pos - global_transform.origin
	gazeAngle = dir.angle() - global_transform.get_rotation()
	gazeDist = 1.0
