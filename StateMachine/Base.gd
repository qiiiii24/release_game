extends PlayerState

## 玩家在地上的idle与walk动画，可以转换成drag状态

@onready var player: Player = $"../.."


func on_gui_input(event : InputEvent) -> void: #左键点击，切换state
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				transition_requested.emit(self, PlayerState.State.DRAG)
				player.drag = true
