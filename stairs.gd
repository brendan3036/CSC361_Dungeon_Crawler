extends Area2D


var buttonPressFlag = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		

func _process(delta):
	if buttonPressFlag == 1 and Input.is_action_pressed('use'):
		for obj in get_tree().get_root().get_children():
			if obj.is_in_group("gamescene"):
				obj.clear()
			if obj.is_in_group("music"):
				pass
			

func _on_Area2D_entered(area):
	if area.is_in_group("player"):
		buttonPressFlag = 1
		


func _on_Area2D_exited(area):
	if area.is_in_group("player"):
		buttonPressFlag = 0
