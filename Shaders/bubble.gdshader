shader_type canvas_item;

const vec2 center = vec2(0.5, 0.5);
const float radius = 0.5;
const float refraction_strength = 0.1;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

bool is_equal_approx(float a, float b) {
	const float range = 0.005;
	return abs(a - b) < range;
}

void fragment() {
	vec2 dir = UV - center;
	float dist = length(dir);
	vec2 new_uv = SCREEN_UV;

	if (is_equal_approx(dist, radius)) {
		// white outline
		COLOR = vec4(1., 1., 1., 1.);
	} else {
		if (dist < radius) {
			float effect = sqrt(radius*radius - dist*dist) / radius;
			new_uv += dir * effect * refraction_strength;
		}
		vec4 screen_color = texture(SCREEN_TEXTURE, new_uv);
		COLOR = screen_color;
	}
}