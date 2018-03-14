return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Dual Wall Switch Slaapkamer' -- Dual Wall Switch Slaapkamer
		},
	},

	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		if device.state == 'Switch 1' then
			-- Lampen aanzetten
			if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
				domoticz.devices('Dimmer bed Martijn').dimTo(20)
				--domoticz.devices('Dimmer bed Martijn').switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
			end
			if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
				domoticz.devices('Dimmer bed Suzanne').dimTo(20)
				--domoticz.devices('Dimmer bed Suzanne').switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
			end		
			domoticz.log('Nachtlampjes aangezet')
		elseif device.state == 'Switch 2' then
			-- Lampen aanzetten
			domoticz.devices('White Temp Yeelight slaapkamer').dimTo(20)
			domoticz.devices('Yeelight Dimmer slaapkamer').dimTo(50)
			domoticz.devices('Yeelight slaapkamer').switchOn().checkFirst()
			domoticz.log('Lamp slaapkamer aangezet')
		elseif (device.state == 'Both_Click') then
			-- Lampen uitzetten
			domoticz.devices('Dimmer bed Martijn').switchOff()
			domoticz.devices('Dimmer bed Suzanne').switchOff()
			domoticz.devices('Yeelight slaapkamer').switchOff().checkFirst()
			domoticz.log('Alle lampen slaapkamer uitgezet')
		end		
	end
}
