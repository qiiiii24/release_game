extends Control

@onready var label: Label = $Label

## 不一定每次都为0，应为金钱可以继承上一小局
var gold : int = 0

func _ready() -> void:
	change_gold()
	Event.change_coin_ui.connect(change_gold)

func change_gold() -> void:
	gold = InventorySystem.ingame_coins
	label.text = str(gold)


func _on_button_pressed() -> void:
	InventorySystem.add_ingame_coins(50)
