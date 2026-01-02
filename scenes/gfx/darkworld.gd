@tool
extends Node2D

func _ready():
	pass

func _process(delta):
	if(!Engine.is_editor_hint()):
		if(get_viewport().get_camera_2d() == null):
			$surface.material.set_shader_parameter("cam_", Vector2.ZERO)
			$clouds.material.set_shader_parameter("cam_", Vector2.ZERO)
		else:
			$surface.material.set_shader_parameter("cam_", get_viewport().get_camera_2d().position)
			$clouds.material.set_shader_parameter("cam_", get_viewport().get_camera_2d().position)
