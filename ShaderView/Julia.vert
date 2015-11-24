attribute vec2 Position;

varying vec2 UV0;

void main(void) {
    UV0 = (Position + 1.0) / 2.0;
    gl_Position =  vec4(Position.xy, 0, 1);
}


