extends Control

export(NodePath) var character_path

onready var character = get_node(character_path) as Character
onready var energySprite = $Energy
onready var health = $Health
onready var animation_player = $AnimationPlayer
onready var health_overlay = $HealthOverlay
onready var tween = $Tween

var current_scale = 0

func _ready():
	character.connect("health_changed", self, "_on_health_changed")
	character.connect("energy_changed", self, "_on_energy_changed")
	energySprite.frame = character.energy
	if character.PLAYER_TYPE == Character.PlayerType.FIRE:
		animation_player.play("health-fire")
	if character.PLAYER_TYPE == Character.PlayerType.FROST:
		animation_player.play("health-ice")
		
func _process(delta):
	health_overlay.scale.x = current_scale

func _on_health_changed(health):
	var inverseHealth = 100 - health
	var target_scale = 1
	if inverseHealth != 0:
		target_scale = inverseHealth / 100
	else:
		target_scale = 0
	tween.stop_all()
	tween.interpolate_property(self, "current_scale", current_scale, target_scale, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()

func _on_energy_changed(energy):
	energySprite.frame = energy
