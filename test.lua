return {
	active = true,
	on = {
		devices = {
			91
		},
	},
	execute = function(domoticz, device)
		debug = true
		domoticz.log('Testswitch', domoticz.LOG_INFO)
		local testswitch = domoticz.devices(91)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		if (domoticz.time.matchesRule('at 16:00-00:30')) then --and Slaapkdeur.state == 'Open'
			if (dimmer_bed_martijn.state == 'Off') then
				dimmer_bed_martijn.switchSelector(25)
				--dimmer_bed_martijn.switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
			end
			if (dimmer_bed_suzanne.state == 'Off') then
				dimmer_bed_suzanne.switchSelector(25)
				--dimmer_bed_suzanne.switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
			end
		end
	end
}
