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
			domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
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
			domoticz.devices('Lamp hal boven').switchOn().checkFirst()
			domoticz.devices('White Temp Yeelight slaapkamer').dimTo(20)
			domoticz.devices('Yeelight Dimmer slaapkamer').dimTo(50)
			domoticz.devices('Yeelight slaapkamer').switchOn().checkFirst()
			domoticz.log('Lights turned on')
		elseif device.state == 'Switch 2' then
		elseif (device.state == 'Both_Click') then
		end		
	end
}
