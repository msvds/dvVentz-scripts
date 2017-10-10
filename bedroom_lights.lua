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
		local Time = require('Time')
		local t = Time('2016-12-12 07:35:00')
		domoticz.log('bedroom_lights.lua ' ..device.state.. ' and ' ..IsDark.state)		
		if (t.matchesRule('at 19:00-00:30') and device.state == 'Open' and IsDark.state == 'On') then
			-- between 19:00 and 0:30 then next day
			if (dimmer_bed_martijn.state == 'Off') then
				dimmer_bed_martijn.switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is -> Nachtlampjes aangezet')
			end
			if (dimmer_bed_martijn.state == 'Off') then
				dimmer_bed_suzanne.switchOn()
				domoticz.log('Slaapkamerdeur open terwijl het donker is -> Nachtlampjes aangezet')
			end
			
		end
	end
}
