extends Control

onready var overlay = $Overlay
onready var player_name = $CenterContainer/VBoxContainer/PlayerName
onready var sprite = $CenterContainer/VBoxContainer/CenterContainer/Control/Sprite
onready var fire_spriteframes = preload("res://character/fire-spriteframes.tres")
onready var frost_spriteframes = preload("res://character/frost-spriteframes.tres")

var exiting = false

func _ready():
	if Global.winner == Character.PlayerType.FIRE:
		sprite.frames = fire_spriteframes
		player_name.text = "Fire Spirit"
		player_name.modulate = Color("f48b6d")
	if Global.winner == Character.PlayerType.FROST:
		sprite.frames = frost_spriteframes
		player_name.text = "Frost Spirit"
		player_name.modulate = Color("8db7ff")

func _on_Overlay_on_complete_fade_out():
	Global.goto_scene("res://Game.tscn")


func _on_GameButton_pressed():
	if !exiting:
		overlay.fade_out()
		exiting = true

func _on_GameButton2_pressed():
	get_tree().quit()
