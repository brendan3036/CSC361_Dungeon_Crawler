extends Control


onready var health_bar = $HealthBar
onready var warrior = get_tree().get_root().get_node("Node2D/Node2D/warrior_bck")


func _ready():
	health_bar.value = warrior.maxHealth
	pass 


func _on_health_updated(health, amount):
	health_bar.value = warrior.currentHealth
	
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
