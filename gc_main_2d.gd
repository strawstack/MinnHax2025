extends Node2D

var player
var camera
var animation 

var once_start_button = true
var once_dunk = true
var isShowDunk = false

var gc

@export var door: Node2D

func _ready():
	gc = get_tree().get_root().get_node("main")
	player = $Player
	camera = $Camera2D
	animation = $AnimationPlayer

func toggleDoor(open):
	door.toggleDoor(open)

func wake_up_pressed():
	if once_start_button:
		once_start_button = false
		animation.play("fade_out_ui")

func tween_complete():
	camera.reparent(player)
	player.canMove = true

func camera_to_player_tween():
	var to = $Player.position
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "position", to, 2.0)
	tween.tween_callback(tween_complete)

func showDunk():
	await get_tree().create_timer(1.0).timeout
	animation.play("show_dunk")

func beginDunk():
	player.canMove = false
	camera.zoom()
	await camera.animation_completed
	animation.play("player_dunk")

func whiteOut():
	animation.play("white_out")

func setPoster():
	toggleDoor(false) # Close the door
	camera.set_zoom(Vector2.ONE) # Zoom camera back out
	player.get_node("Sprite2D").set_flip_h(false) # Face right
	player.get_node("Sprite2D").set_offset(Vector2.ZERO) # Reverse dunk offset
	player.position = $Points/PLAYER_START.position # Move player to start
	$Poster.visible = true
	animation.play("reverse_white_out")

func _process(_delta):
	if Input.is_action_just_pressed("space") and isShowDunk and once_dunk:
		once_dunk = false
		beginDunk()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out_ui":
		camera_to_player_tween()

	if anim_name == "show_dunk":
		isShowDunk = true
	
	if anim_name == "player_dunk":
		whiteOut()
	
	if anim_name == "white_out":
		setPoster()
	
	if anim_name == "reverse_white_out":
		gc.playerCanMove()
