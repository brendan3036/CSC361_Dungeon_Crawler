extends KinematicBody2D


onready var maxSpeed = 100
onready var playerPosition = Vector2.ZERO
onready var direction = Vector2.ZERO

func _ready():
	yield(get_tree().create_timer(.1), "timeout")
	var origin = self.global_position
	playerPosition = get_tree().get_root().get_node("Node2D/Node2D/warrior_bck").get_global_position()
	direction = (playerPosition - origin).normalized()

func _physics_process(delta):
	var collision = move_and_collide(direction * delta * maxSpeed)
	if collision:
		queue_free()
	
func _on_Projectile_body_entered(body):
#	if body.is_in_group("player"):
#		# deal damage and disappear
	queue_free()



