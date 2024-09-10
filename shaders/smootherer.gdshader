shader_type canvas_item;

uniform sampler2D scene_texture : hint_screen_texture; 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(scene_texture, SCREEN_UV);
	vec4 top = texture(scene_texture, SCREEN_UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y));
	vec4 bottom = texture(scene_texture, SCREEN_UV + vec2(0.0, SCREEN_PIXEL_SIZE.y));
	vec4 left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, 0));
	vec4 right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, 0));
	
	vec4 top_left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y));
	vec4 top_right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y));
	vec4 bottom_left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y));
	vec4 bottom_right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y));
	
	COLOR = (top + bottom + left + right + top_left + top_right + bottom_left + bottom_right) * 0.125;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
