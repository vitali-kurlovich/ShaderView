attribute vec4 pos;
attribute vec2 uv0;

uniform mat4 modelview;

varying lowp vec2 uv;

void main(void) { 
    uv = uv0;
    gl_Position =  modelview * pos;
}