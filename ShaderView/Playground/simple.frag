
varying lowp vec2 uv;
uniform sampler2D texture;

varying lowp vec3 norm;

void main(void) {
    gl_FragColor = vec4( norm*0.5 + vec3(0.5), 1);//;texture2D(texture, uv);
}