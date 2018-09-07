return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_living"},
	on = {
		devices = {'Lampen Living'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Lampen Living').state == 'On') then
			domoticz.helpers.switch_lights(domoticz,'Living','Off')
		else
			domoticz.helpers.switch_lights(domoticz,'Living','On')
		end
	end
}