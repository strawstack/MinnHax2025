extends Camera2D

var animation

signal animation_completed

func _ready():
	animation = $AnimationPlayer

func zoom():
	animation.play("camera_zoom")

func _on_animation_player_animation_finished(_anim_name):
	animation_completed.emit()
