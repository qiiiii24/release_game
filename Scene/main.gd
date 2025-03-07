extends Node2D

# 在高度达到1w的时候背景变黑
const HEIGHT : float = 20000

@onready var shop_button: Button = %ShopButton
@onready var shop: Control = $UI/Shop
@onready var sky_color: CanvasModulate = $ParallaxBackground/ParallaxLayer/Sky/SkyColor
@onready var player: Player = $Player/Player
@onready var height: Label = $UI/Height

@onready var lose_ui: Control = $UI/Lose_ui
@onready var win_ui: Control = $UI/Win_ui

# 颜色渐变
@export var gradient_texture:GradientTexture1D

var current_height : int

func _ready() -> void:
	Event.launch_start.connect(shop_button_visible)
	Event.win_or_lose.connect(win_lose_result)

func _physics_process(delta: float) -> void:
	current_height = player.current_height
	height.text = str(current_height)
	
	var height = current_height/ HEIGHT * 2 * PI
	
	var value := (sin(height - PI / 2) + 1.0) / 2.0
	sky_color.color = gradient_texture.gradient.sample(value)
	

func _on_shop_button_pressed() -> void:
	shop.visible = true

# 切换商店按钮的可见性（开始游戏后不可见）
func shop_button_visible() -> void:
	shop_button.visible = false

func win_lose_result(my_bool: bool) -> void:
	if my_bool:
		win_ui.visible = true
	else:
		lose_ui.visible = true
