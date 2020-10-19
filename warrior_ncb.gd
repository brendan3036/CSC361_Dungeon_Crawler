extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed('up'):
		movement = Vector2(0, -1)
		get_node("AudioStreamPlayer").play()
		get_node("AnimatedSprite").play("walking")
		#sealNoise.play()
	elif Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-1, 0)
		get_node("AudioStreamPlayer").play()
		get_node("AnimatedSprite").play("walking")
	elif Input.is_action_pressed('down'):
		movement = Vector2(0, 1)
		get_node("AudioStreamPlayer").play()
		get_node("AnimatedSprite").play("walking")
	elif Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(1, 0)
		get_node("AudioStreamPlayer").play()
		get_node("AnimatedSprite").play("walking")
	elif Input.is_action_pressed('space'):
		#get_node("AudioStreamPlayer").play()
		get_node("AnimatedSprite").play("attack")
		
	else:
		get_node("AnimatedSprite").play("idle")
	self.move_and_collide(movement)
	

