extends KinematicBody2D

export(float) var ACCELERATION = 340
export(float) var FRICTION = 670
export(float) var MAX_SPEED = 75

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("player1_move_east") - Input.get_action_strength("player1_move_west")
	input_vector.y = Input.get_action_strength("player1_move_south") - Input.get_action_strength("player1_move_north")
	input_vector = input_vector.normalized()
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
