
varying lowp vec2 uv;
uniform sampler2D texture;

uniform lowp vec4 specular;
uniform mediump float specularPower;

varying lowp vec3 norm;

void main(void) {
    gl_FragColor = vec4( norm, 1);//;texture2D(texture, uv);
}