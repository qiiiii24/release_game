extends PlayerState

# 要实现切换fly state，进入mark2d的动画， 

func enter() -> void:
	Event.fly_ready.emit(true)
	player.start.connect(change_to_fly)

func change_to_fly() -> void:
	transition_requested.emit(self, PlayerState.State.FLY)
