extends Node2D
class_name Coin

@export var collection : Collection : set = set_collection

@onready var timer: Timer = $Timer
@onready var icon: Sprite2D = $Icon

const SPEED : float = 5

var coin_amount : int = 1

func _ready() -> void:
	
	_random_position()
	await timer.timeout
	queue_free()

#func _physics_process(delta: float) -> void:
	#position.y += SPEED

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		InventorySystem.add_ingame_coins(coin_amount)
		queue_free()


func _random_position() -> void:
	position.x = randi_range(0,648)

func set_collection(new_collection : Collection) -> void:
	if not is_node_ready():
		await ready
	
	collection = new_collection
	
	coin_amount = collection.amount
	icon.texture = collection.icon
