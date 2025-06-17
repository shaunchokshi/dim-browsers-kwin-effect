uniform sampler2D tex;
uniform float darkenFactor; // e.g. 0.7 = 70% of original brightness

void main() {
    vec4 color = texture2D(tex, gl_TexCoord[0].st);
    gl_FragColor = vec4(color.rgb * darkenFactor, color.a);
}
