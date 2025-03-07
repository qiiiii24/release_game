extends Node2D

@export var COLLECTION : PackedScene
@export var G_Collections : Array[Collection]


@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var timer: Timer = $Timer
@onready var player: Player = $"../Player/Player"

var generate_rect : Rect2
# 生成次数
var generate_amount : int = 0

var initial_rect : Rect2

var generator_position : float :
	set(value):
		generator_position = min(generator_position, value)

var can_generate : bool = false

func _physics_process(_delta: float) -> void:
	generator_position = player.position.y - 648
	position.y = generator_position

func _ready() -> void:
	#timer.timeout.connect(_generate_coin) #每0.05秒生成一个
	Event.launch_start.connect(start_generate)
	generate_rect = collision_shape_2d.shape.get_rect()
	initial_rect = generate_rect
	
	Event.launch_start.connect(_generate_coin)
	Event.update_collection.connect(_generate_coin)
	

func start_generate() -> void:
	can_generate = true


func get_random_point_in_rect(rect: Rect2) -> Vector2:
	# 随机生成 x 和 y 坐标
	var random_x = rect.position.x + randf_range(0, rect.size.x)
	var random_y = rect.position.y + randf_range(0, rect.size.y)
	return Vector2(random_x, random_y)

func _generate_coin() -> void:
	if not can_generate : return
	
	generate_amount += 1 #生成次数加1
	
	var collection = G_Collections[0]
	generate_rect.position.y = initial_rect.position.y - 480 * generate_amount

	for i in range(InventorySystem.generate_amount):
		var collection_scene = COLLECTION.instantiate() as Collections
		collection_scene.collection= collection
		collection_scene.position = get_random_point_in_rect(generate_rect)
		get_parent().add_child(collection_scene)


	

	
