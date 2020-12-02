extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animatedSprite = $AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer
onready var slash = load("res://Slash.tscn")
onready var healthBar = get_node("healthBar")
onready var healthBarText = get_node("healthBarText")
onready var scoreText = get_node("scoreText")
onready var scorePupText = get_node("scorePupText")
onready var damagePupText = get_node("damagePupText")
#var slashPos = Vector2.ZERO
var maxHealth = 100
var currentHealth

var anim = "idle"
var state = false
var rng = RandomNumberGenerator.new()
var x = 1
var flag = 0
var facing = 0

var score = 0
var scoreMultiplier = 1
var scoreTimer = Timer.new()

var damageMult = 1
var damageTimer = Timer.new()

var slimeDamageTimer = Timer.new()
var fireDamageTimer = Timer.new()
var slimeAttack = false
var fireAttack = false
# default gameplay movespeed is 1.2
const MOVEMENT_SPEED = 2.5
# Called when the node enters the scene tree for the first time.
func _ready():
	currentHealth = maxHealth
	print(currentHealth)
#
	pass




func _physics_process(delta):
	healthBar.value = currentHealth
	healthBarText.text = String(currentHealth)
	scoreText.text = "Score: " + String(score)
	if currentHealth <= 0:
		die()
	if scoreTimer:
		scorePupText.text = "Double Points: " + String(int(scoreTimer.time_left+1)) + "sec"
	if damageTimer:
		damagePupText.text = "Double Damage: " + String(int(damageTimer.time_left+1)) + "sec"
	var moveSpeed = 60 * delta
	if anim == "attack" && animatedSprite.frame == animatedSprite.frames.get_frame_count("attack")-1:
		anim = "idle"
	var movement = Vector2()
	if Input.is_action_pressed('up'):
		#movement = Vector2(0, -1.2)
		movement.y -= MOVEMENT_SPEED
		anim = "walking"
		if audioPlayer.playing == false:
			audioPlayer.play()
		get_node("AnimatedSprite/Particles2D").emitting = true
	if Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		#movement = Vector2(-1.2, 0)
		movement.x -= MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		facing = 1
		get_node("AnimatedSprite/Particles2D").emitting = true
		get_node("AnimatedSprite/Particles2D").rotation_degrees = 350
	if Input.is_action_pressed('down'):
		#movement = Vector2(0, 1.2)
		movement.y += MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		get_node("AnimatedSprite/Particles2D").emitting = true
	if Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		#movement = Vector2(1.2, 0)
		movement.x += MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		get_node("AnimatedSprite/Particles2D").emitting = true
		get_node("AnimatedSprite/Particles2D").rotation_degrees = 190
		facing = 0
	if Input.is_action_pressed('space'):
		state = true
	if not movement:
		anim = "idle"
		get_node("AnimatedSprite/Particles2D").emitting = false
	
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
	var collision = move_and_collide(movement)
	if collision:
		#print(collision.collider.name)
		if collision.collider.name == "Arrow":
			print("hah")
	
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

func doubleScore():
	scorePupText.percent_visible = 1
	scoreMultiplier = 2
	add_child(scoreTimer)
	scoreTimer.one_shot = true
	scoreTimer.start(20)
	yield(scoreTimer, "timeout")
	scoreMultiplier = 1
	scorePupText.percent_visible = 0

func doubleDamage():
	damageMult = 2
	damagePupText.percent_visible = 1
	add_child(damageTimer)
	damageTimer.one_shot = true
	damageTimer.start(20)
	yield(damageTimer, "timeout")
	damagePupText.percent_visible = 0
	damageMult = 1

func addScore(points):
	score = score + (points * scoreMultiplier)

func die():
	for obj in get_tree().get_root().get_children():
		#slashPos = get_position() + Vector2(1,0)
		if obj.is_in_group("music") or obj.is_in_group("essential"):
			pass
		else:
			remove_child(obj)
			obj.queue_free()
	get_tree().change_scene("GameOverDeath.tscn")


func _on_damage_area_entered(area):
	if area.is_in_group('slime'):
		slimeAttack = true
		currentHealth -= 10
		
		playHurtSound()
		while slimeAttack:
			add_child(slimeDamageTimer)
			slimeDamageTimer.one_shot = true
			slimeDamageTimer.start(1)
			yield(slimeDamageTimer, "timeout")
			playHurtSound()
			currentHealth -= 10
	elif area.is_in_group('fire'):
		fireAttack = true
		currentHealth -= 5
		playHurtSound()
		while fireAttack:
			add_child(fireDamageTimer)
			fireDamageTimer.one_shot = true
			fireDamageTimer.start(0.4)
			yield(fireDamageTimer, "timeout")
			playHurtSound()
			currentHealth-=5
	

func _on_damage_area_exited(area):
	if area.is_in_group('slime'):
		slimeDamageTimer.queue_free()
		slimeDamageTimer = Timer.new()
	if area.is_in_group('fire'):
		fireDamageTimer.queue_free()
		fireDamageTimer = Timer.new()
		
func playHurtSound():
	# also shake the screen
	$Camera2D.shake(0.2, 15, 1.5)
	
	rng.randomize()
	x = rng.randi_range(1,3)
	if x == 1:
		painSound1.play()
	elif x == 2:
		painSound2.play()
	elif x == 3:
		painSound3.play()

