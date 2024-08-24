return {
	black = 0x00000000,
	white = 0xffc4c4c3,
	red = 0xfff8f9f9,
	green = 0xffc4c4c4,
	blue = 0xffc4c4c3,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	grey = 0xffc4c4c3,
	transparent = 0x00000000,

	bar = {
		bg = 0x00f8f9f9,
		border = 0x00000000,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff01fdfe,
	},
	bg1 = 0x11000000,
	bg2 = 0x00000000,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
