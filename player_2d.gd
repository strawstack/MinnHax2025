extends CharacterBody2D

# Constants
var fps_scale = 60
var speed = 3 * 64 * fps_scale
var jump_force = -1 * 4 * 64 * fps_scale
var gravity = 10 * 64 * fps_scale

# Tracking variables
var jump_velocity = 0
var canJump = false
var canMove = false

# Refs
var gc_2d
var sprite

func _ready():
	gc_2d = get_tree().get_root().get_node("main_2d")
	sprite = $Sprite2D

func _process(delta):
	var vec = Vector2.ZERO

	if Input.is_action_pressed("right") and canMove:
		sprite.set_flip_h(false)
		vec.x = speed

	if Input.is_action_pressed("left") and canMove:
		sprite.set_flip_h(true)
		vec.x = -1 * speed

	if Input.is_action_just_pressed("space") and canMove:
		if canJump: 
			canJump = false
			jump_velocity = jump_force

	vec.y = jump_velocity
	jump_velocity += gravity * delta
	if canJump:
		jump_velocity = 0
	
	velocity = vec * delta
	move_and_slide()

func _on_area_2d_body_entered(body):
	var isIce = body.name.contains("ice_")
	var isUnder = body.name.contains("under_")
	if isIce:
		canJump = true
	if isUnder:
		gc_2d.showDunk()

func _on_area_2d_body_exited(body):
	var isIce = body.name.contains("ice_")
	if isIce:
		canJump = false
