extends CanvasLayer

func _on_Player_coins_changed(coins):
	$Coins.set_coins(coins)


func _on_Player_score_changed(score):
	$Score.set_score(score)
