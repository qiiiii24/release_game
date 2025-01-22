extends Node2D

@export var amount : float

@onready var player: Player = $"../Player"

func _physics_process(delta: float) -> void:
	position.y = player.position.y + amount
