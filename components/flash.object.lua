function flashObj(obj, repetitions, flash_duration, interval, color)
	--[[
		Simple function to flash an object a few times
	--]]
	local r = repetitions or 5
	local d = flash_duration or 0.15
	local i = interval or 0.15
	local c = color or {0.2, 1, 0}
	local function flash()
		obj.highlightOn(c, d)
	end
	for f=0,r-1 do
		local t = f*(d+i)
		Wait.time(flash, t)
	end
end
