shader_type canvas_item;

uniform float offU;
uniform float offB;
uniform vec2 uvP;
uniform vec2 uvS;
uniform vec2 p;
uniform float rangeLeft;
uniform float rangeRight;
uniform vec4 innerColor : source_color;

bool colorApproxEqual(vec4 colorA, vec4 colorB) {
	return colorA.r > colorB.r - 0.001 && colorA.r < colorB.r + 0.001
	&& colorA.g > colorB.g - 0.001 && colorA.g < colorB.g + 0.001
	&& colorA.b > colorB.b - 0.001 && colorA.b < colorB.b + 0.001
	&& colorA.a > colorB.a - 0.001 && colorA.a < colorB.a + 0.001;
}
bool alphaApproxEqual(float alphaA, float alphaB) {
	return alphaA > alphaB - 0.001 && alphaA < alphaB + 0.001;
}

vec4 crop(sampler2D tex, vec2 uv, vec2 c1, vec2 c2) {
	vec2 _uv = vec2(uv.x,uv.y);
	float px = p.x/uvS.x;
	float py = p.y/uvS.y;
	if(_uv.x < c1.x + px*0.1) _uv.x = c1.x + px*0.1;
	if(c2.x - px*0.1 < _uv.x) _uv.x = c2.x - px*0.1;
	if(_uv.y < c1.y + py*0.1) _uv.y = c1.y + py*0.1;
	if(c2.y - py*0.1 < _uv.y) _uv.y = c2.y - py*0.1;
	return texture(tex, _uv);
}

void fragment() {
	float x = (UV.x - uvP.x) / uvS.x;
	float y = (UV.y - uvP.y) / uvS.y;
	float px = p.x/uvS.x;
	float py = p.y/uvS.y;
	float rL = 0.5 - (rangeLeft*px);
	float rR = 0.5 + (rangeRight*px); //0 -> rL, 1 -> rR
	vec4 colorU = crop(TEXTURE,
						vec2(x, y - py*16.0 - sin(((x - rL)/(rR - rL))*PI)*offU*(rR - rL))*uvS + uvP,
						vec2(uvP.x, uvP.y),
						vec2(uvP.x + uvS.x, uvP.y + uvS.y*0.5));
	vec4 colorB = crop(TEXTURE,
						vec2(x, y + py*16.0 - sin(((x - rL)/(rR - rL))*PI)*offB*(rR - rL))*uvS + uvP,
						vec2(uvP.x, uvP.y + uvS.y*0.5),
						vec2(uvP.x + uvS.x, uvP.y + uvS.y*1.0));
	vec4 colorI = crop(TEXTURE,
						vec2(x + px*32.0, y - px*8.0)*uvS + uvP,
						vec2(uvP.x + uvS.x*1.0, uvP.y),
						vec2(uvP.x + uvS.x*2.0, uvP.y + uvS.y*0.5));
	COLOR = vec4(0.0,0.0,0.0,0.0);
	if(!colorApproxEqual(colorU, innerColor) && colorApproxEqual(colorB, innerColor)) COLOR = colorI;
	if(!alphaApproxEqual(colorB.a, 0.0) && !colorApproxEqual(colorB, innerColor)) COLOR = colorB;
	if(colorApproxEqual(COLOR, innerColor)) COLOR.a = 0.0;
	if(!alphaApproxEqual(colorU.a, 0.0)) COLOR = colorU;
	if(colorApproxEqual(COLOR, innerColor)) COLOR.a = 0.0;
	//COLOR = colorB;
}