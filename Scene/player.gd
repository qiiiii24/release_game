extends CharacterBody2D
class_name Player

## 初速度
@export var initial_velocity := -1400

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and is_on_floor():
			velocity.y += initial_velocity
			

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
