shader_type canvas_item;

uniform vec2 origin = vec2(0.0, 0.0);
uniform float radius = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// TODO: have this as uniform and calculate once
	vec2 aspect = vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1.0);
	// TODO: have this as uniform and calculate once
	vec2 point = origin * aspect;
	vec2 screen_space = UV * aspect;
	float dist = distance(screen_space, point);
	if (radius > dist) {
		discard;
	}
	COLOR.rgb *= 0.4;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
