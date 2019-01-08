return {
	active = true, -- set to false to disable this script
	logging = {marker = "Verwarming_beneden"},
	on = {
		devices = {'Verwarming beneden'},
	},

	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.change_heat(domoticz,'Floor1','Away')
		else
			domoticz.helpers.change_heat(domoticz,'Floor1','Home')
		end
	end
}
