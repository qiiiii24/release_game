extends Control


@onready var energy_empty: TextureRect = $EnergyEmpty

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	#InventorySystem.State_change.connect(change_ui)
	add_to_group("energy")

func update(fraction: int) -> void:
	match fraction:
		0: sprite_2d.frame = 2 # 没有能量
		1: sprite_2d.frame = 1 # 一半能量
		2: sprite_2d.frame = 0 # 满能量
