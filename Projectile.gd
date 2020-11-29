extends KinematicBody2D


onready var maxSpeed = 100
onready var playerPosition = Vector2.ZERO
onready var direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var x

func _ready():
	yield(get_tree().create_timer(.1), "timeout")
	var origin = self.global_position
#	var blah = get_tree().get_root().get_child(7).get_child(0).name
#	print("blah = ", blah)
	playerPosition = get_tree().get_root().get_child(7).get_child(0).get_global_position()
	direction = (playerPosition - origin).normalized()
	#self.rotation_degrees += 90
	look_at(direction)
	print(direction)

func _physics_process(delta):
	var collision = move_and_collide(direction * delta * maxSpeed)
	var warrior = get_tree().get_root().get_child(7).get_child(0)
	if collision:
		#print(collision.collider.name)
		if collision.collider.name == "warrior_bck":
			# subtract x amount of hp from warrior 
			warrior.playHurtSound()
			warrior.currentHealth -= 5
			print(warrior.currentHealth)
			pass
		queue_free()
	
#func _on_Projectile_body_entered(body):
##	if body.is_in_group("player"):
##		# deal damage and disappear
#	queue_free()



