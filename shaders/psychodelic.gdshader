shader_type canvas_item;

uniform float speed = .25;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 colors = texture(TEXTURE, UV).rgb;
	colors.r *= (sin(TIME * 1.2 * speed) / 2.) + .6;
	colors.g *= (sin(TIME * 1.5 * speed) / 2.) + .6;
	colors.b *= (sin(TIME * 1.8 * speed) / 2.) + .6;
	COLOR.rgb = colors;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
