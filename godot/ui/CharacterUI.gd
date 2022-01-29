extends Control

export(NodePath) var character_path

onready var character = get_node(character_path)
onready var health_fire = $HealthFire
onready var health_frost = $HealthFrost

func _ready():
	if character.PLAYER_TYPE == Character.PlayerType.FIRE:
		health_fire.visible = true
		health_frost.visible = false
	if character.PLAYER_TYPE == Character.PlayerType.FROST:
		health_fire.visible = false
		health_frost.visible = true
