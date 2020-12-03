extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 60
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

# WE DO NOT TAKE CREDIT FOR ANY OF THIS CODE
# CODE IS OPEN SOURCE AND CAN BE FOUND @ https://github.com/benbishopnz/godot-credits
# Not taking credit for a credits scene is kinda ironic...

var credits = [
	[
		"A game by Nate Bream and Brendan Karper"
	],[
		"Programming",
		"Nate Bream",
		"Brendan Karper"
	],[
		"Art",
		"All environment and character sprites are used under",
		"Creative Commons Attribution 3.0 license or",
		"CC0 Public Domain:",
		"Slash effect by @Cethyel on Twitter",
		"Health bar assets by @arkalain on opengameart.org",
		"Rotating Arrow Projectile by @Randalinski on opengameart.org",
		"High res fire ball by @Game Developer Studio on opengameart.org",
		"Everything else: Credit goes to @Calciumtrice on opengameart.org",
		"They can also be found on twitter @Calciumtrice"
	],[
		"Music",
		"Used under CC0 Public Domain:",
		"42 'Monster RPG 2' Music Tracks by Nooskewl Games (submitted by Sanglorian)"
	],[
		"Sound Effects",
		"Used under CC0 Public Domain:",
		"Plingy Coin by @Fupi on opengameart.org",
		"11 male human pain/death sounds by Michel Baradari",
		"RPG Sound Pack by @artisticdude on opengameart.org"
		
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Spritesheets edited with Piskel",
		"piskelapp.com"
	],[
		"Playtested by:",
		"Yong Hang Lin"
	],
	[
		"Special thanks",
		"Our parents",
		"Our friends",
		"Our dogs"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
