shader_type canvas_item;

//varying vec2 worldUV;
uniform sampler2D img1 : repeat_enable, filter_nearest;
uniform float dir;

vec2 toPolar(vec2 cartesian) { //altered from https://godotshaders.com/shader/polar-coordinate-black-hole/
	float dist = log(length(cartesian));
	float angle = atan(cartesian.y, cartesian.x) + PI;
	return vec2(angle / (2.0 * PI), dist);
}

//void vertex() {
	//worldUV = (MODEL_MATRIX*vec4(VERTEX, 0.0, 1.0)).xy;
	//worldUV.x = worldUV.x - 1152.0/2.0;
	//worldUV.y = worldUV.y - 648.0/2.0;
//}

void fragment() {
	vec2 wuv = vec2(UV.x - 1152.0/8.0, UV.y - 648.0/8.0);
	vec2 polarUV = toPolar(wuv);
	COLOR.rgb = texture(img1, vec2(polarUV.x, polarUV.y - polarUV.x - dir*TIME*4.0)).rgb;
}