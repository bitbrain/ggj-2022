class_name Object_Tree
extends Node2D

var closebycharacter = []
onready var treeSprite = $Sprite
onready var frost_effect = $FrostParticleEffect
onready var fire_effect = $FlameParticleEffect

func _on_Area2D_body_entered(body):
	var character = body as Character
	closebycharacter.append(character)
	if character.PLAYER_TYPE == Character.PlayerType.FIRE and character.charging:
		treeSprite.frame = 1
		fire_effect.visible = true
		frost_effect.visible = false
	if character.PLAYER_TYPE == Character.PlayerType.FROST and character.charging:
		treeSprite.frame = 2
		fire_effect.visible = false
		frost_effect.visible = true
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

func _on_EnergyTimer_timeout():
	for character in closebycharacter:
		if character.PLAYER_TYPE == Character.PlayerType.FIRE and treeSprite.frame == 1:
			character.set_energy()
		if character.PLAYER_TYPE == Character.PlayerType.FROST and treeSprite.frame == 2:
			character.set_energy()
