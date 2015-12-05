attribute vec4 pos;
attribute vec2 uv0;
attribute vec3 normal;

uniform mat4 modelview;

varying lowp vec2 uv;
varying lowp vec3 norm;
void main(void) { 
    uv = uv0;
    norm = normal;
    gl_Position =  modelview * pos;
}