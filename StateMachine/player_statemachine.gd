extends Node
class_name PlayerStateMachine

#最初状态
@export var initial_state : PlayerState

var current_state : PlayerState
var states := {}


func init() -> void:
	for child in get_children():#将子节点中是CardState的加入states中并将每个子节点链接信号
		if child is PlayerState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

#
func on_input(_event : InputEvent) -> void:
	if current_state:
		current_state.on_input(_event)

#
func on_gui_input(_event : InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(_event)

#
func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

#
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()

func _on_transition_requested(from: PlayerState,to: PlayerState.State) -> void:
	if from != current_state: 
		return
	
	var new_state: PlayerState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	new_state.post_enter()
