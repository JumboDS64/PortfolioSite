shader_type canvas_item;

uniform vec4 color : source_color;

bool colorApproxEqual(vec4 colorA, vec4 colorB) {
	return colorA.r > colorB.r - 0.001 && colorA.r < colorB.r + 0.001
	&& colorA.g > colorB.g - 0.001 && colorA.g < colorB.g + 0.001
	&& colorA.b > colorB.b - 0.001 && colorA.b < colorB.b + 0.001
	&& colorA.a > colorB.a - 0.001 && colorA.a < colorB.a + 0.001;
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if(colorApproxEqual(COLOR, color)) {
		COLOR.a = 0.0;
	}
}
