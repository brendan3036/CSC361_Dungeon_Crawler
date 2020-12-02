extends Control

#onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if not MenuMusic.is_playing() or GameMusic.is_playing():
		GameMusic.stop()
		BossMusic.stop()
		MenuMusic.play()
	pass

