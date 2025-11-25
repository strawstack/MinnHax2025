extends Node2D

var gc
var onceOpen = true

func _ready():
	gc = get_tree().get_root().get_node("main")

func toggleDoor(open):
	$DoorOpen.visible = open

func _on_area_2d_body_entered(_body):
	if onceOpen:
		onceOpen = false
		gc.playMusic("door_slam_open", true)
		toggleDoor(true)
