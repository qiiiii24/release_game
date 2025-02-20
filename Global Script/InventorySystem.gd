extends Node

signal ingame_coins_change
signal State_change(type)
signal bought(ability: ABILITY)

## 全局金币（局外成长与解释角色）
var global_coins : int = 0
## 游戏内金币（用于局内成长和购买一次性道具）
var ingame_coins : int = 500
## 游戏内分数（分数不足视为失败）

## 能力
enum ABILITY {
	PICK_RANGE,  # 拾取范围
	VELOCITY_FACTOR,  # 速度
	TOTOL_ENERGY,     # 踏板所消耗能量
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
	ABILITY.TOTOL_ENERGY: 0,
	ABILITY.ATTACK: 0,
	ABILITY.DEFENSE: 0
}

# 每种能力的升级花费公式（示例：基础花费 * (当前等级 + 1)）
var ability_upgrade_cost = {
	ABILITY.PICK_RANGE: func(level): return clamp(10 * (level + 1), 10, 50),  # PICK_RANGE 花费公式
	ABILITY.VELOCITY_FACTOR: func(level): return 15 * (level + 1), # VELOCITY_FACTOR 花费公式
	ABILITY.TOTOL_ENERGY: func(level): return 20 * (level + 1),     # TOTOL_ENERGY 花费公式
	ABILITY.ATTACK: func(level): return 25 * (level + 1),     # ATTACK 花费公式
	ABILITY.DEFENSE: func(level): return 30 * (level + 1)     # DEFENSE 花费公式
}

## 局内
# 拾取范围
var pick_range : float = 9
# 速度
var initial_velocity_factor : float = 40
# 踏板所消耗能量
var spring_consume_energy : float 
# 踏板总能量
var spring_total_energy : float = 60
# 踏板给玩家的速度
var spring_velocity_factor : float = 15
# 生成物概率(以什么为标准还没有确定)
var generate_rate
# 云朵(减少速度的物体)减少的速度
var cloud_reduce_factor : float = 0.1
# 加速物品的效率
var acceleration_factor

func _ready() -> void:
	bought.connect(upgrade_ability)

## 增加全局金币
func add_global_coins(amount: int) -> void:
	global_coins += amount

## 增加游戏内金币
func add_ingame_coins(amount: int) -> void:
	ingame_coins += amount
	State_change.emit(null)
	
# 升级能力
func upgrade_ability(ability: ABILITY) -> void:
	var current_level = abilities[ability]
	if current_level >= 5: return  # 检查是否未满级
	
	# 计算升级花费
	var cost = ability_upgrade_cost[ability].call(current_level)
	
	# 检查货币是否足够
	if InventorySystem.ingame_coins >= cost:
		# 扣除货币
		InventorySystem.add_ingame_coins(-cost)
		# 升级能力
		abilities[ability] = current_level + 1
		
		#InventorySystem.ingame_coins_change.emit()
		
		change_ability_amount(ability)
	else:
		print("金币不足")

## 改变能力的数值
func change_ability_amount(ability: ABILITY) -> void:
	
	if ability == ABILITY.PICK_RANGE:
		InventorySystem.pick_range += abilities[ability] * 0.5
	elif ability == ABILITY.VELOCITY_FACTOR:
		InventorySystem.initial_velocity_factor += abilities[ABILITY.VELOCITY_FACTOR] * 1
	elif ability == ABILITY.TOTOL_ENERGY:
		InventorySystem.spring_total_energy += 20
	
	InventorySystem.State_change.emit(abilities[ability])

# 获取当前能力等级
func get_ability_level(ability: ABILITY) -> int:
	return abilities[ability]
