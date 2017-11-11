return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Suzanne smartphone',
			'Martijn smartphone'
		},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('SomeoneHome').state == 'Off' and (domoticz.devices('Suzanne smartphone').state == 'On' or domoticz.devices('Martijn smartphone').state == 'On')) then
			domoticz.devices('SomeoneHome').switchOn()
		elseif (domoticz.devices('SomeoneHome').state == 'On' and (domoticz.devices('Suzanne smartphone').state == 'Of' and domoticz.devices('Martijn smartphone').state == 'Off')) then
			domoticz.devices('SomeoneHome').switchOff()
		end		
	end
}
