return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_living"},
	on = {
		devices = {'Lampen Living'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Lampen Living').state == 'Off') then
			domoticz.helpers.switch_lights(domoticz,'Living','On')
		else
			domoticz.helpers.switch_lights(domoticz,'Living','Off')
		end
	end
}
