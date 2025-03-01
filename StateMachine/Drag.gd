extends PlayerState



func on_gui_input(event : InputEvent) -> void: #左键点击，切换state
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released():
				transition_requested.emit(self, PlayerState.State.BASE)
				player.drag = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent is SlingShot:
		transition_requested.emit(self, PlayerState.State.READY)
	
	if area_parent is Spring:
		player.camera_can_move = true
		player.can_draw_line = false
		var lanching_speed = Vector2(0, -1000)
		
		player.velocity += lanching_speed
