class_name Object_Tree
extends Node2D
var closebycharacter = []
onready var treeSprite = $Sprite

func _on_Area2D_body_entered(body):
	var character = body as Character
	closebycharacter.append(character)
	if character.PLAYER_TYPE == Character.PlayerType.FIRE and character.charging:
		treeSprite.frame = 1
	if character.PLAYER_TYPE == Character.PlayerType.FROST and character.charging:
		treeSprite.frame = 2	
	#print ("Collision with tree detected")
	
func _on_BurstTimer_timeout():
	for character in closebycharacter:
		if character.PLAYER_TYPE == Character.PlayerType.FIRE and treeSprite.frame == 2:
			character.take_damage(5)
			#print("Player one took 5 damage")	
		if character.PLAYER_TYPE == Character.PlayerType.FROST and treeSprite.frame == 1:
			character.take_damage(5)
			#("Player two took 5 damage")
func _on_Area2D_body_exited(body):
	var character = body as Character
	closebycharacter.erase(character)
