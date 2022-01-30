extends Node2D

onready var FirePlayer = $WorldObjects/Fire
onready var FrostPlayer = $WorldObjects/Frost
onready var overlay = $UI/Overlay

func _ready():
	FirePlayer.connect("character_dead",self, "_playeronedeath")
	FrostPlayer.connect("character_dead",self, "_playertwodeath")
	overlay.fade_in()

func _playeronedeath():
	overlay.fade_out()
	Global.winner = Character.PlayerType.FROST
	
func _playertwodeath():
	overlay.fade_out()
	Global.winner = Character.PlayerType.FIRE


func _on_Overlay_on_complete_fade_out():
	Global.goto_scene("res://GameOverScreen.tscn")
