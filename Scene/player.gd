extends CharacterBody2D
class_name Player

const BOUNCE_SPEED := 0.8

## 初速度
@export var initial_velocity := -400

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT :
			velocity.y += initial_velocity
			velocity.x += 200

func _physics_process(delta: float) -> void:
	
	var collisionInfo = move_and_collide(velocity * delta)
	
	if collisionInfo:
		velocity.x = velocity.bounce(collisionInfo.get_normal()).x
		velocity *= BOUNCE_SPEED

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#move_and_slide()
	
	
