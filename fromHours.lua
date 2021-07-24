local function toHMSFromHours(hours, twelveHourFormat) -- hours as first param and bool as second (twelveHourFormat)
		local hours, mins, seconds = math.modf(hours)
  
		local over12
		if twelveHourFormat then
			over12 = hours > 12
			hours = (over12 and hours - 12) or hours
		end
		
		mins *= 60

		mins, seconds = math.modf(mins)
		seconds *= 60
		seconds = math.round(seconds)

		if seconds >= 60 then -- needed for a few edge-cases, not sure exactly why (e.g. try X.1)
			seconds -= 60
			mins += 1
		end

		return string.format("%02i:%02i:%02i", hours, mins, seconds) .. (twelveHourFormat and (over12 and " PM" or " AM") or "")
end
