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

func _ready() -> void:
	Event.win_or_lose.connect(close_collision)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed(): #按下时设置点一
				can_draw = true
				start_position = get_local_mouse_position()
				draw_spring(start_position)
			elif event.is_released(): #释放时设置点二
				end_position = get_local_mouse_position()
				can_draw = false
				draw_spring(end_position)

# 目前存在一个bug，当划出一个spring后在画下一个，在按下未释放时因为存在点二，按下又得到了新的点一，所以会直接
# 划出一条新的线 (已解决)
# 当只有新划出点一，在划点二才能实现

func draw_spring(pos: Vector2) -> void:
	if player.can_draw_line:
		if can_draw:
			# 设置点一
			collision_shape_2d.shape.a = pos
			line_2d.set_point_position(0, pos)
			line_2d.visible = false
			collision_shape_2d.disabled = true
		elif not can_draw and collision_shape_2d.disabled == true:
			var can_draw = consume_energy()
			if can_draw:
				collision_shape_2d.shape.b = pos
				line_2d.set_point_position(1, pos)
				line_2d.visible = true
				collision_shape_2d.disabled = false
				
				Event.change_energy_bar.emit()
			

func close_collision(my_bool) -> void:
	collision_shape_2d.disabled = true

func consume_energy() -> bool:
	InventorySystem.energy-= InventorySystem.spring_consume_energy
	#print(InventorySystem.energy)
	return InventorySystem.energy >= 0
