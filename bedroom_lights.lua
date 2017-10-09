return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			153
		},
	},

	execute = function(domoticz, device)
		local dimmer_bed_martijn = domoticz.devices(149)
		local dimmer_bed_suzanne = domoticz.devices(150)
		local IsDark = domoticz.devices(78)
		domoticz.log('bedroom_lights.lua ' ..device.state.. ' and ' ..IsDark.state)
		if (device.state == 'Open' and IsDark.state == 'On') then
			dimmer_bed_martijn.switchOn()
			dimmer_bed_suzanne.switchOn()  
			domoticz.log('Slaapkamerdeur open terwijl het donker is -> Nachtlampjes aangezet')
		end
	end
}
