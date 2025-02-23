extends Control

@onready var energy_empty: TextureRect = $EnergyEmpty
# 一半
@onready var energy_half: TextureRect = $EnergyHalf
# 满能量
@onready var energy_ui: TextureRect = $EnergyUI

func _ready() -> void:
	InventorySystem.State_change.connect(change_ui)
	add_to_group("energy")

func change_ui(_type) -> void:
	pass
	
	## 满能量
	energy_half.visible = false
	energy_ui.visible = true
	
	## 一半能量
	energy_half.visible = true
	energy_ui.visible = false
