extends Node

signal ingame_coins_change

## 全局金币（局外成长与解释角色）
var global_coins : int = 0
## 游戏内金币（用于局内成长和购买一次性道具）
var ingame_coins : int = 0
## 游戏内分数（分数不足视为失败）

## 增加全局金币
func add_global_coins(amount: int) -> void:
	global_coins += amount

## 增加游戏内金币
func add_ingame_coins(amount: int) -> void:
	ingame_coins += amount
	ingame_coins_change.emit()
	
