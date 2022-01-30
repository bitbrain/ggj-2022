shader_type canvas_item;

uniform bool enabled = false;

void fragment() {
	vec4 texColor = texture(TEXTURE, UV);
	if (enabled) {
		COLOR = vec4(1.0, 1.0, 1.0, texColor.a);
	} else {
		COLOR = texColor;
	}
}