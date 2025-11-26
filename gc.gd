extends Node3D

# Variable
var once_wake_up = true

# Ref
@export var gc_2d: Node2D
@export var song: Area3D
@export var dogs: Area3D

var player
# var spectrumAnalyzer

func _ready():
	# spectrumAnalyzer = AudioServer.get_bus_effect_instance(0, 0)
	player = $Player

func playerCanMove():
	player.canMove = true

func lightLevel_Unused():
	# var amp = spectrumAnalyzer.get_magnitude_for_frequency_range(0, 44000)
	# micLight.set_param(0, amp.x)
	pass

func _process(_delta):
	# Unused - Set light level
	# mlight.set_param(0, 0.3 - lebooboo.position.y + 0.2)

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
	player.canMove = false
	$AnimationPlayer.stop() # Ghost stop bobbing
	player.position = $Points/PLAYER_START.position
	player.set_rotation(Vector3.ZERO)
	player.get_node("Pivot").set_rotation(Vector3.ZERO)
	player.get_node("Pivot/Camera3D").set_rotation(Vector3.ZERO)
	song.songOnce = true
	dogs.dogsOnce = true

func songEnds():
	reset3D()
	gc_2d.reset2D()
	$CanvasLayer/AnimationPlayer.play("reverse_white_out_3d")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "white_out_3d":
		songEnds()

	if anim_name == "reverse_white_out_3d":
		playMusic("lo_fi_loop", true)
		gc_2d.once_start_button = true
		once_wake_up = true
