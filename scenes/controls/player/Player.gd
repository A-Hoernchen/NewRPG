extends KinematicBody2D

class_name Player

const MOVE_SPEED = 10.0

export var Speed = 0

enum MoveDirection { UP, DOWN, LEFT, RIGHT, NONE }

puppet var slave_position = Vector2()
puppet var slave_movement = MoveDirection.NONE

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = MoveDirection.NONE
	if is_network_master():
		if Input.is_action_pressed('left'):
			direction = MoveDirection.LEFT
		elif Input.is_action_pressed('right'):
			direction = MoveDirection.RIGHT
		elif Input.is_action_pressed('up'):
			direction = MoveDirection.UP
		elif Input.is_action_pressed('down'):
			direction = MoveDirection.DOWN
		
		rset_unreliable('slave_position', position)
		rset('slave_movement', direction)
		_move(direction)
	else:
		_move(slave_movement)
		position = slave_position
	
	if get_tree().is_network_server():
		Network.update_position(int(name), position)

func _move(direction):
	match direction:
		MoveDirection.NONE:
			return
		MoveDirection.UP:
			move_and_collide(Vector2(0, -MOVE_SPEED))
		MoveDirection.DOWN:
			move_and_collide(Vector2(0, MOVE_SPEED))
		MoveDirection.LEFT:
			move_and_collide(Vector2(-MOVE_SPEED, 0))
		MoveDirection.RIGHT:
			move_and_collide(Vector2(MOVE_SPEED, 0))
			
func init(nickname, start_position, is_slave):
	$PlayerGui/NickName.text = nickname
	global_position = start_position
	if is_slave:
		$Sprite.texture = load('res://assets/player/player-alt.png')
