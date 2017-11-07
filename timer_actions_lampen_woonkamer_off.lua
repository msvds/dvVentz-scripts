return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			78
		},
	},

	execute = function(domoticz, device)
		debug = true	
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		local Time = require('Time')
		if debug == true then domoticz.log('IsDark.state = ' ..IsDark.state) end
    	local lampen_woonkamer = domoticz.groups(1)
		local Schemerlamp_deur = domoticz.devices(97)
		local Lamp_spoelb_keuken = domoticz.devices(36)	
		if (lampen_woonkamer.state == 'On') then
			lampen_woonkamer.switchOff()
			domoticz.log('lampen woonkamer uitgezet ivm zonsopgang')
		end
    	if (Schemerlamp_deur.state == 'On') then
			Schemerlamp_deur.switchOff()
			domoticz.log('Schemerlamp deur uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		end
		if (Lamp_spoelb_keuken.state == 'On') then
			Lamp_spoelb_keuken.switchOff()
			domoticz.log('Lamp spoelbak keuken uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		end
	end
}
