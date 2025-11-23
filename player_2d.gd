extends CharacterBody2D

var speed = 10000
var jump = 10000
var gravity = 5000

var sprite

func _ready():
	sprite = $Sprite2D


func _process(delta):
	var vec = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		sprite.set_flip_h(false)
		vec.x = delta * speed
	
	if Input.is_action_pressed("left"):
		sprite.set_flip_h(true)
		vec.x = delta * -1 * speed
	
	if Input.is_action_just_pressed("space"):
		vec.y = -1 * jump
	
	vec.y += gravity
	
	velocity = vec
	print(velocity)
	move_and_slide()
