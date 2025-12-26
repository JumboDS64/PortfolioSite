extends StaticBody2D

@export var vec:Vector2
@export var camera:Camera2D
var isMouse:bool

func _ready():
	input_pickable = true

func _on_mouse_entered() -> void:
	print(name)
	isMouse = true

func _on_mouse_exited() -> void:
	isMouse = false

func _process(delta):
	if(isMouse):
		camera.position += vec*400*delta
