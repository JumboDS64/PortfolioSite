shader_type canvas_item;

//varying vec2 worldUV;
uniform sampler2D img1 : repeat_enable, filter_nearest;
uniform sampler2D img2 : repeat_enable, filter_nearest;
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
	float DT = dir*TIME;
	vec2 wuv = vec2(UV.x - 1152.0/8.0, UV.y - 648.0/8.0);
	vec2 puv = toPolar(wuv);
	vec4 img1_ = texture(img1, vec2(puv.x + sin(puv.y*0.33-DT)*0.2 + cos(puv.y*0.5-DT)*0.1, puv.y/8.0 - DT*0.5));
	vec2 img2p = vec2(puv.x + sin(puv.y*0.5+DT)*0.1 + cos(puv.y*0.22+DT)*0.2, puv.y/16.0 - DT*0.5);
	vec4 img2_ = texture(img2, img2p);
	//COLOR = mix(img1_, img2s_, img2s_.a) + img2_;
	COLOR.rgb = (img1_ + img2_).rgb;
}