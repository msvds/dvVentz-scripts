return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Gashaard'
		},
	},
	execute = function(domoticz, device)
		if (device.state == 'Run Up') then			
			domoticz.log('Huidige setpoint is '.. domoticz.helpers.currentSetpoint(domoticz))
			domoticz.helpers.changeSetPoint(domoticz,'10','omdat de gashaard aangezet is',false,domoticz.helpers.currentSetpoint(domoticz))
			--currentSetpoint = domoticz.helpers.currentSetpoint(domoticz)
			--domoticz.log('Huidige setpoint is '.. domoticz.helpers.currentSetpoint(domoticz))
		end
	end
}
