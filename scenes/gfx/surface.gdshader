shader_type canvas_item;

uniform sampler2D darksurface : repeat_enable, filter_nearest;
varying vec2 worldUV;
const float timeRollover = 3600.0;
const float timeDiv = 8.0;

void vertex() {
	worldUV = (MODEL_MATRIX*vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 noiseCorrect = vec2(1.0,1.0)/vec2(textureSize(darksurface, 0).xy);
	vec2 wuv = vec2(worldUV.x*noiseCorrect.x, worldUV.y*noiseCorrect.y);
	vec4 v1 = texture(darksurface, vec2(wuv.x + TIME/(30.0*timeDiv),
										wuv.y + TIME/(20.0*timeDiv)));
	COLOR = v1;
}
