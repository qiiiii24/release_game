extends Control

@export_file("*.tscn") var path : String


@onready var button: Button = $Button
@onready var label: Label = $Label

func _ready() -> void:
	button.pressed.connect(reloud_scene)

func reloud_scene() -> void:
	
	get_tree().change_scene_to_file(path)
