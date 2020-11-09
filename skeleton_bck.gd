extends KinematicBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var x = 1
onready var animatedSprite = $AnimatedSprite
onready var bullet = load("res://Projectile.tscn")
var anim = "idle"
var moveSpeed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(.5)
	timer.connect("timeout", self, "_timeout")
	
	

func _timeout():
	rng.randomize()
	x = rng.randi_range(1,10)
	if x > 4:
		# We have the player's position
		var playerPosition = get_tree().get_root().get_node("Node2D/Node2D/warrior_bck").get_global_position()
		# Pos = skeleton's position (locally)
		var pos = get_position()
		var skellyGlobal = get_global_position()
		var offset = 20
		var bulletSpawn = Vector2(pos.x - offset, pos.y + offset)
		
		if playerPosition.x > skellyGlobal.x:
			#bullet x needs to be on the right
			bulletSpawn.x = pos.x + offset
		if playerPosition.y < skellyGlobal.y:
			#bullet y needs to be up
			bulletSpawn.y = pos.y - offset
			
		var node = bullet.instance()
		var tree = get_tree().get_root()
		tree.add_child(node)
		node.set_position(bulletSpawn)
	# up
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Use delta to calculate movement
	# 30 * delta
	moveSpeed = 60 * delta
	var movement = Vector2(0, 0)
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
	

