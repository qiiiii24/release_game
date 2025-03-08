extends Node2D

const chest_level = {
	# level 1
	"1" : preload("res://Assets/chest/wooden_chest.tres"),
	# level 2
	"2" : preload("res://Assets/chest/Iron_chest.tres"),
	# level 3
	"3" : preload("res://Assets/chest/3level_chest.tres"),
	# level 4
	"4" : preload("res://Assets/chest/high_level_chest.tres"),
	# level 5
	"5" : preload("res://Assets/chest/luxury_chest.tres"),
	# level 6
	"6" : preload("res://Assets/chest/6level_chest.tres"),
	# level 7
	"7" : preload("res://Assets/chest/maxlevel_chest.tres")
}

# level 1
const wooden_chest = preload("res://Assets/chest/wooden_chest.tres")
# level 2
const iron_chest = preload("res://Assets/chest/Iron_chest.tres")
# level 3
const level_3_chest = preload("res://Assets/chest/3level_chest.tres")
# level 4
const level_4_chest = preload("res://Assets/chest/high_level_chest.tres")
# level 5
const level_5_chest = preload("res://Assets/chest/luxury_chest.tres")
# level 6
const level_6_chest = preload("res://Assets/chest/6level_chest.tres")
# level 7
const max_level_chest = preload("res://Assets/chest/maxlevel_chest.tres")



# 已打开
var open : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var particles_1: GPUParticles2D = $Particles1
@onready var particles_2: GPUParticles2D = $Particles2
@onready var particles_3: GPUParticles2D = $Particles3

func _ready() -> void:
	change_chest_level(4)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and open == false: 
				
				animation_player.play("open")
				open = true

func change_chest_level(level: int) -> void:
	match level:
		1:
			sprite_2d.texture = chest_level["1"]
		2:
			sprite_2d.texture = chest_level["2"]
		3:
			sprite_2d.texture = chest_level["3"]
		4:
			sprite_2d.texture = chest_level["4"]
		5:
			sprite_2d.texture = chest_level["5"]
		6:
			sprite_2d.texture = chest_level["6"]
		7:
			sprite_2d.texture = chest_level["7"]
