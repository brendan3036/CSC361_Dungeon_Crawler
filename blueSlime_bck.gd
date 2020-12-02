extends KinematicBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var x = 1
var health = 100
onready var animatedSprite = $AnimatedSprite
onready var healthBar = get_node("healthBar")
var anim = "idle"
var moveSpeed = 0
var attackFlag = false
var warrior
# Called when the node enters the scene tree for the first time.
func _ready():
	warrior = get_tree().get_root().get_node("Game").get_node("warrior_bck")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(.4)
	timer.connect("timeout", self, "_timeout")
	

func _timeout():
	rng.randomize()
	x = rng.randi_range(1,10)
	# up
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthBar.value = health
	if health <= 0:
		warrior.addScore(50)
		queue_free()
	var origin = self.global_position
	var playerPosition = warrior.get_global_position()
	var direction = (playerPosition - origin).normalized()
	
	moveSpeed = 50 * delta
	var movement = Vector2(0, 0)
	if attackFlag and x > 5:
		movement = direction * moveSpeed
		anim = "walking"
	elif x == 1:
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
	



func _on_attack_ranged_entered(area):
	if area.is_in_group("player"):
		attackFlag = true


func _on_attack_range_exited(area):
	if area.is_in_group("player"):
		attackFlag = false
