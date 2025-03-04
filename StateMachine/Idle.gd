extends PlayerState

## 玩家在地上的idle与walk动画，可以转换成drag状态

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var random_time : float
 

func enter() -> void:
	randomize()
	play_random_animation()

func play_random_animation() -> void:
	random_time = randi_range(3,5)
	
	if randi_range(0,1) == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Walk")
	
	var timer := get_tree().create_timer(random_time)
	await timer.timeout
	play_random_animation()


func on_gui_input(event : InputEvent) -> void: #左键点击，切换state
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				animation_player.play("Idle")
				transition_requested.emit(self, PlayerState.State.DRAG)
				player.drag = true
