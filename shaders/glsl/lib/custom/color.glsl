////
////rejs:shaders/lib/custom/color.glsl
////

//------torch------//
vec3 tco = vec3(0.99,0.87,0.57);//normal
vec3 tnco = vec3(3.94,3.28,0.36);//night

//------terrain------//
vec3 dco = vec3(0.996,0.95,0.957);//normal
vec3 dnco = vec3(0.42,0.38,0.42);//night
vec3 daco = vec3(0.99,0.67,0.58);//dusk

//------fog------//
vec3 fday_color=vec3(1.1,1.32,1.62);//day
vec3 fnight_color=vec3(0.35,0.5,0.7);//night
vec3 fdusk_color=vec3(0.65,0.4,0.15)*1.35;//dusk
vec3 frain_color=vec3(0.5,0.5,0.5);//rain
vec3 frain_n_color=vec3(0.3,0.3,0.3);//night rain
vec3 fne_color=vec3(0.7,0.4,0.1);//nether
vec3 fen_color=vec3(0.65,0.42,0.4);//the end
vec3 fuw_col=vec3(0.0,0.5,0.8);//underwater

//------高层大气------//
vec3 day_base_sky=vec3(0.38,0.52,0.72);//白天
vec3 night_base_sky=vec3(0.2,0.3,0.5);//夜晚
vec3 dusk_base_sky=vec3(1.2,1.0,0.4);//黄昏
vec3 raind_base_sky=vec3(0.4,0.4,0.4);//白天(雨)
vec3 rainn_base_sky=vec3(0.3,0.3,0.3);//夜晚(雨)

//------平流层------//
vec3 day_s_sky=vec3(0.35,0.46,0.8);//白天
vec3 night_s_sky=vec3(0.2,0.3,0.5);//夜晚
vec3 dusk_s_sky=vec3(1.2,1.0,0.3);//黄昏
vec3 rain_s_sky=vec3(0.7);//下雨

//------对流层------//
vec3 day_t_sky=vec3(0.93,0.98,1.0);//白天
vec3 night_t_sky=vec3(0.6,0.6,0.7);//夜晚
vec3 dusk_t_sky=vec3(2.0,0.7,0.3);//黄昏
vec3 rain_t_sky=vec3(0.6,0.6,0.6);//下雨

//------shadows------//
vec3 sco=vec3(0.55,0.55,0.58);