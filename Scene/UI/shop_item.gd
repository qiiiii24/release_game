extends Control

## ui层面要处理的事情为，告诉Inv买了什么类型，buybutton能否触发和标明价格


# 初始value应为0.1， 第一个为0.26，相差0.16
@onready var level: TextureProgressBar = %Level
@onready var buy_button: Button = %BuyButton
@onready var label: Label = $Label

@export var  ability := InventorySystem.ABILITY.PICK_RANGE

@export var item_name : String  

func _ready() -> void:
	change_ui(null)
	buy_button.pressed.connect(buy)
	Event.ability_change.connect(change_ui)
	

func buy() -> void:
	InventorySystem.bought.emit(ability)


func change_ui(_type) -> void:
	
	var current_level := InventorySystem.get_ability_level(ability)
	var cost = InventorySystem.ability_upgrade_cost[ability].call(current_level)
	
	# 改名称
	label.text = str(item_name)
	
	# 改进度条
	level.value = 0.1 + current_level * 0.16
	
	# 标价格
	buy_button.text = str(cost)
	
	# buybutton能否触发
	if InventorySystem.ingame_coins >= cost:
		#修改颜色
		#buy_button.remove_theme_color_override("font_color")
		buy_button.disabled = false
	else:
		#buy_button.add_theme_color_override("font_color", Color.RED)
		buy_button.disabled = true
	
	
