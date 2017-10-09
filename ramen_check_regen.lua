-- Send a warning when a window is open and it's going to rain
return {
	active = true,
	on = {
		['timer'] = 'every minute',
	},
	execute = function(domoticz)
		local dakraamslaapkamer = domoticz.devices[81]
		local dakraamzolderachter = domoticz.devices[85]		
		local RainExpectedLevels = domoticz.devices[93]
		if (RainExpectedLevels.state ~= 'Droog') then
			if (dakraamslaapkamer.state == 'Open') then
			   domoticz.notify('Dakraam open bij regen','Het dakraam in de slaapkamer staat open en het gaat regenen',domoticz.PRIORITY_HIGH)
			elseif (dakraamzolderachter.state == 'Open') then
			   domoticz.notify('Dakraam open bij regen','Het dakraam op zolder achter staat open en het gaat regenen',domoticz.PRIORITY_HIGH)
			end 
		end
	end
}
