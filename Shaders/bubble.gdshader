shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 center = vec2(0.5, 0.5); // sphere center in uv space
uniform float radius = 0.3; // sphere radius
uniform float strength = 0.5; // how much it bends

void fragment() {
	vec2 dir = UV - center;
    float dist = length(dir);
	vec2 new_uv = SCREEN_UV;

	if (dist < radius) {
		float effect = sqrt(radius*radius - dist*dist) / radius; // like a hemisphere
		new_uv += dir * effect * strength; // displace uv outward
	}
	
	vec4 screen_color = texture(SCREEN_TEXTURE, new_uv);
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = screen_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
