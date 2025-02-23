shader_type canvas_item;

uniform vec2 direction = vec2(1.0,0.0); //x轴
uniform float scroll_speed = 0.1;

void fragment() {
	vec2 move = direction * TIME * scroll_speed;
	
	vec2 scrolled_uv = fract(UV + move);
	
	vec4 col = texture(TEXTURE, scrolled_uv);

	COLOR = col;

	}

