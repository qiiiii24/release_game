extends Control

@export_file("*.tscn") var path : String

func _on_quit_pressed() -> void:
	visible = false
	get_tree().change_scene_to_file(path)
