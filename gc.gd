extends Node3D

# Variable
var once_wake_up = true

# Ref
@export var gc_2d: Node2D
@export var song: Area3D
@export var dogs: Area3D

var player

func _ready():
	player = $Player

func playerCanMove():
	player.canMove = true

func _process(_delta):
	if Input.is_action_just_pressed("space"):
		if once_wake_up:
			once_wake_up = false
			gc_2d.wake_up_pressed()

func startGhost():
	$AnimationPlayer.play("LeBooBoo_Float")

func playMusic(trackName, start):
	if start:
		get_node("AudioStream/" + trackName).play()
	else:
		get_node("AudioStream/" + trackName).stop()

func _on_song_finished():
	$CanvasLayer/AnimationPlayer.play("white_out_3d")

func reset3D():
	$AnimationPlayer.stop() # Ghost stop bobbing
	player.position = $Points/PLAYER_START.position
	player.rotation = Vector3.ZERO
	song.songOnce = true
	dogs.dogsOnce = true

func reset2D():
	gc_2d.reset2D()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "white_out_3d":
		reset3D()
		reset2D()
		$CanvasLayer/AnimationPlayer.play("reverse_white_out_3d")

	if anim_name == "reverse_white_out_3d":
		playMusic("lo_fi_loop", true)
		gc_2d.once_start_button = true
