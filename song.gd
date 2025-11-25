extends Area3D

var gc
var songOnce = true

func _ready():
	gc = get_tree().get_root().get_node("main")

func _on_body_entered(_body):
	if songOnce:
		songOnce = false
		gc.playMusic("song", true)
		gc.startGhost()
