-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		local NM_timeout_floor1 = 30
		local NM_timeout_floor2 = 10
		local Open_timeout = 10
		local Time = require('Time')
		local MediaCenter = domoticz.devices(11)
		local Televisie = domoticz.devices(7)
		local Televisie_lage_resolutie = domoticz.devices(9)
		local lampen_woonkamer = domoticz.groups(1)
		local lamp_hal_boven = domoticz.devices(151)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		debug = true
		
		--Do something when no movement timeout is reached
		if (domoticz.globalData.NMC_Floor1 > NM_timeout_floor1) then
			if (MediaCenter.state == 'Off' and Televisie.state == 'Off' and Televisie_lage_resolutie.state == 'Off') then
				if (lampen_woonkamer.state == 'On') then
					lampen_woonkamer.switchOff()
					domoticz.log('No movement floor1 timeout is reached -> lampen woonkamer uit gezet')
				end
			end
		end		
		if (domoticz.globalData.NMC_Floor2 > NM_timeout_floor2) then
			if (lampen_woonkamer.state == 'On') then
				lamp_hal_boven.switchOff()
				dimmer_bed_martijn.switchOff()
				dimmer_bed_suzanne.switchOff()
				domoticz.log('No movement floor2 timeout is reached -> lamp hal boven en dimmers slaapkamer uitgezet')
			end
		end		
	end
}
