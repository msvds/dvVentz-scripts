
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw2'
		},
	},

	execute = function(domoticz, device)
	    local lamp_logeerkamer = domoticz.devices('Lampen logeerkamer')
		domoticz.log(device.state)
		if (device.state == 'Double Click') then
			lamp_logeerkamer.switchOff()
			domoticz.log('Lights logeerkamer turned off')
		elseif (device.state == 'Click') then
			if lamp_logeerkamer.state == 'On' then
			    lamp_logeerkamer.switchOff()
			    domoticz.log('Lights logeerkamer turned off')    
			elseif lamp_logeerkamer.state == 'Off' then
			    lamp_logeerkamer.switchOn()
			    domoticz.log('Lights logeerkamer turned on')
			end
		end
	end
}
