shader_type canvas_item;

uniform float scroll_speed;

void fragment() {
	vec2 u = UV;
	u.y -= scroll_speed * TIME;
	u.y = mod(u.y, 1.0);
	vec4 col = texture(TEXTURE, u);

	COLOR = col;

	}

