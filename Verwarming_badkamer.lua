return {
	active = true, -- set to false to disable this script
	logging = {marker = "Verwarming_badkamer"},
	on = {
		devices = {'Verwarming badkamer'},
	},

	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.change_heat(domoticz,'Badkamer','Comfort')
			domoticz.devices('Verwarming badkamer').setState('Off').silent()
		else
			domoticz.helpers.change_heat(domoticz,'Badkamer','Away')
			domoticz.devices('Verwarming badkamer').setState('Off').silent()
		end
	end
}
