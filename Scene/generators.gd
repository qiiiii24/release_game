extends Node2D

@export var COIN : PackedScene

@onready var timer: Timer = $Timer
@onready var player: Player = $"../Player"

var generator_position : float :
	set(value):
		generator_position = min(generator_position, value)

var can_generate : bool = false

func _physics_process(delta: float) -> void:
	generator_position = player.position.y - 648
	position.y = generator_position

func _ready() -> void:
	timer.timeout.connect(_generate_coin) #每0.05秒生成一个
	player.start.connect(start_generate)
	

func start_generate() -> void:
	can_generate = true
	

func _generate_coin() -> void:
	if not can_generate : return
	var coin := COIN.instantiate()
	coin.position = position
	get_parent().add_child(coin)
