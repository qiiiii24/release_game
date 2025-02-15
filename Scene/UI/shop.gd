extends Control

## 能力
enum ABILITY {
	PICK_RANGE,  # 拾取范围
	VELOCITY_FACTOR,  # 速度
	HEALTH,     # 踏板所消耗能量
	ATTACK,     # 踏板总能量
	DEFENSE     # 生成物概率
	# 踏板给玩家的速度
	# 云朵(减少速度的物体)减少的速度
	# 加速物品的效率
}

## 能力等级
var abilities = {
	ABILITY.PICK_RANGE: 0,
	ABILITY.VELOCITY_FACTOR: 0,
	ABILITY.HEALTH: 0,
	ABILITY.ATTACK: 0,
	ABILITY.DEFENSE: 0
}

# 每种能力的升级花费公式（示例：基础花费 * (当前等级 + 1)）
var ability_upgrade_cost = {
	ABILITY.PICK_RANGE: func(level): return 10 * (level + 1),  # PICK_RANGE 花费公式
	ABILITY.VELOCITY_FACTOR: func(level): return 15 * (level + 1), # VELOCITY_FACTOR 花费公式
	ABILITY.HEALTH: func(level): return 20 * (level + 1),     # HEALTH 花费公式
	ABILITY.ATTACK: func(level): return 25 * (level + 1),     # ATTACK 花费公式
	ABILITY.DEFENSE: func(level): return 30 * (level + 1)     # DEFENSE 花费公式
}

@export var player: Player

# 升级能力
func upgrade_ability(ability: ABILITY) -> void:
	var current_level = abilities[ability]
	if abilities[ability] >= 5: return  # 检查是否未满级
	
	# 计算升级花费
	var cost = ability_upgrade_cost[ability].call(current_level)
	
	# 检查货币是否足够
	if InventorySystem.ingame_coins >= cost:
		# 扣除货币
		InventorySystem.ingame_coins -= cost
		# 升级能力
		abilities[ability] += 1
		
		change_ability_amount(ability)
	else:
		print("金币不足")

## 改变能力的数值
func change_ability_amount(ability: ABILITY) -> void:
	if ability == ABILITY.PICK_RANGE:
		player.pick_range += abilities[ABILITY.PICK_RANGE] * 0.5
	elif ability == ABILITY.VELOCITY_FACTOR:
		pass

# 获取当前能力等级
func get_ability_level(ability: ABILITY) -> int:
	return abilities[ability]


# 示例用法
func _ready():
	InventorySystem.ingame_coins = 100
	
	# 升级 PICK_RANGE 能力
	upgrade_ability(ABILITY.PICK_RANGE)
	upgrade_ability(ABILITY.PICK_RANGE)
	upgrade_ability(ABILITY.PICK_RANGE)
	
