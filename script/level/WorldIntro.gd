extends "res://script/level/Game.gd"

func _ready():
	$Fade/AnimationPlayer.play("FadeIn")
	await get_tree().create_timer(3.0).timeout
	$Fade/AnimationPlayer.play("FadeOut")
	await get_tree().create_timer(1.0).timeout
	jump_to_level()


func jump_to_level():
	var levelName = "world_" + str(world) + "_" + str(level)
	get_tree().change_scene_to_file("res://scene/level/" + levelName + ".tscn")
