extends Node2D
class_name SlingShot

signal drag_mode

@onready var sling_shot_end: Sprite2D = $SlingShotEnd
@onready var line_2d_2: Line2D = $Line2D2
@onready var marker_2d: Marker2D = $Marker2D
@onready var line_2d: Line2D = $Line2D
@onready var area_2d: Area2D = $Area2D
@onready var point_1: Node2D = $SlingShotEnd/point1
@onready var point_2: Node2D = $SlingShotEnd/point2

## 拉伸长度
@export var max_strech_distance : float = 120

@export var player: Player

#var player : PackedScene = preload("res://Scene/player.tscn")
## 玩家已经进入发射区域就为true
var player_enter: bool = false 

var start_position : Vector2
var drag_position : Vector2 = Vector2.ZERO
var start_pos_l1 : Vector2
var start_pos_l2 : Vector2
var start_pos : Vector2
var can_drag : bool = false :
	set(value):
		can_drag = value
		line_2d.set_point_position(1,to_local(point_1.global_position))
		line_2d_2.set_point_position(1,to_local(point_2.global_position))
		sling_shot_end.position = start_pos
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released() and player.player_enter:
				can_drag = false
				var launch_speed = _get_launch_velicity()
				drag_mode.emit(launch_speed)
				drag_position = start_position
				player.player_enter = false
				Event.start_rotate.emit(true)
				

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	#area_2d.body_entered.connect(_on_area_2d_body_entered, CONNECT_ONE_SHOT)
	start_position = marker_2d.position
	start_pos_l1 = line_2d.get_point_position(1)
	start_pos_l2 = line_2d_2.get_point_position(1)
	start_pos = sling_shot_end.position
	Event.fly_ready.connect(update_player_position)
	

func _process(_delta: float) -> void:
	if player.player_enter:
		var target_position := to_global(marker_2d.position) + Vector2(0, -20)
		#tween.tween_property(player, "position", target_position, 0.75)
		#await tween.finished
		#player.position = target_position
	#if can_drag:
		_update_sling_band()
		player.global_position = to_global(drag_position) + Vector2(0, -15)

func update_player_position(my_bool) -> void:
	if player.player_enter:
		var target_position := to_global(marker_2d.position) + Vector2(0, -20)
		
		player.position = target_position
	

## 更新橡皮筋效果
func _update_sling_band() -> void:

	var local_mouse_position = get_local_mouse_position()
	var strech_vector = local_mouse_position - start_position
	
	strech_vector = _clamp_vector_to_length(strech_vector, max_strech_distance)
	
	drag_position = strech_vector + start_position
	sling_shot_end.position = drag_position
	# 给 line2d赋值
	
	line_2d.set_point_position(1,to_local(point_1.global_position))
	line_2d_2.set_point_position(1,to_local(point_2.global_position))
	

## 获取发射速度
func _get_launch_velicity() -> Vector2:
	var strech_vector = start_position - drag_position
	return strech_vector * InventorySystem.initial_velocity_factor

## 限制拉伸长度
func _clamp_vector_to_length(v: Vector2, max_length: float) -> Vector2:
	return v.normalized() * max_length if v.length() > max_length else v

## 鼠标进入area2d
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and player_enter:
				can_drag = true
				player_enter = false

## 将物体拖入范围
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body is Player:
		#player_enter = true
