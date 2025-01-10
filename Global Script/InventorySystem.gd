extends Node

## 全局金币
var global_coins : int = 0
## 游戏内金币
var ingame_coins : int = 0

## 增加全局金币
func add_global_coins(amount: int) -> void:
	global_coins += amount

## 增加游戏内金币
func add_ingame_coins(amount: int) -> void:
	ingame_coins += amount
