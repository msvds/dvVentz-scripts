return {
	active = false, -- set to false to disable this script
	on = {
		devices = {
			25
		},
	},

	execute = function(domoticz, device)
		local lampen_woonkamer = domoticz.groups(1)
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		domoticz.log('eetkamerdeur.lua ' ..device.state.. ' and ' ..IsDark.state)		
		if (device.state == 'Open' and IsDark.state == 'On' and SomeoneHome.state == 'Off') then
			if (lampen_woonkamer.state == 'Off') then
				lampen_woonkamer.switchOn()
				domoticz.log('Eetkamerdeur open terwijl het donker is -> Nachtlampjes aangezet')
			end		
		end
	end
}
