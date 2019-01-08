return {
	active = true, -- set to false to disable this script
	logging = {marker = "Verwarming_badkamer"},
	on = {
		devices = {'Verwarming badkamer'},
	},

	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.change_heat(domoticz,'Badkamer','Away')
		else
			domoticz.helpers.change_heat(domoticz,'Badkamer','Comfort')
		end
	end
}
