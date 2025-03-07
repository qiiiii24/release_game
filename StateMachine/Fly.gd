extends PlayerState

# 最大转速（弧度每秒）
var max_rotation_speed := 10.0

# 旋转速度的缩放因子
var rotation_scale := 0.02

var start_rotate : bool = false

func enter() -> void:
	Event.start_rotate.connect(rotation)

# 和spring碰撞
func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body)
	if body is Spring:
		player.camera_can_move = true
		player.can_draw_line = false
		var fall_speed := -player.velocity.y
		var lanching_speed = Vector2(0, -1000) + Vector2(0, fall_speed)
		player.velocity += lanching_speed

# 未调用
func calculate_height() -> void:
	# true为up false为down
	var up_down : bool = player.velocity.y < 0
	if up_down:
		player.current_height = player.initial_y_position - player.position.y
		if player.update_collection_height:
			#print("当前高度：" +  str(player.current_height))
			Event.update_collection.emit()

func _process(delta: float) -> void:
	rotate_player(delta)
	
	## 判断是否到达结束速度
	if player.velocity.y > 550:
		transition_requested.emit(self, PlayerState.State.DIE)

func rotation(my_bool: bool) -> void:
	start_rotate = my_bool

func rotate_player(delta: float) -> void:
	if start_rotate:
		var vel = player.velocity
		
		# 旋转速度
		var rotation_speed = vel.length() * rotation_scale
		
		rotation_speed = min(rotation_speed, max_rotation_speed)
		
		player.sprite_2d.rotation += rotation_speed * delta

# 捡金币或者药水
func _on_area_2d_area_entered(area: Area2D) -> void:
	var collection = area.get_parent()
	if collection is Collections:
		if collection.type == Collection.TYPE.COIN:
			var coin_amount = collection.amount
			InventorySystem.add_ingame_coins(coin_amount)
			collection.queue_free()
		elif collection.type == Collection.TYPE.POTION:
			var energy_amount = collection.amount
			InventorySystem.add_energy(energy_amount)
			collection.queue_free()
