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
		--domoticz.log('domoticz.globalData.NMC_Floor2 = ' ..domoticz.globalData.NMC_Floor2)
		--domoticz.log('NM_timeout_floor2 = ' ..NM_timeout_floor2)
		--domoticz.log('lamp_hal_boven.state = ' ..lamp_hal_boven.state)
		--Do something when no movement timeout is reached
		if (domoticz.globalData.NMC_Floor1 > NM_timeout_floor1) then
			if (MediaCenter.state == 'Off' and Televisie.state == 'Off' and Televisie_lage_resolutie.state == 'Off') then
				if (lampen_woonkamer.state == 'On') then
					lampen_woonkamer.switchOff()
					domoticz.log('No movement floor1 timeout is reached -> lampen woonkamer uit gezet', domoticz.LOG_INFO)
				elseif (Schemerlamp_deur.state == 'On') then
					Schemerlamp_deur.switchOff()
					domoticz.log('No movement floor1 timeout is reached -> Schemerlamp deur uit gezet', domoticz.LOG_INFO)
				elseif (Lamp_spoelb_keuken.state == 'On') then
					Lamp_spoelb_keuken.switchOff()
					domoticz.log('No movement floor1 timeout is reached -> lamp spoelbak keuken uit gezet', domoticz.LOG_INFO)
				end
			end
		end		
		if (domoticz.globalData.NMC_Floor2 > NM_timeout_floor2) then
			if (lamp_hal_boven.state == 'On') then
				lamp_hal_boven.switchOff()
				domoticz.log('No movement floor2 timeout is reached -> lamp hal boven uitgezet')
			end
			if (dimmer_bed_martijn.state == 'On' ) then
				dimmer_bed_martijn.switchOff()
				domoticz.log('No movement floor2 timeout is reached -> dimmer martijn slaapkamer uitgezet')
			end
			if (dimmer_bed_suzanne.state == 'On') then
				dimmer_bed_suzanne.switchOff()
				domoticz.log('No movement floor2 timeout is reached -> dimmer suzanne slaapkamer uitgezet')
			end
		end		
	end
}
