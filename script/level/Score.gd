extends Node2D

func set_score(score):
	$Unit1.region_rect = Rect2((score%10)*8, 0, 8, 8)
	$Unit2.region_rect = Rect2(((score/10)%10)*8, 0, 8, 8)
	$Unit3.region_rect = Rect2(((score/100)%10)*8, 0, 8, 8)
	$Unit4.region_rect = Rect2(((score/1000)%10)*8, 0, 8, 8)
	$Unit5.region_rect = Rect2(((score/10000)%10)*8, 0, 8, 8)
	$Unit6.region_rect = Rect2(((score/100000)%10)*8, 0, 8, 8)
	$Unit7.region_rect = Rect2(((score/1000000)%10)*8, 0, 8, 8)
