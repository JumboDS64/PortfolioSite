extends CharacterBody2D

@export var category:String

func _ready():
	pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == 1 and event.pressed):
			Global.MAIN.set_mode("category_"+category)
