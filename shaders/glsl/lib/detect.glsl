////
////rejs:shaders/lib/detect.glsl
////

#define UNWATER(FC) ((FC.b>.15&&(FC.b>FC.g*1.2)&&(FC.b>=FC.r*1.8)&&(FC.g>FC.r*1.6))||(FC.g*1.2>=FC.b)&&(FC.r*1.3<FC.g))

#define WATER(CO) (CO.r<CO.g&&CO.r*1.1<CO.b&&CO.g<CO.b*1.25&&CO.b*CO.b>CO.r*CO.g)

#define NETHER(FC) ((FC.b==FC.g)&&(FC.b*1.5<FC.r))

#define THEEND(FC) ((FC.r>FC.g)&&(FC.b>FC.g)&&(FC.b>FC.r)&&(FC.r<.05&&FC.b<.05&&FC.g<.05))

void timer( float nightpre, float rainpre, float set, sampler2D TEX_1, inout float a, inout float b, inout float c ){
        vec4 nc=texture(TEX_1,vec2(0.0,1.0));
        float Ti=(nc.r-0.5)/0.5;
        Ti=clamp(Ti,0.0,1.0);
        float nt=set*(1.0-Ti);
        b=(max(pow(max(min(1.0-nightpre*1.5,1.0),0.0),1.2),0.5)-0.5)*2.5*set;
        c=min((max((1.0-pow(rainpre,5.0)),0.5)-0.5)*2.5,pow(set,1.5));
        a=(0.5-abs(0.5-nt))*2.0*set*(1.0-c);
}