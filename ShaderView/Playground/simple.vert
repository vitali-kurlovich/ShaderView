attribute vec4 pos;
attribute vec2 uv0;
attribute vec3 normal;

uniform mat4 projection;

uniform mat4 modelview;
uniform mat4 invmodelview;

varying lowp vec2 uv;
varying lowp vec3 norm;

void main(void) {

    uv = uv0;
    norm = normalize(invmodelview * vec4(normal.xyz, 0)).xyz;
    gl_Position =  projection * modelview * pos;
}