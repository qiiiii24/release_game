extends Control

@export_file("*.tscn") var path : String

@onready var button: Button = $Button


func _ready() -> void:
	button.pressed.connect(start_geme)
	
	# 控制灯光
	#for child in get_tree().get_nodes_in_group("light"):
		#var now = Time.get_datetime_dict_from_system().hour 
		#if now > 20 or now < 8:
			#child.energy = 0.5

func start_geme() -> void:
	print("pressed")
	get_tree().change_scene_to_file(path)
