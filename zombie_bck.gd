extends AnimatedSprite


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
	if Input.is_action_pressed("move_up"):
		#move up
		position.y -= .1
		sound.play()
	elif Input.is_action_pressed("move_down"):
		position.y += .1
		sound.play()
	elif Input.is_action_pressed("move_left"):
		position.x -= .1
		sound.play()
	elif Input.is_action_pressed("move_right"):
		position.x += .1
		sound.play()
	
	
	
	pass

