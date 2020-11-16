extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animatedSprite = $AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer
onready var slash = load("res://Slash.tscn")#
onready var healthBar = get_node("healthBar")
onready var healthBarText = get_node("healthBarText")
#var slashPos = Vector2.ZERO
var maxHealth = 5
var currentHealth
var anim = "idle"
var state = false
var flag = 0
var facing = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	print(currentHealth)
#	var healthb = healthBar.instance()
#	healthb.set_position(Vector2(get_position().x-400, get_position().y+400))
#	self.add_child(healthb)
	pass


func _physics_process(delta):
	healthBar.value = currentHealth
	healthBarText.text = String(currentHealth)
	if currentHealth <= 0:
		die()
	var moveSpeed = 60 * delta
	if anim == "attack" && animatedSprite.frame == animatedSprite.frames.get_frame_count("attack")-1:
		anim = "idle"
	var movement = Vector2()
	if Input.is_action_pressed('up'):
		#movement = Vector2(0, -1.2)
		movement.y -= 1.2
		anim = "walking"
		if audioPlayer.playing == false:
			audioPlayer.play()
	if Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		#movement = Vector2(-1.2, 0)
		movement.x -= 1.2
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		facing = 1
	if Input.is_action_pressed('down'):
		#movement = Vector2(0, 1.2)
		movement.y += 1.2
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
	if Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		#movement = Vector2(1.2, 0)
		movement.x += 1.2
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		facing = 0
	if Input.is_action_pressed('space'):
		state = true
	if not movement:
		anim = "idle"
	
	# If state, perform attack animation and instance the slash area/animation
	if state:
		if flag == 0:
			#anim = "attack"
			slash()
			
	if state and not movement:
		state = false
		anim = "attack"
#	for obj in get_children():
#		if obj.is_in_group("beta"):
#			remove_child(obj)
#			obj.queue_free()

	animatedSprite.play(anim)
	self.move_and_collide(movement)
	
func _input(event):
	
	pass
	
func slash():
	flag = 1
	# Get the position of where the slash will be
	var node = slash.instance()
	var offset = Vector2()
	if facing == 0:
		offset = Vector2(30, 0)
		node.get_node("AnimatedSprite").flip_h = false
	else:
		offset = Vector2(-30, 0)
		node.get_node("AnimatedSprite").flip_h = true
	var slashPos = get_position() + offset
	
	var tree = get_tree().get_root()
	tree.add_child(node)
	node.set_position(slashPos)
	add_child(node)
	var timer2 = Timer.new()
	add_child(timer2)
	timer2.one_shot = true
	timer2.start(1)
	timer2.connect("timeout", self, "attack_timeout")
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(.25)
	timer.connect("timeout", self, "_timeout")
	yield(timer, "timeout")
	#node.set_position(global_position + Vector2(10, 0)))
func _timeout():
	for obj in get_tree().get_root().get_children():
		#slashPos = get_position() + Vector2(1,0)
		if obj.is_in_group("beta"):
			remove_child(obj)
			obj.queue_free()
			

func attack_timeout():
	flag = 0

func die():
	for obj in get_tree().get_root().get_children():
		#slashPos = get_position() + Vector2(1,0)
		if obj.is_in_group("music"):
			pass
		else:
			remove_child(obj)
			obj.queue_free()
	get_tree().change_scene("MainMenu.tscn")
