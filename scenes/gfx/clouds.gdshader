shader_type canvas_item;

uniform sampler2D darkclouds1 : repeat_enable, filter_nearest;
uniform sampler2D darkclouds2 : repeat_enable, filter_nearest;
uniform sampler2D darkclouds3 : repeat_enable, filter_nearest;
varying vec2 worldUV;
const float timeRollover = 3600.0;
const float timeDiv = 8.0;

void vertex() {
	worldUV = (MODEL_MATRIX*vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 noiseCorrect = vec2(1.0,1.0)/vec2(textureSize(darkclouds1, 0).xy);
	vec2 wuv = vec2(worldUV.x*noiseCorrect.x, worldUV.y*noiseCorrect.y);
	float v1 = texture(darkclouds1, vec2(wuv.x + TIME/(50.0*timeDiv),
										 wuv.y + TIME/(25.0*timeDiv))).x;
	float v2 = texture(darkclouds1, vec2(wuv.x*2.0 - TIME/(25.0*timeDiv),
										 wuv.y*2.0 - TIME/(50.0*timeDiv))).x;
	float v3 = texture(darkclouds3, vec2(wuv.x*2.0 + TIME/(15.0*timeDiv),
										 wuv.y*2.0 + TIME/(60.0*timeDiv))).x;
	float v4 = texture(darkclouds3, vec2(wuv.x - TIME/(100.0*timeDiv),
										 wuv.y - TIME/(200.0*timeDiv))).x;
	float vB1 = texture(darkclouds2, vec2(wuv.x*3.0 - TIME/(15.0*timeDiv) + cos(TIME/(1.0*timeDiv) + wuv.y*10.0)/10.0,
										  wuv.y*3.0 + TIME/(60.0*timeDiv) + sin(TIME/(1.0*timeDiv) + wuv.x*10.0)/10.0)).x;
	float vB2 = texture(darkclouds1, vec2(wuv.x*3.0 + TIME/(60.0*timeDiv),
										  wuv.y*3.0 - TIME/(20.0*timeDiv))).x;
	COLOR = vec4(1.0,1.0,1.0, (v1-v2 + clamp(v3-v4,0.0,1.0) + clamp(vB1-vB2,0.0,1.0))*2.0);
}
