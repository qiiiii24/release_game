extends Control

@onready var button: Button = $Button


func _ready() -> void:
	button.pressed.connect(open_shop)

func open_shop() -> void:
	var shop = get_tree().get_first_node_in_group("shop")
	shop.visible = true
	visible = false
