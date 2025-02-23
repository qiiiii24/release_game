extends CharacterBody2D
class_name Player

signal start

const BOUNCE_SPEED := 0.8

@onready var area_2d: Area2D = $Area2D
@onready var area_shape: CollisionShape2D = $Area2D/AreaShape


## 初速度
@export var initial_velocity := -400
@export var sling_shot: Node2D
@export var move_camera: Camera2D

# 初始高度
var initial_y_position: float
# 目前高度
var current_height: float
var drag : bool = false
var camera_can_move : bool = false
var can_draw_line : bool = false
var launching : bool = false
var gravity = get_gravity()

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	sling_shot.drag_mode.connect(launch)
	InventorySystem.State_change.connect(change_state)
	
	initial_y_position = position.y  # 记录初始高度
	

	


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released(): ## 释放后不跟着鼠标走
				drag = false


func change_state(_type) -> void:
	area_shape.shape.radius = InventorySystem.pick_range


func _physics_process(delta: float) -> void:
	var collisionInfo = move_and_collide(velocity * delta)
	## 没有使用y坐标反弹
	if collisionInfo:
		velocity.x = velocity.bounce(collisionInfo.get_normal()).x 
		
		velocity *= BOUNCE_SPEED
	
	if not is_on_floor():
		velocity += gravity * delta 
	
	if drag:
		position = to_global(get_local_mouse_position())
	
	camera_move()
	
	
	
## 相机移动（发射后跟着移动）y方向速度等于0时停止移动，
func camera_move() -> void:
	if camera_can_move:
		move_camera.position.y = position.y
		current_height = initial_y_position - position.y  # 计算上升高度
	
	if velocity.y > 0:
		camera_can_move = false
		if launching:
			can_draw_line = true
			gravity = get_gravity() * 0.4
			


## 发射
func launch(speed: Vector2) -> void:
	camera_can_move = true
	velocity += speed
	launching = true
	gravity = get_gravity()
	start.emit()
	

## 点击玩家就会跟着鼠标走
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				drag = true

## 给予玩家加速度（可以成长）
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Spring:
		camera_can_move = true
		can_draw_line = false
		var lanching_speed = Vector2(0, -1000)
		velocity += lanching_speed
		
		#launch(lanching_speed)
