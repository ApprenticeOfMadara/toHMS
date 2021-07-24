local function formatTo12(hours)
	local over12 = hours > 12
	hours = (over12 and hours - 12) or hours
	over12 = hours >= 12
	
	return hours, over12
end

local function shift(secs, mins, hours, format)
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

-- Main function
local function toHMSFromHours(hours, twelveHourFormat) -- hours as first param and bool as second
	hours = math.floor(hours * 10^5)/10^5
	
	local hours, mins, secs = math.modf(hours)
	hours %= 24
	mins *= 60

	local over12
	hours, over12 = formatTo12(hours)

	mins, secs = math.modf(mins)
	secs = math.round(secs * 60)

	if secs >= 60 then
		secs, mins, hours, over12 = shift(secs, mins, hours, twelveHourFormat)
	end

	return string.format("%02i:%02i:%02i", hours, mins, secs) .. (twelveHourFormat and (over12 and " PM" or " AM") or "")
end
