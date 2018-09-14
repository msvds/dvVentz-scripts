return {
	active = true, -- set to false to disable this script
	logging = {marker = "Switch_lights_eetkamer"},
	on = {
		devices = {'Lampen Eetkamer'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Lampen Living').state == 'On') then
			domoticz.helpers.switch_lights(domoticz,'Eetkamer','Off')
		else
			domoticz.helpers.switch_lights(domoticz,'Eetkamer','On')
		end
	end
}
