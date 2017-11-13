return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw2'
		},
	},

	execute = function(domoticz, device)
		if (device.state == 'Double Click') then
			domoticz.devices('Lampen logeerkamer').switchOff()
			domoticz.log('Lights logeerkamer turned off')
		elseif (device.state == 'Click') then
			if domoticz.devices('Lampen logeerkamer').state == 'On' then
			    domoticz.devices('Lampen logeerkamer').switchOff()
			    domoticz.log('Lights logeerkamer turned off')    
			elseif domoticz.devices('Lampen logeerkamer').state == 'Off' then
			    domoticz.devices('Lampen logeerkamer').switchOn()
			    domoticz.log('Lights logeerkamer turned on')
			end
		end
	end
}
