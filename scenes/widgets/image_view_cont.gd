extends ScrollContainer

var media:Control
var mediaStable:bool
var zoomValue:float
var zoomTarget:float
const ZOOMSPEED = 2
var delta_

func _ready():
	media = null
	mediaStable = false
	zoomValue = 1.0
	zoomTarget = 1.0
	

func _process(delta):
	delta_ = delta
	media = $mediaView/mediaAnchor.get_child(0)
	if(mediaStable):
		zoomValue = lerp(zoomValue, zoomTarget, 0.5)
		zoomTarget = clamp(zoomTarget, 1.0, 4.0)
		media.scale.x = zoomValue*zoomValue*3.5
		media.scale.y = media.scale.x
	else:
		zoomValue = 1.0
		zoomTarget = 1.0

func _gui_input(event):
	if(event is InputEventMouseButton):
		if(event.button_index == 4):
			zoomTarget += ZOOMSPEED*delta_
		if(event.button_index == 5):
			zoomTarget -= ZOOMSPEED*delta_
