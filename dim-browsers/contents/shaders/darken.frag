uniform sampler2D tex;
uniform float darkenFactor;

void main() {
    vec4 color = texture2D(tex, gl_TexCoord[0].st);
    gl_FragColor = vec4(color.rgb * darkenFactor, color.a);
}
