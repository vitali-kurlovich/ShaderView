
varying lowp vec2 uv;
uniform sampler2D texture;

void main(void) {
    gl_FragColor =   texture2D(texture, uv);
}