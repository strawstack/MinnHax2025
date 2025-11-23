extends Node2D

var player
var camera
var animation 


func _ready():
	player = $Player
	camera = $Camera2D
	animation = $AnimationPlayer

func _on_start_button_pressed():
	animation.play("fade_out_ui")

func tween_complete():
	camera.reparent(player)

func camera_to_player_tween():
	var to = $Player.position
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "position", to, 2.0)
	tween.tween_callback(tween_complete)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out_ui":
		camera_to_player_tween()
