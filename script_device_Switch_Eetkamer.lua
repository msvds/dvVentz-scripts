return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Single Wall Switch Lampen Eetkamer'
		},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Yeelight eetkamer 1').state == 'On' or omoticz.devices('Yeelight eetkamer 2').state == 'On') then
			domoticz.helpers.switch_lights(domoticz,'Eetkamer','Off')	
		end
		if (domoticz.devices('Yeelight eetkamer 1').state == 'Off' or omoticz.devices('Yeelight eetkamer 2').state == 'Off') then
			domoticz.helpers.switch_lights(domoticz,'Eetkamer','On')
		end
	end
}
