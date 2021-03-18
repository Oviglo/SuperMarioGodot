extends Node2D

func set_coins(coins):
	$Unit1.region_rect = Rect2((coins%10)*8, 0, 8, 8)
	$Unit2.region_rect = Rect2(((coins/10)%10)*8, 0, 8, 8)
