extends Node2D

signal drag_mode

@onready var sling_shot_end: Sprite2D = $SlingShotEnd
@onready var line_2d_2: Line2D = $Line2D2
@onready var marker_2d: Marker2D = $Marker2D
@onready var line_2d: Line2D = $Line2D
@onready var area_2d: Area2D = $Area2D

@export var max_strech_distance : float = 150
@export var initial_velocity_factor : float = 30
@export var player: Player

#var player : PackedScene = preload("res://Scene/player.tscn")
var start_position : Vector2
var drag_position : Vector2 = Vector2.ZERO
var start_pos_l1 : Vector2
var start_pos_l2 : Vector2
var start_pos : Vector2
var can_drag : bool = false :
	set(value):
		can_drag = value
		line_2d.set_point_position(1,start_pos_l1)
		line_2d_2.set_point_position(1,start_pos_l2)
		sling_shot_end.position = start_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released() and can_drag:
				can_drag = false
				var launch_speed = _get_launch_velicity()
				drag_mode.emit(launch_speed)
				drag_position = start_position
				

func _ready() -> void:
	#area_2d.input_event.connect(_on_area_2d_input_event)
	area_2d.body_entered.connect(_on_area_2d_body_entered, CONNECT_ONE_SHOT)
	start_position = marker_2d.position
	start_pos_l1 = line_2d.get_point_position(1)
	start_pos_l2 = line_2d_2.get_point_position(1)
	start_pos = sling_shot_end.position

func _process(delta: float) -> void:
	if can_drag:
		_update_sling_band()
		player.global_position = to_global(drag_position)

## 更新橡皮筋效果
func _update_sling_band() -> void:
	var local_mouse_position = get_local_mouse_position()
	var strech_vector = local_mouse_position - start_position
	# 限制拉伸长度
	#if strech_vector.y > 150:
		#strech_vector.y = 150
	strech_vector = _clamp_vector_to_length(strech_vector, max_strech_distance)
	
	drag_position = strech_vector + start_position
	# 给 line2d赋值
	line_2d.set_point_position(1,drag_position)
	line_2d_2.set_point_position(1,drag_position)
	sling_shot_end.position = drag_position

## 获取发射速度
func _get_launch_velicity() -> Vector2:
	var strech_vector = start_position - drag_position
	return strech_vector * initial_velocity_factor

## 限制拉伸长度
func _clamp_vector_to_length(v: Vector2, max_length: float) -> Vector2:
	return v.normalized() * max_length if v.length() > max_length else v

## 鼠标进入area2d
#func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#if event is InputEventMouseButton :
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.is_pressed():
				#can_drag = true

## 将物体拖入范围
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		can_drag = true
		
