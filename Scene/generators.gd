extends Node2D

@export var COLLECTION : PackedScene
@export var G_Collections : Array[Collection]

@onready var timer: Timer = $Timer
@onready var player: Player = $"../Player/Player"

var generator_position : float :
	set(value):
		generator_position = min(generator_position, value)

var can_generate : bool = false

func _physics_process(_delta: float) -> void:
	generator_position = player.position.y - 648
	position.y = generator_position

func _ready() -> void:
	timer.timeout.connect(_generate_coin) #每0.05秒生成一个
	Event.launch_start.connect(start_generate)
	

func start_generate() -> void:
	can_generate = true
	

#func _generate_coin(collection: Collection) -> void:
func _generate_coin() -> void:
	if not can_generate : return
	
	var collection = G_Collections[0]
	
	var collection_scene = COLLECTION.instantiate() as Collections
	collection_scene.collection= collection
	collection_scene.position = position
	get_parent().add_child(collection_scene)


	

	
