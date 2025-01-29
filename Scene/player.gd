extends CharacterBody2D
class_name Player

const BOUNCE_SPEED := 0.8

@onready var area_2d: Area2D = $Area2D
@onready var move_camera: Camera2D = %MoveCamera


## 初速度
@export var initial_velocity := -400
@export var sling_shot: Node2D

var drag : bool = false

func _ready() -> void:
	area_2d.input_event.connect(_on_area_2d_input_event)
	sling_shot.drag_mode.connect(launch)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_released():
				drag = false

##测试用
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#velocity.y += initial_velocity
			#velocity.x += 200

func _physics_process(delta: float) -> void:
	
	var collisionInfo = move_and_collide(velocity * delta)
	
	if collisionInfo:
		velocity.x = velocity.bounce(collisionInfo.get_normal()).x
		velocity *= BOUNCE_SPEED
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if drag:
		position = to_global(get_local_mouse_position())
	
	#move_and_slide()
	

## 发射
func launch(speed: Vector2) -> void:
	velocity = speed
	#print(speed)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				drag = true
