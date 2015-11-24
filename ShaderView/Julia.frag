varying lowp vec2 UV0;

#define iter 200.0 // Iterations
#define zoom   1.0 // Zoom

void main(void)
{
    highp vec3 colour = vec3(1.0);
    highp vec2 c = vec2(-0.4,0.6);
    
    highp vec2 uv =  UV0.xy;
    highp vec2 z =  vec2(1.0 - 2.0 * uv/zoom);
    
    for(highp float i= 0.0; i<iter; i++)
    {
        // z = z^2 + c
        // z^2 = (a^2 - b^2 + 2abi)
        z = vec2(z.x*z.x-z.y*z.y, 2.0*z.x*z.y)+c;
        
        if (z.x * z.x + z.y * z.y > 4.0) {
            colour = vec3(i/iter * 0.4, i/iter  * 0.6, i/iter);
            break;
        }
    }
    
    gl_FragColor = vec4(3.0*colour*vec3(UV0.xy * 2.0,1)+vec3(0.07, 0.07, 0.07),1.0);
    
}