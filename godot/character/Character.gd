class_name Character
extends KinematicBody2D

signal character_dead
signal health_changed(health)
signal energy_changed(energy)

enum PlayerType {
	FIRE
	FROST
}
export(float) var ACCELERATION = 1150
export(float) var CHARGING_ACCELERATION = ACCELERATION * 2
export(float) var FRICTION = 470
export(float) var MAX_SPEED = 275
export(float) var CHARGING_SPEED = MAX_SPEED * 2
export(PlayerType) var PLAYER_TYPE

export(String) var east_action
export(String) var west_action
export(String) var south_action
export(String) var north_action
export(String) var charge_action

onready var FireSprite = $FireSprite
onready var FrostSprite = $FrostSprite
onready var ChargerTimer = $Timer
onready var dash_sound = $DashSound
onready var hurt_sound = $HurtSound
onready var animation_player = $AnimationPlayer
onready var movement_sound =  $AmbientSound
onready var FlameAmbient = preload("res://character/flame-ambience.ogg")
onready var FrostAmbient = preload("res://character/frost-ambience.ogg")
onready var FrostHurtEffect = $FrostHurtEffect
onready var FireHurtEffect = $FireHurtEffect

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var charging = false
var health = 100.0 setget _set_health
var energy = 5 setget _set_energy
var death = false

func _ready():
	FireSprite.material = FireSprite.material.duplicate()
	FrostSprite.material = FrostSprite.material.duplicate()
	if PLAYER_TYPE == PlayerType.FIRE:
		movement_sound.stream = FlameAmbient
		FireSprite.visible = true
		FrostSprite.visible = false
	if PLAYER_TYPE == PlayerType.FROST:
		movement_sound.stream = FrostAmbient
		FireSprite.visible = false
		FrostSprite.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed(charge_action) and not charging and energy > 0:
		charging = true
		self.energy = self.energy - 1
		print("Charge used, energy is now "+str(energy))
		ChargerTimer.start()
		dash_sound.pitch_scale = rand_range(0.9, 1.1)
		dash_sound.play()
		
	if not charging:
		input_vector.x = Input.get_action_strength(east_action) - Input.get_action_strength(west_action)
		input_vector.y = Input.get_action_strength(south_action) - Input.get_action_strength(north_action)
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(input_vector * CHARGING_SPEED, CHARGING_ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	
	var velocity_length = velocity.length()
	movement_sound.pitch_scale = max(1.0, velocity_length / 100)

func _on_ChargeTimer_timeout():
	charging = false

func _on_EnergyTimer_timeout():
	set_energy()

func _set_health(h):
	if death:
		return
	health = max(h, 0)
	emit_signal("health_changed", health)
	if health == 0:
		death = true
		emit_signal("character_dead")

func _set_energy(e):
	energy = e
	emit_signal("energy_changed", energy)

func set_energy():
	if self.energy < 5:
		self.energy = self.energy + 1
		print("Recharging energy... "+str(energy))

func ressurect():
	death = false
	health = 100

func take_damage(damage):
	self.health = self.health - damage
	animation_player.play("damage")
	hurt_sound.play()
	if PLAYER_TYPE == PlayerType.FIRE:
		FrostHurtEffect.emitting = true
	else:
		FireHurtEffect.emitting = true

func _on_Area2D_body_entered(body):
	var other_character = body as Character
	if charging:
		other_character.take_damage(20)

func _on_AnimationPlayer_animation_finished(anim_name):
	FrostHurtEffect.emitting = false
	FireHurtEffect.emitting = false
