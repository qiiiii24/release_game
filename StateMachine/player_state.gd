extends Node
class_name PlayerState

# 状态： 待机， 行走， 跳跃（飞行）， 拖动
enum State{
	BASE, # 包含idle和walk
	DRAG,
	FLY,
	READY
}

#
signal transition_requested(form : PlayerState, to : State)

@export var state : State

# 
func enter() -> void:
	pass

func post_enter() -> void:
	pass

#
func exit() -> void:
	pass

#
func on_input(_event : InputEvent) -> void:
	pass

#
func on_gui_input(_event : InputEvent) -> void:
	pass

#
func on_mouse_entered() -> void:
	pass

#
func on_mouse_exited() -> void:
	pass
