/******************************************************
  rejs:shaders/lib/color.glsl

  Portions taken from Wisdom Shaders by Cheng (Bob) Cao, Apache 2.0 license
  https://github.com/bobcao3/Wisdom-Shaders

******************************************************/

const float GAMMA = 2.4;
const float INVERSE_GAMMA = 1.0 / GAMMA;

vec4 fromGamma(vec4 c) {
	return pow(c, vec4(GAMMA));
}

vec4 toGamma(vec4 c) {
	return pow(c, vec4(INVERSE_GAMMA));
}

vec3 fromGamma(vec3 c) {
	return pow(c, vec3(GAMMA));
}

vec3 toGamma(vec3 c) {
	return pow(c, vec3(INVERSE_GAMMA));
}

const mat3 ACES_INPUT_MATRIX = mat3(
vec3(0.59719, 0.07600, 0.02840),
vec3(0.35458, 0.90834, 0.13383),
vec3(0.04823, 0.01566, 0.83777)
);

// ODT_SAT => XYZ => D60_2_D65 => sRGB
const mat3 ACES_OUTPUT_MATRIX = mat3(
vec3(1.60475, -0.10208, -0.00327),
vec3(-0.53108, 1.10813, -0.07276),
vec3(-0.07367, -0.00605, 1.07602)
);

vec3 RRT_AND_ODTF_FIT(vec3 v) {
	vec3 a = v * (v + 0.0245786f) - 0.000090537f;
	vec3 b = v * (0.983729f * v + 0.4329510f) + 0.238081f;
	return a / b;
}

vec3 toneMap(vec3 color) {
	color = ACES_INPUT_MATRIX * color;
	color = RRT_AND_ODTF_FIT(color);
	return ACES_OUTPUT_MATRIX * color;
}
