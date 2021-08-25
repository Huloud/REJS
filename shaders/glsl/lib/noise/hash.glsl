float rc(float cyc,float inp,bool ph)
{
    cyc = abs(cyc);
    float outp;
    if(ph)
        outp = abs(mod(inp + 0.5 * cyc, cyc)) - 0.5 * cyc;
    else
        outp = abs(mod(inp, cyc)) - 0.5 * cyc;
    return outp;
}

float rsc(float cyc,float inp,bool ph)
{
    cyc = abs(cyc);
    float outp;
    if(ph)
        inp = abs(mod(inp + 0.5 * cyc, cyc)) - 0.5 * cyc;
    else
        inp = abs(mod(inp, cyc)) - 0.5 * cyc;
    float am = inp/cyc;
    if(inp<0.0)
        outp=am*am*(2.0*am+3.0);
    else
        outp=am*am*(-2.0*am+3.0);
    outp=(2.0*outp)-1.0;
    outp*=12.345678;
    
    return outp;
} 


float hash4(vec4 p)
{
    return fract(sin(dot(p, vec4(114.5, 141.9, 198.1, 175.5))) * 643.1);
}

float hashSeamless(vec2 p,float distance)
{
	vec4 h = vec4(rsc(distance, p.x, true),rsc(distance, p.x, false),rsc(distance, p.y, true),rsc(distance, p.y, false));
	return hash4(h);
}

float noisesm(vec2 Coord)
{
	const float cycle = 16.0;
	vec2 i = floor(Coord);
	vec2 f = fract(Coord);
	vec2 u = f * f * (f*(vec2(-2.0,-2.0))+(vec2(3.0,3.0)));
	return (mix(mix(hashSeamless(i + vec2(0.0, 0.0), cycle), hashSeamless(i + vec2(1.0, 0.0), cycle), u.x), mix(hashSeamless(i + vec2(0.0, 1.0), cycle), hashSeamless(i + vec2(1.0, 1.0), cycle), u.x), u.y) * 2.0) - 1.0;
}

float WP(vec3 v1,vec3 v2)
{
    return (v1.x*v2.x+v1.y*v2.y+v1.z*v2.z)/length(v1)/length(v2);
}

float WV(vec3 A)
{
    A.z+=TIME*.3;
    float D=rsc(16.,noisesm(vec2(A.x*.2+A.z*.4+A.y*.5+A.x*.2,A.z*.6+A.x*.2+A.z*.6)),true);
    float E=rsc(16.,noisesm(vec2(A.z+A.y,A.x+A.z)),true);
    float W=rsc(16.,TIME*.8+A.z+A.x,false)*rsc(16.,TIME*.4+A.x,false);
    return mix(D,E,W);
}

vec3 WM(vec3 B)
{
    float H=WV(B+vec3(.3,.2,.1))-WV(B);
    return vec3(-H,0.,1.);
}