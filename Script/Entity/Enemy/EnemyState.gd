class_name EnemyState
extends State

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
