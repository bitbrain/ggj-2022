extends Node2D

onready var FirePlayer = $WorldObjects/Fire
onready var FrostPlayer = $WorldObjects/Frost
onready var overlay = $UI/Overlay

func _ready():
	FirePlayer.connect("character_dead",self, "_playeronedeath")
	FrostPlayer.connect("character_dead",self, "_playertwodeath")
	overlay.fade_in()

func _playeronedeath():
	print("Player one died")
	
func _playertwodeath():
	print("Player two died")
