-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = true,
	devices = {
			91
		},
	execute = function(domoticz, device)
		debug = true
		domoticz.log('Testswitch', domoticz.LOG_INFO)
		local testswitch = domoticz.devices(91)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		if (dimmer_bed_martijn.state == 'Off') then
			--dimmer_bed_martijn.switchSelector(6)
			dimmer_bed_martijn.switchOn()
			domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
		end
		if (dimmer_bed_suzanne.state == 'Off') then
			--dimmer_bed_suzanne.switchSelector(6)
			dimmer_bed_suzanne.switchOn()
			domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
		end
	end
}
