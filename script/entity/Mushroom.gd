extends "res://script/entity/MovingEntity.gd"

signal collect

var is_appear = false

func _ready():
	is_active = !is_appear
	$Sprite.visible = false
	
func appear():
	$AnimationPlayer.play("Appear")
	is_appear = true
	is_active = false
	$Sprite.z_index = -1

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("collect")
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Appear":
		is_active = true
		is_appear = false
