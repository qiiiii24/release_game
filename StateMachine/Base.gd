extends PlayerState

## 玩家在地上的idle与walk动画，可以转换成drag状态

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	play_idle()

func play_idle() -> void:
	animation_player.play("Idle")
	var random_amount := randi_range(3,10)
	await get_tree().create_timer(random_amount).timeout
	play_run()

func play_run() -> void:
	animation_player.play("Walk")
	var random_amount := randi_range(3,10)
	await get_tree().create_timer(random_amount).timeout
	play_idle()

func on_gui_input(event : InputEvent) -> void: #左键点击，切换state
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				transition_requested.emit(self, PlayerState.State.DRAG)
				animation_player.play("Idle")
				player.drag = true
