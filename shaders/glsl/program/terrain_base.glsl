////
////rejs:shaders/program/terrain_base.glsl
////

#include "uniformWorldConstants.h"
#include "uniformShaderConstants.h"
#include "uniformInterFrameConstants.h"
#include "uniformPerFrameConstants.h"
#include "uniformRenderChunkConstants.h"
#include "util.h"

#include "lib/math.glsl"
#include "lib/detect.glsl"
#include "lib/custom/common.glsl"
#include "lib/lighting/color.glsl"
#include "lib/custom/color.glsl"
#include "lib/noise/hash.glsl"

#ifndef BYPASS_PIXEL_SHADER
    varying vec2 texcoord;
    varying vec2 lmcoord;

    varying lowp vec4 color;
    varying vec4 wpos;
    varying vec4 cpos;
#endif

layout(binding=0) uniform sampler2D TEXTURE_0;
layout(binding=1) uniform sampler2D TEXTURE_1;
layout(binding=2) uniform sampler2D TEXTURE_2;


#ifdef VSH
    in POS4 POSITION;
    in vec4 COLOR;
    in vec2 TEXCOORD_0;
    in vec2 TEXCOORD_1;

    void main(){
        #ifdef AS_ENTITY_RENDERER
        	wpos = POSITION;
        #else
        	wpos = vec4(POSITION.xyz * CHUNK_ORIGIN_AND_SCALE.w + CHUNK_ORIGIN_AND_SCALE.xyz, 1.0);
        #endif

    	gl_Position = WORLDVIEWPROJ * wpos;
        if(UNWATER(FOG_COLOR)&&UNDERWATER_BODY_MOVE==1)
        gl_Position.xy+=vec2(sin(TIME)*0.1,cos(TIME)*0.05);
        #ifndef BYPASS_PIXEL_SHADER
        	texcoord = TEXCOORD_0;
        	lmcoord = TEXCOORD_1;
        	color = COLOR;
        	cpos = POSITION;
            #ifndef FOG
            	color.rgb += FOG_COLOR.rgb * 0.000001;
            #endif
        #endif
    }

#endif

#ifdef FSH

    void main(){
    
        #ifdef BYPASS_PIXEL_SHADER
            gl_FragColor=vec4(0.0);
            return;
        #else
            vec4 texcol = texture(TEXTURE_0, texcoord);
            vec4 biomecol = texture(TEXTURE_2, color.xy);
            vec4 lmcol = texture(TEXTURE_1, lmcoord);
            
            float a,b,c;
            timer(FOG_COLOR.r,FOG_CONTROL.y,smoothstep(0.0,0.875,lmcoord.y),TEXTURE_1,a,b,c);
            float bvb=WP(vec3(1.0),WM(cpos.xyz*0.5));
        
           if(texcol.a<0.5)discard;
        
            #ifdef BLEND
              texcol.a*=color.a;
            #endif
            
            #ifndef ALWAYS_LIT
                texcol*=lmcol;
            #endif
            
            #ifndef SEASONS
            	#if !USE_ALPHA_TEST && !defined(BLEND)
            		texcol.a = color.a;
            	#endif
	            #ifdef BLEND
                    texcol.rgb *= color.rgb;
                #else
                    if(color.g+color.g>color.r+color.b)texcol.rgb*=color.rgb;
	           else
	               texcol.rgb*=pow(color.rgb,vec3(0.1));
	           #endif
            #else
                texcol.rgb *= mix(vec3(1.0,1.0,1.0), biomecol.rgb*2.0, color.b);
	            texcol.rgb *= color.a;
	            texcol.a = 1.0;
            #endif
            if(WATER(color)&&WAVE==1)texcol+=bvb;
            
            vec4 fogColor=vec4(mix(mix(mix(fday_color,fnight_color,b),fdusk_color,a),mix(frain_color,frain_n_color,b),c),clamp((length(-wpos)/RENDER_DISTANCE)*0.6,0.0,1.0));
            if(UNWATER(FOG_COLOR)&&!WATER(color)){
                fogColor.a=clamp(fogColor.a*15.0,0.0,0.7);
                fogColor.rgb=fuw_col;
            }
            texcol.rgb = mix(texcol.rgb,fogColor.rgb,fogColor.a);
            
            gl_FragColor=texcol;
        #endif
    }

#endif