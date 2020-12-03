extends Control

func _ready():
	if not MenuMusic.is_playing() or GameMusic.is_playing():
		GameMusic.stop()
		BossMusic.stop()
		MenuMusic.play()
	pass

