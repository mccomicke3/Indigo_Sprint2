extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
var speed = 100
const JUMP_HEIGHT = 500
var motion = Vector2()
var jump_count = 1 

func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_left"):
		motion.x = -speed
		if is_on_floor():
			$AnimationPlayer.play('Walk')
		$Sprite.set_flip_h(false)
	elif Input.is_action_pressed("ui_right"):
		motion.x = speed
		if is_on_floor():
			$AnimationPlayer.play('Walk')
		$Sprite.set_flip_h(true)
	else:
		motion.x = 0
	if motion.x == 0 && is_on_floor():
		$AnimationPlayer.play('Idle')
	if Input.is_action_just_pressed("ui_up") && jump_count > 0:
		motion.y = -JUMP_HEIGHT
		$AnimationPlayer.play('Jump')
		jump_count -= 1
	if is_on_floor():
		jump_count = 1
	if Input.is_action_pressed('ui_up') && is_on_wall():
		motion.y = -JUMP_HEIGHT
	if Input.is_action_pressed("ui_space"):
		speed = 200
	else:
		speed = 100
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("ui_accept"):
		#comment: try to find how to determine which collide i hit
		#and if it is a obstacle then disable or hide the node
		print(get_slide_collision(get_slide_count()-1).collider_shape)
	motion = move_and_slide(motion, UP)
