shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;  //, repeat_disable, filter_nearest;

uniform vec2 gravity_point = vec2(0.5, 0.5);
uniform float radius = 0.5;
//uniform float inner_radius = 0.25;
uniform float ring_thickness = 0.1;

void fragment()
{
	vec2 aspect = vec2(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x, 1.0);
	vec2 point = gravity_point * aspect;
	float dist = distance(UV * aspect, point);
	// should be only shrinking
	float timed_radius = (sin(TIME * 3.0) + 1.) / 2. * radius;
	float inner_radius = timed_radius - ring_thickness;
	float circle = smoothstep(timed_radius, timed_radius - 0.1, dist) - smoothstep(inner_radius, inner_radius - 0.1, dist);
	//TIME
	//COLOR = vec4(1.0, 1.0, 1.0, circle);
	COLOR = vec4(vec3(circle), 1.0);
}