
varying lowp vec2 uv;
uniform sampler2D texture;

uniform mediump float specularPower;

varying mediump vec3 norm;
varying mediump vec3 vertex_to_light;
varying mediump vec3 vertex_to_camera;

void main(void) {

    lowp vec4  diffuse_color = texture2D(texture, uv);
    lowp vec4 specular_color = vec4(1.0, 1.0, 1.0, 1.0);
    
    lowp vec3 halfvector = normalize(vertex_to_light + vertex_to_camera);
    
    lowp vec3  n_vertex_to_light = normalize(vertex_to_light);
    lowp float diffuse = max (dot (norm, n_vertex_to_light), 0.0);
    
    lowp vec3 n_vertex_to_camera = normalize(vertex_to_camera);
    mediump vec3 ref = reflect(-n_vertex_to_light, norm);
    
    mediump float specular = max(dot (norm, halfvector), 0.0);
    specular = pow(specular, specularPower);
    
    gl_FragColor = vec4( diffuse * diffuse_color.rgb + specular * specular_color.rgb, 1);
}