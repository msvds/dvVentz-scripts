return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_keuken"},
	on = {
		devices = {'Lampen Keuken'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Lampen Keuken').state == 'On') then
			domoticz.helpers.switch_lights(domoticz,'Keuken','Off')
		else
			domoticz.helpers.switch_lights(domoticz,'Keuken','On')
		end
	end
}
