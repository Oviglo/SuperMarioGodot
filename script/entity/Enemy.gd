extends "res://script/entity/MovingEntity.gd"

var is_killed = false
var bouncing_value = -150

signal hurt

func crush():
	
	pass

func _on_Area2D_area_entered(area):
	if area.name == "FeetArea":
		if area.get_parent().is_jumping or area.get_parent().is_falling:
			if !is_killed:
				area.get_parent().velocity.y = bouncing_value
				crush()
				
	if area.name == "HurtArea":
		if !is_killed:
			emit_signal("hurt", area.get_parent())
