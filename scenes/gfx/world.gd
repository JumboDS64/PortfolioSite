@tool
extends Node2D

@export var surfaceMorph = 0.0

func _ready():
	pass

func _process(delta):
	$surface.material.set_shader_parameter("surfaceMorph", surfaceMorph)
	$clouds.modulate.r = 1-surfaceMorph
	$clouds.modulate.g = 1-surfaceMorph
	$clouds.modulate.b = 1-surfaceMorph
	if(!Engine.is_editor_hint()):
		if(Global.cam2D() == null):
			$surface.material.set_shader_parameter("cam_", Vector2.ZERO)
			$clouds.material.set_shader_parameter("cam_", Vector2.ZERO)
		else:
			$surface.material.set_shader_parameter("cam_", Global.cam2D().position)
			$clouds.material.set_shader_parameter("cam_", Global.cam2D().position)
