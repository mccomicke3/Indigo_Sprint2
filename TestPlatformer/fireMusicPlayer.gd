extends AudioStreamPlayer2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_volume_db(-80)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().currentElement == 1:
		set_volume_db(0)
		print("firevolume")
	else:
		set_volume_db(-80)