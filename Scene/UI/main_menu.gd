extends Control

const MAIN := preload("res://Scene/main.tscn")

@onready var button: Button = $Button


func _ready() -> void:
	button.pressed.connect(start_geme)

func start_geme() -> void:
	get_tree().change_scene_to_packed(MAIN)
