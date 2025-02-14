extends Node2D
class_name Spring

## 划线所需要的能量（可以成长）

## 总能量（可以成长）

@onready var line_2d: Line2D = $Line2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var player: Player

var can_draw: bool = false
var start_position: Vector2
var end_position: Vector2 

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				can_draw = true
				start_position = get_local_mouse_position()
				draw_spring(start_position)
			elif event.is_released():
				end_position = get_local_mouse_position()
				can_draw = false
				draw_spring(end_position)

func draw_spring(pos: Vector2) -> void:
	if player.can_draw_line:
		if can_draw:
			collision_shape_2d.shape.a = pos
			line_2d.set_point_position(0, pos)
			line_2d.visible = false
			collision_shape_2d.disabled = true
		else:
			collision_shape_2d.shape.b = pos
			line_2d.set_point_position(1, pos)
			line_2d.visible = true
			collision_shape_2d.disabled = false
