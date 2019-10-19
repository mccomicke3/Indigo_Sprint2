extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = 500
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0
	if Input.is_action_pressed("ui_up") && is_on_floor():
		motion.y = -JUMP_HEIGHT
	if Input.is_action_pressed("ui_accept"):
		#comment: try to find how to determine which collide i hit
		#and if it is a obstacle then disable or hide the node
		print(get_slide_collision(get_slide_count()-1).collider_shape)
	motion = move_and_slide(motion, UP)
