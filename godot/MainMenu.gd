extends Control

onready var overlay = $Overlay

var exiting = false

func _ready():
	overlay.fade_in()

func _on_PlayGameButton_pressed():
	if !exiting:
		overlay.fade_out()
		exiting = true


func _on_Overlay_on_complete_fade_out():
	Global.goto_scene("res://Game.tscn")
