extends Area3D

var gc
var dogsOnce = true

func _ready():
	gc = get_tree().get_root().get_node("main")

func _on_body_entered(_body):
	if dogsOnce:
		dogsOnce = false
		gc.playMusic("dog_bark", false)
	
