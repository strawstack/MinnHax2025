extends Node2D

var gc
var onceEnter = true

func _ready():
	gc = get_tree().get_root().get_node("main")

func _on_area_2d_body_entered(_body):
	if onceEnter:
		onceEnter = false
		gc.playMusic("water_splash", true)
