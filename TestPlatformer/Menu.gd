extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_Resume_pressed():
	visible = false
	get_tree().paused = false
		
func _on_Quit_pressed():
	get_tree().quit()


func _on_bFullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
