hsvtorgb = function(h, s, v) {
	if (s == 0)
		return format(v, v, v);

	h = ((h + 360) % 360) / 60;

	var i = Math.floor(h);
	var f = h - i;
	var p = v * (1 - s);
	var q = v * (1 - s * f);
	var t = v * (1 - s * (1 - f));

	function format(r, g, b) {
		return "rgb(" + Math.round(r * 255) + "," + Math.round(g * 255) + "," + Math.round(b * 255) + ")";
	}

	switch(i) {
	case 0:
		r = v; g = t; b = p;
		break;

	case 1:
		r = q; g = v; b = p;
		break;

	case 2:
		r = p; g = v; b = t;
		break;

	case 3:
		r = p; g = q; b = v;
		break;

	case 4:
		r = t; g = p; b = v;
		break;

	default:
		r = v; g = p; b = q;
	}

	return format(r, g, b);
};