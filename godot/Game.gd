extends Node2D

onready var FirePlayer = $WorldObjects/Fire
onready var FrostPlayer = $WorldObjects/Frost

func _ready():
	FirePlayer.connect("character_dead",self, "_playeronedeath")
	FrostPlayer.connect("character_dead",self, "_playertwodeath")

func _playeronedeath():
	print("Player one died")
	
func _playertwodeath():
	print("Player two died")
