class_name Character
extends KinematicBody2D

signal character_dead

enum PlayerType {
	FIRE
	FROST
}
export(float) var ACCELERATION = 340
export(float) var CHARGING_ACCELERATION = ACCELERATION * 3
export(float) var FRICTION = 670
export(float) var MAX_SPEED = 175
export(float) var CHARGING_SPEED = MAX_SPEED * 3
export(PlayerType) var PLAYER_TYPE

export(String) var east_action
export(String) var west_action
export(String) var south_action
export(String) var north_action
export(String) var charge_action

onready var FireSprite = $FireSprite
onready var FrostSprite = $FrostSprite
onready var ChargerTimer = $Timer

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var charging = false
var health = 100.0 setget _set_health
var death = false

func _ready():
	if PLAYER_TYPE == PlayerType.FIRE:
		FireSprite.visible = true
		FrostSprite.visible = false
	if PLAYER_TYPE == PlayerType.FROST:
		FireSprite.visible = false
		FrostSprite.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed(charge_action) and not charging:
		charging = true
		ChargerTimer.start()
		
	if not charging:
		input_vector.x = Input.get_action_strength(east_action) - Input.get_action_strength(west_action)
		input_vector.y = Input.get_action_strength(south_action) - Input.get_action_strength(north_action)
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(input_vector * CHARGING_SPEED, CHARGING_ACCELERATION * delta)
	velocity = move_and_slide(velocity)

func _on_Timer_timeout():
	charging = false

func _set_health(h):
	if death:
		return
	health = max(h, 0)
	if health == 0:
		death = true
		emit_signal("character_dead")

func ressurect():
	death = false
	health = 100

func take_damage(damage):
	health -= damage
	#print("Ouch..."+str(health))

func _on_Area2D_body_entered(body):
	var other_character = body as Character
	if charging:
		other_character.take_damage(20)
		
