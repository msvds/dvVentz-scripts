return {
	active = true, -- set to false to disable this script
	logging = {marker = "Verwarming_beneden"},
	on = {
		devices = {'Verwarming beneden'},
	},

	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.change_heat(domoticz,'Floor1','Home')
			domoticz.devices('Verwarming beneden').setState('Off').silent()
		else
			domoticz.helpers.change_heat(domoticz,'Floor1','Away')
			domoticz.devices('Verwarming beneden').setState('Off').silent()
		end
	end
}
