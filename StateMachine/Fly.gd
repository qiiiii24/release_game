extends PlayerState

# 最大转速（弧度每秒）
var max_rotation_speed := 10.0

# 旋转速度的缩放因子
var rotation_scale := 0.02

var start_rotate : bool = false

func enter() -> void:
	Event.start_rotate.connect(rotation)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Spring:
		player.camera_can_move = true
		player.can_draw_line = false
		var lanching_speed = Vector2(0, -1000)
		player.velocity += lanching_speed

func _process(delta: float) -> void:
	rotate_player(delta)

func rotation(my_bool: bool) -> void:
	start_rotate = my_bool

func rotate_player(delta: float) -> void:
	if start_rotate:
		var vel = player.velocity
		
		# 旋转速度
		var rotation_speed = vel.length() * rotation_scale
		
		rotation_speed = min(rotation_speed, max_rotation_speed)
		
		player.rotation += rotation_speed * delta
