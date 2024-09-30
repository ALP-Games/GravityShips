shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture; // The texture of the rendered scene
uniform float fxaa_reduce_min : hint_range(0.0, 1.0) = 0.0078125;
uniform float fxaa_reduce_mul : hint_range(0.0, 1.0) = 0.125;
uniform float fxaa_span_max : hint_range(0.0, 8.0) = 8.0;

void fragment() {
    vec2 texel_size = 1.0 / TEXTURE_PIXEL_SIZE;

    // Calculate luminance
    vec3 rgb_nw = texture(SCREEN_TEXTURE, FRAGCOORD.xy + (vec2(-1.0, -1.0) * SCREEN_PIXEL_SIZE)).rgb;
    vec3 rgb_ne = texture(SCREEN_TEXTURE, FRAGCOORD.xy + (vec2(1.0, -1.0) * SCREEN_PIXEL_SIZE)).rgb;
    vec3 rgb_sw = texture(SCREEN_TEXTURE, FRAGCOORD.xy + (vec2(-1.0, 1.0) * SCREEN_PIXEL_SIZE)).rgb;
    vec3 rgb_se = texture(SCREEN_TEXTURE, FRAGCOORD.xy + (vec2(1.0, 1.0) * SCREEN_PIXEL_SIZE)).rgb;
    vec3 rgb_m = texture(SCREEN_TEXTURE, FRAGCOORD.xy).rgb;

    float luma_nw = dot(rgb_nw, vec3(0.299, 0.587, 0.114));
    float luma_ne = dot(rgb_ne, vec3(0.299, 0.587, 0.114));
    float luma_sw = dot(rgb_sw, vec3(0.299, 0.587, 0.114));
    float luma_se = dot(rgb_se, vec3(0.299, 0.587, 0.114));
    float luma_m = dot(rgb_m, vec3(0.299, 0.587, 0.114));

    // Find minimum and maximum luminance
    float luma_min = min(luma_m, min(min(luma_nw, luma_ne), min(luma_sw, luma_se)));
    float luma_max = max(luma_m, max(max(luma_nw, luma_ne), max(luma_sw, luma_se)));

    // Check contrast threshold
    float luma_range = luma_max - luma_min;
    if (luma_range < max(fxaa_reduce_min, luma_max * fxaa_reduce_mul)) {
        COLOR = vec4(rgb_m, 1.0);
        discard;
    }

    // Calculate direction to blur
    vec2 dir;
    dir.x = -((luma_nw + luma_ne) - (luma_sw + luma_se));
    dir.y = ((luma_nw + luma_sw) - (luma_ne + luma_se));

    float dir_reduce = max((luma_nw + luma_ne + luma_sw + luma_se) * (0.25 * fxaa_reduce_mul), fxaa_reduce_min);
    float rcp_dir_min = 1.0 / (min(abs(dir.x), abs(dir.y)) + dir_reduce);
    dir = clamp(dir * rcp_dir_min, vec2(-fxaa_span_max), vec2(fxaa_span_max)) * texel_size;

    // Sample the texture along the direction
    vec3 result1 = texture(SCREEN_TEXTURE, FRAGCOORD.xy + dir * (1.0/3.0 - 0.5)).rgb;
    vec3 result2 = texture(SCREEN_TEXTURE, FRAGCOORD.xy + dir * (2.0/3.0 - 0.5)).rgb;
    vec3 final_color = (result1 + result2) * 0.5;

    COLOR = vec4(final_color, 1.0);
}
