////
////rejs:shaders/lib/custom/common.glsl
////

#define OPENGL_USE_VERSION 300
//[300 or 120] whenever you change this, you need to change the version in the first line of every .fsh or .vsh file(with "es" behind if you choose 300).
//Note:  this feature is NOT supported now.

#define UNDERWATER_BODY_MOVE 1
//[1 or 0]  enable or disable

#define WAVE 0
//[1 or 0]  enable or disable