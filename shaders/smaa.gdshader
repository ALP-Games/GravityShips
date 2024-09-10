shader_type canvas_item;

uniform sampler2D scene_texture : hint_screen_texture; // The texture of the rendered scene
uniform float SMAA_THRESHOLD : hint_range(0.0, 1.0) = 0.1; // Edge detection threshold
uniform float SMAA_CORNER_ROUNDING : hint_range(0.0, 1.0) = 0.25; // Corner rounding factor

void fragment() {
    // Sample the scene texture at current and surrounding pixels
    vec4 color = texture(scene_texture, SCREEN_UV);
    vec4 tex_left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, 0.0));
    vec4 tex_right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, 0.0));
    vec4 tex_up = texture(scene_texture, SCREEN_UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y));
    vec4 tex_down = texture(scene_texture, SCREEN_UV + vec2(0.0, SCREEN_PIXEL_SIZE.y));
    
    // Diagonal samples for corner detection
    vec4 tex_up_left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y));
    vec4 tex_up_right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y));
    vec4 tex_down_left = texture(scene_texture, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y));
    vec4 tex_down_right = texture(scene_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y));

    // Edge detection based on luminance difference (simplified)
    float edge_horizontal = step(SMAA_THRESHOLD, length(color - tex_left)) + step(SMAA_THRESHOLD, length(color - tex_right));
    float edge_vertical = step(SMAA_THRESHOLD, length(color - tex_up)) + step(SMAA_THRESHOLD, length(color - tex_down));

    // Calculate corner rounding based on diagonals
    float corner_up_left = step(SMAA_THRESHOLD, abs(color.r - tex_up_left.r));
    float corner_up_right = step(SMAA_THRESHOLD, abs(color.r - tex_up_right.r));
    float corner_down_left = step(SMAA_THRESHOLD, abs(color.r - tex_down_left.r));
    float corner_down_right = step(SMAA_THRESHOLD, abs(color.r - tex_down_right.r));

    // Combine corner weights
    float corner_weight = (corner_up_left + corner_up_right + corner_down_left + corner_down_right) / 4.0;

    // Calculate combined edge weight with corner rounding
    float edge_weight = 0.25 * (edge_horizontal + edge_vertical);
    float final_weight = mix(edge_weight, corner_weight, SMAA_CORNER_ROUNDING);

    // Blend the pixels along the edges using the calculated final weight
    vec4 blended_color = mix(color, ((tex_left + tex_right + tex_up + tex_down) /
		4.0) + ((tex_up_left + tex_up_right + tex_down_left + tex_down_right) / 4.0 * SMAA_CORNER_ROUNDING) / 2.0, final_weight);

    // Output the blended color
    COLOR = blended_color;
}
