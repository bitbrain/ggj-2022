class_name Object_Tree
extends Node2D

onready var treeSprite = $Sprite

func _on_Area2D_body_entered(body):
	var character = body as Character
	if character.PLAYER_TYPE == Character.PlayerType.FIRE:
		treeSprite.frame = 1
	if character.PLAYER_TYPE == Character.PlayerType.FROST:
		treeSprite.frame = 2	
	#print ("Collision with tree detected")
	
	
