return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw2_chillkamer' -- Switch chill kamer
		},
	},

	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		if device.state == 'Double Click' then
			-- Lampen uitzetten
			domoticz.devices('Lampen logeerkamer').switchOff().checkFirst()
			domoticz.log('Lights logeerkamer turned off',domoticz.LOG_INFO)
		elseif device.state == 'Click' then
			-- Lampen switchen
			if domoticz.devices('Lampen logeerkamer').state == 'On' then
			    domoticz.devices('Lampen logeerkamer').switchOff().checkFirst()
			    domoticz.log('Lights logeerkamer turned off',domoticz.LOG_INFO)   
			elseif domoticz.devices('Lampen logeerkamer').state == 'Off' then
			    domoticz.devices('Lampen logeerkamer').switchOn().checkFirst()
			    domoticz.log('Lights logeerkamer turned on',domoticz.LOG_INFO)
			end
		elseif (device.state == 'Long Click') then
			-- Lampen aanzetten
			domoticz.devices('Lampen logeerkamer').switchOn().checkFirst()
			domoticz.log('Lights logeerkamer turned on',domoticz.LOG_INFO)
		end		
	end
}
