attribute vec4 pos;
attribute vec2 uv0;
attribute vec3 normal;

uniform mat4 projection;

uniform mat4 modelview;
uniform mat4 invmodelview;

uniform highp vec3 light;

varying lowp vec2 uv;
varying mediump vec3 norm;

varying mediump vec3 vertex_to_light;
varying mediump vec3 vertex_to_camera;

void main(void) {

    uv = uv0;
    norm = normalize(invmodelview * vec4(normal.xyz, 0)).xyz;
    
    vec4 vertex_modelview = modelview * pos;
    
    vertex_to_light = light - vertex_modelview.xyz;
    
    vertex_to_camera = -vertex_modelview.xyz;
    
    
    gl_Position =  projection * modelview * pos;
}