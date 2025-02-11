extends Control

@onready var label: Label = $Label

## 不一定每次都为0，应为金钱可以继承上一小局
var gold : int = 0
		
func _ready() -> void:
	change_gold()
	InventorySystem.ingame_coins_change.connect(change_gold)

func change_gold() -> void:
	gold = InventorySystem.ingame_coins
	label.text = str(gold)
