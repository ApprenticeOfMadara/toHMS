local function toHMS(s, twelveHourFormat) -- Takes seconds as first param and bool as second
	if not twelveHourFormat then
		return string.format("%02i:%02i:%02i", s/3600, s/60%60, s%60)
  end
	
	local hours = s/3600
	local over12 = hours > 12
		
	hours = (over12 and hours - 12) or hours
		
	return string.format("%02i:%02i:%02i", hours, s/60%60, s%60) .. (over12 and " PM" or " AM")
end
