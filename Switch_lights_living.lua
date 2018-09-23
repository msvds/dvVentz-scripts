return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_living"},
	on = {
		devices = {'Lampen Living'},
	},

	execute = function(domoticz, device)
		domoticz.log(domoticz.devices('Lampen Living').state)
		if (domoticz.devices('Lampen Living').state == 'Off') then
			domoticz.helpers.switch_lights(domoticz,'Living','On')
			domoticz.log('1')
		else
			domoticz.helpers.switch_lights(domoticz,'Living','Off')
			domoticz.log('2')
		end
	end
}
