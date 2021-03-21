shader_type spatial;
render_mode unshaded;

uniform sampler2D next_tx: hint_albedo;
void fragment() {
	ALBEDO = texture(next_tx, SCREEN_UV).rgb;
    
}