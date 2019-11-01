extends KinematicBody2D

const UP = Vector2(0,-1)
var grav = 20
var speed = 100
var jumpHeight = 500
var motion = Vector2()
var jump_count = 1 

enum ElementState{ 
	None,
	Fire,
	Water,
	Wind
}
var currentElement = ElementState.None

func _physics_process(delta):
	
	_movement(delta)
	_element_interaction()
	
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()

func _element_interaction():
	var get_col = null
	if (get_slide_count() > 0):
		get_col = get_slide_collision(get_slide_count()-1)
		
	if get_col != null:
		if get_col.collider.is_in_group("fire"):
			print("fire")
			if (currentElement == ElementState.Fire):
				get_col.collider.free()
		elif get_col.collider.is_in_group("water"):
			print("water")
			if (currentElement == ElementState.Water):
				get_col.collider.free()
		elif get_col.collider.is_in_group("wind"):
			print("wind")
			if (currentElement == ElementState.Wind):
				get_col.collider.free()

func _movement(delta):
	motion.y += grav
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
		motion.y = -jumpHeight
		$AnimationPlayer.play('Jump')
		jump_count -= 1
	if is_on_floor():
		jump_count = 1
	if Input.is_action_pressed('ui_up') && is_on_wall():
		motion.y = -jumpHeight
	if Input.is_action_pressed("ui_space"):
		speed = 200
	else:
		speed = 100
		
		
	motion = move_and_slide(motion, UP)