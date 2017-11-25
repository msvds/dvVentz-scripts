return {
	active = true, -- set to false to disable this script
	on = {
		devices = {23,302
		}
	},
	execute = function(domoticz, device)
		if (domoticz.devices('Beweging woonkamer 1') == 'On' or domoticz.devices('Beweging woonkamer 2') == 'On') then
			domoticz.devices('Beweging woonkamer') == 'On'
			domoticz.log('Beweging woonkamer')
		else
			domoticz.devices('Beweging woonkamer') == 'Off'
			domoticz.log('Stop beweging woonkamer')
		end
	end
}
