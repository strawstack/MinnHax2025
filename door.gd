extends Node2D

func toggleDoor(open):
	$DoorOpen.visible = open

func _on_area_2d_body_entered(body):
	toggleDoor(true)
