shader_type canvas_item;

uniform sampler2D cloud_1;
uniform sampler2D cloud_2;
uniform sampler2D cloud_3;
uniform vec2 direction = vec2(1.0,0.0);
uniform float scroll_speed = 0.1;

void fragment() {

	vec2 move = direction * TIME * scroll_speed;
	vec2 scrolled_uv = fract(UV + move);

	vec4 col = texture(cloud_1, scrolled_uv);

	COLOR = col;
}