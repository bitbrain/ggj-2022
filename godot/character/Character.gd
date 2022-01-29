class_name Character
extends KinematicBody2D

enum PlayerType {
	FIRE
	FROST
}

export(float) var ACCELERATION = 340
export(float) var FRICTION = 670
export(float) var MAX_SPEED = 175
export(PlayerType) var PLAYER_TYPE

export(String) var east_action
export(String) var west_action
export(String) var south_action
export(String) var north_action

onready var FireSprite = $FireSprite
onready var FrostSprite = $FrostSprite

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

func _ready():
	if PLAYER_TYPE == PlayerType.FIRE:
		FireSprite.visible = true
		FrostSprite.visible = false
	if PLAYER_TYPE == PlayerType.FROST:
		FireSprite.visible = false
		FrostSprite.visible = true

func _physics_process(delta):
	input_vector.x = Input.get_action_strength(east_action) - Input.get_action_strength(west_action)
	input_vector.y = Input.get_action_strength(south_action) - Input.get_action_strength(north_action)
	input_vector = input_vector.normalized()
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
