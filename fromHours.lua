--[[
	@ ApprenticeOfMadara, 2021
 	
	Designed as a module. Very simple to use.

	e.g:
	local toHMSFromHours = require(pathToModule)
	
	local formattedTimeTo24 = toHMSFromHours(13.5)
	local formattedTimeTo12 = toHMSFromHours(13.5, true)

	print(formattedTimeTo24) -->> 13:30:00
	print(formattedTimeTo12) -->> 01:30:00 AM
	
	[excuse my long variable names]
]]

local function formatTo12(hours)
	local over12 = hours > 12
	hours = (over12 and hours - 12) or hours
	over12 = hours >= 12
	
	return hours, over12
end

local function shiftNumbers(secs, mins, hours, format)
	if secs >= 60 then
		secs -= 60
		mins += 1
	end
	
	if mins >= 60 then
		mins -= 60
		hours += 1
	end
	 
	hours %= 24
	
	local over12
	hours, over12 = formatTo12(hours)
	
	return secs, mins, hours, over12
end

-- Main function returned from module
return function (hours, twelveHourFormat) -- hours as first param and bool as second
	hours = math.floor(hours * 10^5)/10^5
	
	local hours, mins, secs = math.modf(hours)
	hours %= 24
	mins *= 60

	local over12
	if twelveHourFormat then
		hours, over12 = formatTo12(hours)
	end
	
	mins, secs = math.modf(mins)
	secs = math.round(secs * 60)

	if secs >= 60 then
		secs, mins, hours, over12 = shiftNumbers(secs, mins, hours, twelveHourFormat)
	end

	return string.format("%02i:%02i:%02i", hours, mins, secs) .. (twelveHourFormat and (over12 and " PM" or " AM") or "")
end
