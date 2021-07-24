--[[
	@ ApprenticeOfMadara, 2021
 	
	Designed as a function. Very simple to use.
	e.g:
	local toHMS = require(pathToModule)
	
	local timeIn24HrFormat = toHMSFromHours(43200)
	local timeIn12HrFormat = toHMSFromHours(43200, true)
	print(timeIn24HrFormat) -->> 12:00:00
	print(timeIn12HrFormat) -->> 12:00:00 PM

	[excuse long variable names]
]]

local function toHMS(secs, twelveHourFormat) -- Takes seconds as first param and bool as second
	secs = math.round(secs) % 86400
	
	if not twelveHourFormat then
		return string.format("%02i:%02i:%02i", secs/3600, secs/60%60, secs%60)
	end

	local hours = secs/3600
	local over12 = hours > 12

	hours = (over12 and hours - 12) or hours
	over12 = hours >= 12

	return string.format("%02i:%02i:%02i", hours, secs/60%60, secs%60) .. (over12 and " PM" or " AM")
end
