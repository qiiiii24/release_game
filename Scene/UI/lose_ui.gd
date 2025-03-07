extends Control

const MAIN := preload("res://Scene/main.tscn")

@onready var button: Button = $Button
@onready var label: Label = $Label

func _ready() -> void:
	button.pressed.connect(reloud_scene)

func reloud_scene() -> void:
	get_tree().reload_current_scene()
