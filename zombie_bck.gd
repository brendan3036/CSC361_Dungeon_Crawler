extends KinematicBody2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sound = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(sound)
	sound.stream = load("res://boneBreaking_snd.wav")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed("move_up"):
		#move up
		movement = Vector2(0, -.5)
		sound.play()
	elif Input.is_action_pressed("move_down"):
		movement = Vector2(0, .5)
		sound.play()
	elif Input.is_action_pressed("move_left"):
		movement = Vector2(-.5, 0)
		sound.play()
	elif Input.is_action_pressed("move_right"):
		movement = Vector2(.5, 0)
		sound.play()
	self.move_and_collide(movement)
	
	
	
	pass

