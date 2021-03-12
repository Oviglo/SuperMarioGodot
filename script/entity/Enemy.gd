extends "res://script/entity/MovingEntity.gd"

var is_killed = false
var bouncing_value = -150

func hurt():
	
	pass

func _on_Area2D_area_entered(area):
	if area.name == "FeetArea":
		if area.get_parent().is_jumping or area.get_parent().is_falling:
			if !is_killed:
				area.get_parent().velocity.y = bouncing_value
				hurt()
