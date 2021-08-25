////
////rejs:shaders/lib/math.glsl
////

#define PI 3.1415926535897932384626433832795

#define HALF_PI 1.57079632679489661923

//two pi
#define TAU 6.2831853071795864769252867665590

float noise2d(vec2 st) {
	return fract(sin(dot(st.xy, vec2(12.9898, 78.233)))*43758.5453123);
}

float smootherstep(float edge0, float edge1, float x) {
	// Scale, and clamp to 0..1 range
	x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
	// Evaluate polynomial
	return x * x * x * (x * (x * 6. - 15.) + 10.);
}

vec3 smootherstep(float edge0, float edge1, vec3 value) {
	// Scale, and clamp to 0..1 range
	vec3 r = clamp((value - edge0) / (edge1 - edge0), 0.0, 1.0);
	// Evaluate polynomial
	return r * r * r * (r * (r * 6. - 15.) + 10.);
}

//noise2d with time
float noise2dt (in vec2 st, float t) {
	vec2 i = floor(st);
	vec2 f = fract(st);

	// Compute values for four corners
	float a = noise2d(i);
	float b = noise2d(i + vec2(1.0, 0.0));
	float c = noise2d(i + vec2(0.0, 1.0));
	float d = noise2d(i + vec2(1.0, 1.0));

	a =  0.5 + sin((0.5 + a) * t) * 0.5;
	b =  0.5 + sin((0.5 + b) * t) * 0.5;
	c =  0.5 + sin((0.5 + c) * t) * 0.5;
	d =  0.5 + sin((0.5 + d) * t) * 0.5;

	// Mix 4 corners
	return mix(a, b, f.x) +
	(c - a)* f.y * (1.0 - f.x) +
	(d - b) * f.x * f.y;
}

float luminance(vec3 color) {
	return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}