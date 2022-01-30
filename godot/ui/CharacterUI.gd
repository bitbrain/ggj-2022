extends Control

export(NodePath) var character_path

onready var character = get_node(character_path) as Character
onready var health_fire = $HealthFire
onready var health_frost = $HealthFrost
onready var energySprite = $Energy

func _ready():
	character.connect("health_changed", self, "_on_health_changed")
	character.connect("energy_changed", self, "_on_energy_changed")
	energySprite.frame = character.energy
	if character.PLAYER_TYPE == Character.PlayerType.FIRE:
		health_fire.visible = true
		health_frost.visible = false
	if character.PLAYER_TYPE == Character.PlayerType.FROST:
		health_fire.visible = false
		health_frost.visible = true

func _on_health_changed(health):
	pass
func _on_energy_changed(energy):
	energySprite.frame = energy
