extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var x = 1
onready var animatedSprite = $AnimatedSprite
onready var bullet = load("res://enemies/Projectile.tscn")
onready var healthBar = get_node("healthBar")
var anim = "idle"
var moveSpeed = 0
var health = 100
var attackFlag = false
var warrior

# Get warrior object to reference since we need his position for things.
func _ready():
	warrior = get_tree().get_root().get_node("Game").get_node("warrior_bck")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(.5)
	timer.connect("timeout", self, "_timeout")
	
	
# On every function call here, randomize and set to x, and we have
# basically a 40% chance the skeleton will be attacking here.
func _timeout():
	rng.randomize()
	x = rng.randi_range(1,10)
	# x > 1 is 90% chance, x > 9 is 10% chance
	if x > 5 and attackFlag:
		# We have the player's position
		var playerPosition = warrior.get_global_position()
		# Pos = skeleton's position (locally)
		var pos = get_position()
		var skellyGlobal = get_global_position()
		var offset = 20
		var bulletSpawn = Vector2(pos.x - offset, pos.y)
		var node = bullet.instance()
		node.look_at(playerPosition)
		if playerPosition.x > skellyGlobal.x:
			#bullet x needs to be on the right
			bulletSpawn.x = pos.x + offset
			
		var tree = get_tree().get_root()
		tree.add_child(node)
		node.set_position(bulletSpawn)
	
func _process(delta):
	healthBar.value = health
	# If it dies, add 50 score to warrior and free it up.
	if health <= 0:
		warrior.addScore(50)
		queue_free()
	# Use delta to calculate movement
	moveSpeed = 60 * delta
	var movement = Vector2(0, 0)
	# Random movement pattern but something better could be made 
	# if this is anything but a class project.
	if x == 1:
		anim = "walking"
		movement = Vector2(0, -moveSpeed)
	# left
	elif x == 2:
		anim = "walking"
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-moveSpeed, 0)
	# down
	elif x == 3:
		anim = "walking"
		movement = Vector2(0, moveSpeed)
	# right
	elif x == 4:
		anim = "walking"
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(moveSpeed, 0)
	# up
	else:
		anim = "idle"
		movement = Vector2(0,0)
		
	animatedSprite.play(anim)
	self.move_and_collide(movement)
	
func _on_AttackRange_area_entered(area):
	if area.is_in_group("player"):
		attackFlag = true

func _on_AttackRange_area_exited(area):
	if area.is_in_group("player"):
		attackFlag = false
