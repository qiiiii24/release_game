extends Node


signal fly_ready(my_bool)

# 开始旋转
signal start_rotate(my_bool)

# 能量减少或增加,改变energyUI
signal change_energy_bar

# 改变金币UI
signal change_coin_ui

# 改变能力的时候（商店购买或者遗物，局外成长）
signal ability_change(type)

# 玩家开始发射
signal launch_start

# 达到一次刷新高度
signal update_collection

# 赢或输(赢true，输false)
signal win_or_lose(type: bool)
