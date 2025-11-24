extends Node3D

# Variable
var once_wake_up = true

# Ref
@export var gc_2d: Node2D
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
