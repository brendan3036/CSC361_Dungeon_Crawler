extends KinematicBody2D


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed('up'):
		movement = Vector2(0, -1)
		get_node("AudioStreamPlayer").play()
		#sealNoise.play()
	if Input.is_action_pressed('left'):
		movement = Vector2(-1, 0)
		get_node("AudioStreamPlayer").play()
	if Input.is_action_pressed('down'):
		movement = Vector2(0, 1)
		get_node("AudioStreamPlayer").play()
	if Input.is_action_pressed('right'):
		movement = Vector2(1, 0)
		get_node("AudioStreamPlayer").play()
		
	self.move_and_collide(movement)
	
	
