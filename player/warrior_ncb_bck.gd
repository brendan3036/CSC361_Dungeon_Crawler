extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer
onready var slash = load("res://player/Slash.tscn")
onready var healthBar = get_node("healthBar")
onready var healthBarText = get_node("healthBarText")
onready var scoreText = get_node("scoreText")
onready var scorePupText = get_node("scorePupText")
onready var damagePupText = get_node("damagePupText")

var maxHealth = 100
var currentHealth
var dying = false
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
var deathTimer = Timer.new()
var slimeAttack = false
var fireAttack = false
# Default gameplay movespeed is 1.5
const MOVEMENT_SPEED = 1.5

# Set currentHealth to maxHealth
func _ready():
	currentHealth = maxHealth
	pass

func _physics_process(delta):
	# Keep our health bar's value updated 
	# as well as our score.
	healthBar.value = currentHealth
	healthBarText.text = String(currentHealth)
	scoreText.text = "Score: " + String(score)
	
	# If we died then go ahead and die.
	if currentHealth <= 0:
		die()
	# Have text show for double score timer and damage timer if they are 'active'
	if scoreTimer:
		scorePupText.text = "Double Points: " + String(int(scoreTimer.time_left+1)) + "s"
	if damageTimer:
		damagePupText.text = "Double Damage: " + String(int(damageTimer.time_left+1)) + "s"

	var moveSpeed = 60 * delta
#	
	var movement = Vector2()
	# Up
	if Input.is_action_pressed('up'):
		movement.y -= MOVEMENT_SPEED
		anim = "walking"
		# Walking Sound
		if audioPlayer.playing == false:
			audioPlayer.play()
		# Walking Particles
		get_node("AnimatedSprite/Particles2D").emitting = true
	if Input.is_action_pressed('left'):
		get_node("AnimatedSprite").flip_h = true
		movement.x -= MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		facing = 1
		get_node("AnimatedSprite/Particles2D").emitting = true
		get_node("AnimatedSprite/Particles2D").rotation_degrees = 350
	if Input.is_action_pressed('down'):
		movement.y += MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		get_node("AnimatedSprite/Particles2D").emitting = true
	if Input.is_action_pressed('right'):
		get_node("AnimatedSprite").flip_h = false
		movement.x += MOVEMENT_SPEED
		if audioPlayer.playing == false:
			audioPlayer.play()
		anim = "walking"
		get_node("AnimatedSprite/Particles2D").emitting = true
		get_node("AnimatedSprite/Particles2D").rotation_degrees = 190
		facing = 0
	# Space is our attack button, we use a state boolean for the timing of it.
	if Input.is_action_pressed('space'):
		if flag == 0:
			state = true
			slash()
	if not movement and state:
		anim = "attack"
		state = false
	elif not movement:
		anim = "idle"
		get_node("AnimatedSprite/Particles2D").emitting = false
	
	animatedSprite.play(anim)
	var collision = move_and_collide(movement)

# Very messy and confusing timer stuff but it works *shrug*
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
	sword.play()
	$Camera2D.shake(0.2, 15, 1.5)
	add_child(node)
	var timer2 = Timer.new()
	add_child(timer2)
	timer2.one_shot = true
	# One second attack cooldown
	timer2.start(1)
	timer2.connect("timeout", self, "attack_timeout")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	# 0.25 second attack duration
	timer.start(.25)
	timer.connect("timeout", self, "_timeout")
	yield(timer, "timeout")

# Get rid of our slash
func _timeout():
	for obj in get_tree().get_root().get_children():
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
	# When player dies, play death sound, free up all nonessential(autoloaded)
	# assets, and change to game over scene.
	deathSound.play()
	for obj in get_tree().get_root().get_children():
		if obj.is_in_group("music") or obj.is_in_group("essential"):
			pass
		else:
			remove_child(obj)
			obj.queue_free()
	get_tree().change_scene("res://menu/GameOverDeath.tscn")


func _on_damage_area_entered(area):
	# Slimes deal 10 damage, and will do so every 1 second of collision
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
	# Fire deals 5 damage (stackable with multiple instances) every 0.4 seconds.
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
	
# Free up the timers if we leave the areas.
func _on_damage_area_exited(area):
	if area.is_in_group('slime'):
		slimeDamageTimer.queue_free()
		slimeDamageTimer = Timer.new()
	if area.is_in_group('fire'):
		fireDamageTimer.queue_free()
		fireDamageTimer = Timer.new()
		
func playHurtSound():
	# Also shake the screen
	if currentHealth == 0:
		return
	$Camera2D.shake(0.2, 50, 1.5)
	# Choose a random pain sound (1 pain sound is too monotonous)
	rng.randomize()
	x = rng.randi_range(1,3)
	if x == 1:
		painSound1.play()
	elif x == 2:
		painSound2.play()
	elif x == 3:
		painSound3.play()

