extends PlayerState



func enter() -> void:
	player.phantom_camera_2d.follow_mode = 0
	player.die = true
	player.can_draw_line = false
	print("enter die state")
	if player.current_height > 10000:
		Event.win_or_lose.emit(true)
	else:
		Event.win_or_lose.emit(false)
