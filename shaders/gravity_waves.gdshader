shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;  //, repeat_disable, filter_nearest;

// Automatically configurable
uniform vec2 gravity_point = vec2(0.5, 0.5);
uniform vec2 aspect = vec2(1.0, 1.0);

// Manually configurable
uniform float radius = 0.1;
uniform float offset = 0.3;
uniform float factor = 500.;
uniform float wave_color_intensity = 0.1;
uniform float ring_density = 100.;
uniform float gravity_speed = 10.;

void fragment()
{
	// TODO: have this as uniform and calculate once
	//vec2 point = gravity_point * aspect;
	vec2 screen_space = UV * aspect;
	float dist = distance(screen_space, gravity_point);
	float waves = ((sin(ring_density / (dist + offset) - TIME * gravity_speed) + 1.) / 2.) - smoothstep(radius, radius - 0.01,  dist);
	waves = clamp(waves, 0.0, 1.0);
	vec3 distortion = texture(SCREEN_TEXTURE, SCREEN_UV + (waves / factor)).rgb;
	distortion = (distortion + waves * wave_color_intensity) / (1. + wave_color_intensity);

	COLOR = vec4(distortion, 1.0);
	//COLOR = vec4(vec3(waves), 1.0);
}