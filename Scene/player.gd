extends CharacterBody2D
class_name Player



const BOUNCE_SPEED := 0.8

@onready var area_2d: Area2D = $Area2D
@onready var area_shape: CollisionShape2D = $Area2D/AreaShape
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var phantom_camera_2d: PhantomCamera2D = $"../PhantomCamera2D"


## 初速度
@export var initial_velocity := -400
@export var sling_shot: Node2D
@export var move_camera: Camera2D

# 初始高度
var initial_y_position: int
# 目前高度
var current_height: int
# 上一个高度
var last_height : int  

var drag : bool = false
var camera_can_move : bool = false
# true为可以划线
var can_draw_line : bool = false
# 是否为die状态
var die : bool = false
var launching : bool = false
#var gravity = get_gravity()
var gravity = Vector2(0,480)
# 玩家是否进入区域
var player_enter : bool

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	#area_2d.body_entered.connect(_on_area_2d_body_entered)
	sling_shot.drag_mode.connect(launch)
	Event.ability_change.connect(change_state)
	Event.fly_ready.connect(_on_ready_fly_ready)
	
	initial_y_position = position.y  # 记录初始高度
	last_height = initial_y_position # 记录第一个last_height
	
	player_state_machine.init()

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
	line_draw()
	

	
## 相机移动（发射后跟着移动）y方向速度等于0时停止移动，
func camera_move() -> void:
	if camera_can_move: # 这个要改正为玩家下落或者上升
		#move_camera.position.y = position.y
		current_height = initial_y_position - position.y  # 计算上升高度
		
		var cumulative_height : int = current_height - last_height

		if cumulative_height > 480:
			last_height = current_height
			print("当前高度：" +  str(current_height))
			Event.update_collection.emit()
	
	
# 划线检测
func line_draw() -> void:
	if die : return
	# 下落后然后是发射后才可以划线
	if velocity.y > 0:
		camera_can_move = false
		if launching:  #不知道一下有没有用
			
			can_draw_line = true
			gravity = get_gravity() * 0.4

## 发射
func launch(speed: Vector2) -> void:
	camera_can_move = true
	
	velocity += speed 
	launching = true
	gravity = get_gravity()
	Event.launch_start.emit()
	

## 点击玩家就会跟着鼠标走
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	player_state_machine.on_gui_input(event)
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.is_pressed():
				#drag = true

## 给予玩家加速度（可以成长）
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body is Spring:
		#camera_can_move = true
		#can_draw_line = false
		#var lanching_speed = Vector2(0, -1000)
		#print("coll")
		#
		#velocity += lanching_speed
		
		#launch(lanching_speed)


func _on_area_2d_mouse_entered() -> void:
	player_state_machine.on_mouse_entered()


func _on_area_2d_mouse_exited() -> void:
	player_state_machine.on_mouse_exited()


func _on_ready_fly_ready(my_bool: bool) -> void:
	player_enter = my_bool
