return {
	black = 0x00000000,
	white = 0xff01fdfe,
	red = 0xffc3191a,
	green = 0xff01fdfe,
	blue = 0xff01fdfe,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	grey = 0xff01fdfe,
	transparent = 0x00000000,

	bar = {
		bg = 0x00000000,
		border = 0x00000000,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff01fdfe,
	},
	bg1 = 0x55000000,
	bg2 = 0x55000000,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
