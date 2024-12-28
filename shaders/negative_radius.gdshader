shader_type canvas_item;

// Automatically configurable
uniform vec2 aspect = vec2(1.0, 1.0);
uniform vec2 point = vec2(0.5, 0.5);
uniform float radius = 0.5;
// Manually configurable
uniform float intensity = 0.4;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 screen_space = UV * aspect;
	float dist = distance(screen_space, point);
	if (radius > dist) {
		discard;
	}
	COLOR.rgb *= intensity;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
