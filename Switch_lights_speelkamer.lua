return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_speelkamer"},
	on = {
		devices = {'Lampen Speelkamer'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Lampen Speelkamer').state == 'On') then
			domoticz.helpers.switch_lights(domoticz,'Speelkamer','Off')
		else
			domoticz.helpers.switch_lights(domoticz,'Speelkamer','On')
		end
	end
}
