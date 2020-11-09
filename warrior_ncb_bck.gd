extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animatedSprite = $AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer
onready var slash = load("res://Slash.tscn")
var slashPos = Vector2.ZERO
var attackAnimationCompleted = true
var anim = "idle"
var attackAnim = "idle"
var state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var movement = Vector2(0, 0)
	if animatedSprite.animation == "attack" && animatedSprite.frame == animatedSprite.frames.get_frame_count("attack")-1:
		state = false
		anim = "idle"
	if Input.is_action_pressed('up'):
		movement = Vector2(0, -1.2)
		anim = "walking"
		if audioPlayer.playing == false:
			audioPlayer.play()
	elif Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-1.2, 0)
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
	elif Input.is_action_pressed('down'):
		movement = Vector2(0, 1.2)
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
	elif Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(1.2, 0)
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
	else:
		anim = "idle"
	# If state, perform attack animation and instance the slash area/animation
	if state:
		slash()
		anim = "attack"
#	for obj in get_children():
#		if obj.is_in_group("beta"):
#			remove_child(obj)
#			obj.queue_free()
	animatedSprite.play(anim)
	self.move_and_collide(movement)
	
func _input(event):
	if event.is_action_pressed('space'):
		state = true
	pass
	
func slash():
	# Get the position of where the slash will be
	slashPos = get_global_position() + Vector2(1,0)
	var node = slash.instance()
	node.set_position(slashPos)
	add_child(node)
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(1)
	timer.connect("timeout", self, "_timeout")
	#node.set_position(global_position + Vector2(10, 0))
	
func _timeout():
	for obj in get_children():
		slashPos = get_position() + Vector2(1,0)
		if obj.is_in_group("beta"):
			remove_child(obj)
			obj.queue_free() 
	
	

