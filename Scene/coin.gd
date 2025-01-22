extends Node2D

@onready var timer: Timer = $Timer

const SPEED : float = 5

func _ready() -> void:
	_random_position()
	await timer.timeout
	queue_free()

#func _physics_process(delta: float) -> void:
	#position.y += SPEED

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		InventorySystem.add_ingame_coins(1)
		queue_free()


func _random_position() -> void:
	position.x = randi_range(0,1080)
