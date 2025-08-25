shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D displacement_noise_x : repeat_enable;
uniform sampler2D displacement_noise_y : repeat_enable;
uniform sampler2D displacement_noise_height : repeat_enable;
uniform float fill : hint_range(0, 1);

vec2 displace_uv(vec2 uv) {
	const float uv_scroll_speed = 1. / 50.;
	const vec2 uv_scroll_dir = vec2(1., 1.);
	const float uv_displacement_scale = 1. / 20.;
	
	vec2 velocity = vec2(uv_scroll_dir.x + (TIME * uv_scroll_speed), uv_scroll_dir.y + (TIME * uv_scroll_speed));
	vec2 sample_coord = vec2(uv.x + velocity.x, uv.y + velocity.y);
	
	float sampled_x = (texture(displacement_noise_x, sample_coord).r - 0.5) * uv_displacement_scale;
	float sampled_y = (texture(displacement_noise_y, sample_coord).r - 0.5) * uv_displacement_scale;
	sampled_x = clamp(sampled_x, 0., 1.);
	sampled_y = clamp(sampled_y, 0., 1.);
	
	return vec2(uv.x + sampled_x, uv.y + sampled_y);
}

float displace_height(float height, vec2 uv) {
	const float height_scroll_speed =  1. / 30.;
	const vec2 height_scroll_dir = vec2(1., 0.);
	const float height_displacement_scale = 1. / 10.;
	
	vec2 velocity = vec2(height_scroll_dir.x + (TIME * height_scroll_speed), height_scroll_dir.y + (TIME * height_scroll_speed));
	vec2 sample_coord = vec2(uv.x + velocity.x, uv.y + velocity.y);
	
	float sampled = (texture(displacement_noise_height, sample_coord).r - 0.5) * height_displacement_scale;
	sampled = clamp(sampled, 0., 1.);
	
	return height + sampled;
}

// Adapted from https://www.shadertoy.com/view/Xltfzj
vec4 sample_with_blur(vec2 displaced_uv, vec2 screen_pixel_size) {
	const float directions = 4.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
	const float quality = 4.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
	const float size = 4.0; // BLUR SIZE (Radius)
	
	vec4 color = texture(SCREEN_TEXTURE, displaced_uv);
	
	// Blur calculations
	vec2 radius = size * screen_pixel_size;
	for(float d=0.0; d<PI; d+=PI/directions) {
		for(float i=1.0/quality; i<=1.001; i+=1.0/quality) {
			color += texture(SCREEN_TEXTURE, displaced_uv+vec2(cos(d),sin(d))*radius*i);
		}
	}
	color = vec4(color.rgb / (quality * directions + 1.), 1.);
	
	// tint blue
	color = vec4(color.r * 0.6, color.g * 0.9, color.b, 1.);
	
	return color;
}

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	vec2 displaced_uv = displace_uv(SCREEN_UV);
	vec4 water_color = sample_with_blur(displaced_uv, SCREEN_PIXEL_SIZE);
	
	float height = (fill - (1.-UV.y));
	height = displace_height(height, UV);
	if (height < 0.) {
		COLOR = screen_color;
	} else {
		COLOR = water_color;
	}
	//COLOR = vec4(height, 0., 0., 1.);
}