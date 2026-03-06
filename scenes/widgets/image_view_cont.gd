extends ScrollContainer

var image:Control
var imageStable:bool
var zoomValue:float
var zoomTarget:float
const ZOOMSPEED = 20
var delta_

func _ready():
	image = null
	imageStable = false
	zoomValue = 1.0
	zoomTarget = 1.0
	

func _process(delta):
	delta_ = delta
	image = $imageView/imageAnchor.get_child(0)
	if(imageStable):
		zoomValue = lerp(zoomValue, zoomTarget, 0.5)
		zoomTarget = clamp(zoomTarget, 0.5, 8.0)
		image.scale.x = zoomValue*3.5
		image.scale.y = zoomValue*3.5
	else:
		zoomValue = 1.0
		zoomTarget = 1.0

func _gui_input(event):
	print(event)
	if(event is InputEventMouseButton):
		if(event.button_index == 4):
			zoomTarget += ZOOMSPEED*delta_
		if(event.button_index == 5):
			zoomTarget -= ZOOMSPEED*delta_
