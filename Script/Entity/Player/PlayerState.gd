class_name PlayerState
extends State

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	
	assert(player != null)

func get_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func is_walking() -> bool:
	return Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
