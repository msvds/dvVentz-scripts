return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_living"},
	on = {
		devices = {'Lampen Living'},
	},

	execute = function(domoticz, device)
		domoticz.log(domoticz.devices('Lampen Living').state)
		if (domoticz.devices('Lampen Living').state == 'Off') then
			domoticz.log('1a')
			domoticz.helpers.switch_lights(domoticz,'Living','On')
			domoticz.log('1b')
		else
			domoticz.log('2a')
			domoticz.helpers.switch_lights(domoticz,'Living','Off')
			domoticz.log('2b')
		end
	end
}
