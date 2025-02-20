extends Node2D


@onready var shop_button: Button = %ShopButton
@onready var shop: Control = $UI/Shop



func _on_shop_button_pressed() -> void:
	shop.visible = true
