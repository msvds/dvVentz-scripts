return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Suzanne smartphone',
			'Martijn smartphone'
		},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('SomeoneHome') == 'Off' and (domoticz.devices('Suzanne smartphone') == 'On' or domoticz.devices('Martijn smartphone') == 'On')) then
			domoticz.devices('SomeoneHome').switchOn()
		elseif (domoticz.devices('SomeoneHome') == 'On' and (domoticz.devices('Suzanne smartphone') == 'Of' and domoticz.devices('Martijn smartphone') == 'Off')) then
			domoticz.devices('SomeoneHome').switchOff()
		end		
	end
}
