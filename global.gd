extends Node

const WINDOW_WIDTH = 1152
const WINDOW_HEIGHT = 648
const TWO_PI = PI*2

var PATH_MODES = "res://scenes/modes/"
var PATH_MUSIC = "res://assets/music/"
var PATH_SFX = "res://assets/sfx/"

var rng = RandomNumberGenerator.new()

var time = 0

func _ready():
	time = 0

func _process(delta):
	time += delta

func randf_range(min,max):
	return rng.randf_range(min,max)
func randi_range(min,max):
	return rng.randi_range(min,max)
