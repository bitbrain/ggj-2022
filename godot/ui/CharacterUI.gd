extends Control

export(NodePath) var character_path

onready var character = get_node(character_path) as Character
onready var energySprite = $Energy
onready var health = $Health
onready var animation_player = $AnimationPlayer

func _ready():
	character.connect("health_changed", self, "_on_health_changed")
	character.connect("energy_changed", self, "_on_energy_changed")
	energySprite.frame = character.energy
	if character.PLAYER_TYPE == Character.PlayerType.FIRE:
		animation_player.play("health-fire")
	if character.PLAYER_TYPE == Character.PlayerType.FROST:
		animation_player.play("health-ice")

func _on_health_changed(health):
	pass

func _on_energy_changed(energy):
	energySprite.frame = energy
