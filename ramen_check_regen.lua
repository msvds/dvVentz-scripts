-- Send a warning when a window is open and it's going to rain
return {
	active = true,
	on = {
		['timer'] = 'every minute',
	},
	execute = function(domoticz)
		local RainExpectedLevels = domoticz.devices[93]
		if (RainExpectedLevels.state ~= 'Droog') then
			if (domoticz.devices('Dakraam slaapkamer').state == 'Open') then
			   domoticz.notify('Dakraam open bij regen','Het dakraam in de slaapkamer staat open en het gaat regenen',domoticz.PRIORITY_HIGH)
			elseif (domoticz.devices('Zolderdakraam achter').state == 'Open') then
			   domoticz.notify('Dakraam open bij regen','Het dakraam op zolder achter staat open en het gaat regenen',domoticz.PRIORITY_HIGH)
			end 
		end
	end
}
