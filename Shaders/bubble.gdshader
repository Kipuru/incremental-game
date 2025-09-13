shader_type canvas_item;

const vec2 center = vec2(0.5, 0.5);
const float radius = 0.5;
const float refraction_strength = 0.1;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec3 color_adjustment = vec3(1., 1., 1.);
uniform bool adjust_using_grayscale = false;

bool is_equal_approx(float a, float b) {
	const float range = 0.01;
	return abs(a - b) < range;
}
// https://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
float grayscale(vec4 input) {
	return (input.r * 0.2126) + (input.g * 0.7152) + (input.b * 0.0722);
}
vec4 adjust_color(vec4 input) {
	if (color_adjustment == vec3(1., 1., 1.)) return input;
	
	vec4 i = input;
	vec3 a = color_adjustment;
	if (adjust_using_grayscale) {
		float gr = grayscale(input);
		return vec4(gr * a.r, gr * a.g, gr * a.b, i.a);
	} else {
		return vec4(i.r * a.r, i.g * a.g, i.b * a.b, i.a);
	}
}

void fragment() {
	vec2 dir = UV - center;
	float dist = length(dir);

	if (dist < radius) {
		if (is_equal_approx(dist, radius)) { // white outline
			COLOR = vec4(1., 1., 1., 1.);
		} else { // refracted inside
			float effect = sqrt(radius*radius - dist*dist) / radius;
			vec2 new_uv = SCREEN_UV + dir * effect * refraction_strength;
			vec4 sampled_color = texture(SCREEN_TEXTURE, new_uv);
			COLOR = adjust_color(sampled_color);
		}
	} else { // unaltered pixels
		discard;
	}
}