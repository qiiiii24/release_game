extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY # 将2pi分成1440份

# 颜色渐变
@export var gradient_texture:GradientTexture1D

@export var INGAME_SPEED = 20.0

var time : float


func _process(delta: float) -> void:
	var now = Time.get_datetime_dict_from_system()
	time = (now.hour * MINUTES_PER_HOUR + now.minute) * INGAME_TO_REAL_MINUTE_DURATION
	
	var value := (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient_texture.gradient.sample(value)
