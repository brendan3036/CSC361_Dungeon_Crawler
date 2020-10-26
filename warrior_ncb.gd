extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animatedSprite = $AnimatedSprite
var attackAnimationCompleted = true
var anim = "idle"
var attackAnim = "idle"
var state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var movement = Vector2(0, 0)
	if Input.is_action_pressed('up'):
		movement = Vector2(0, -1)
		anim = "walking"
		#sealNoise.play()
	elif Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-1, 0)
		get_node("AudioStreamPlayer").play()
		anim = "walking"
	elif Input.is_action_pressed('down'):
		movement = Vector2(0, 1)
		get_node("AudioStreamPlayer").play()
		anim = "walking"
	elif Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(1, 0)
		get_node("AudioStreamPlayer").play()
		anim = "walking"
	else:
		anim = "idle"
	if state:
		anim = "attack"
	animatedSprite.play(anim)
	self.move_and_collide(movement)
	
func _input(event):
	if event.is_action_pressed('space'):
		state = true
	pass
	

