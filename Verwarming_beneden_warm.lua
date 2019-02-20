return {
	active = true, -- set to false to disable this script
	logging = {marker = "Verwarming_beneden_warm"},
	on = {
		devices = {'Verwarming beneden warm'},
	},

	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.change_heat(domoticz,'Floor1','Comfort')
			domoticz.devices('Verwarming beneden warm').setState('Off').silent()
		else
			domoticz.helpers.change_heat(domoticz,'Floor1','Away')
			domoticz.devices('Verwarming beneden warm').setState('Off').silent()
		end
	end
}
