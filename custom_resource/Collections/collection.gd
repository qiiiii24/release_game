extends Resource
class_name Collection

enum TYPE{
	COIN,
	POTION
	## 后续在增加一个局外金币
	
}

## 图片
@export var icon : Texture
## 名字
@export var id : String
## 获得的金币数量
@export var amount : int
## 概率
@export var probability : float

## 类型
@export var type : TYPE
