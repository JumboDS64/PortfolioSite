@tool
extends Node2D

func _ready():
	pass

func _process(delta):
	if(!Engine.is_editor_hint()):
		$surface.material.set_shader_parameter("cam_", get_viewport().get_camera_2d().position)
		$clouds.material.set_shader_parameter("cam_", get_viewport().get_camera_2d().position)
