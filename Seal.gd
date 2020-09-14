extends Node2D


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('up'):
		position.y -= 1
		get_node("AudioStreamPlayer").play()
		#sealNoise.play()
	if Input.is_action_pressed('left'):
		position.x -= 1
		get_node("AudioStreamPlayer").play()
	if Input.is_action_pressed('down'):
		position.y += 1
		get_node("AudioStreamPlayer").play()
	if Input.is_action_pressed('right'):
		position.x += 1
		get_node("AudioStreamPlayer").play()
	
	
