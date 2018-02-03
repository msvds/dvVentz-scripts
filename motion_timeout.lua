-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		local NM_timeout_floor1 = 30
		local NM_timeout_floor2 = 10
		local NM_timeout_kamerLars = 30
		local Time = require('Time')
		--local MediaCenter = domoticz.devices(11)
		--local Televisie = domoticz.devices(7)
		--local Televisie_lage_resolutie = domoticz.devices(9)
		debug = true
		--domoticz.log('domoticz.globalData.NMC_Floor2 = ' ..domoticz.globalData.NMC_Floor2)
		--domoticz.log('NM_timeout_floor2 = ' ..NM_timeout_floor2)
		--domoticz.log('domoticz.devices('Lamp hal boven').state = ' ..domoticz.devices('Lamp hal boven').state)
		--Do something when no movement timeout is reached
		if (domoticz.globalData.NMC_Floor1 > NM_timeout_floor1) then
			--if (domoticz.devices('Sony TV').state == 'Off') then
			--if (MediaCenter.state == 'Off') then		
			if (domoticz.groups('Lampen woonkamer').state == 'Off') then domoticz.log('No movement floor1 timeout is reached -> lampen woonkamer uit gezet', domoticz.LOG_INFO) end
			domoticz.groups('Lampen woonkamer').switchOff().checkFirst()
			domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst()
			domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst()
			domoticz.devices('Schemerlamp deur').switchOff().checkFirst()
			domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst()
		end		
		if (domoticz.globalData.NMC_Floor2 > NM_timeout_floor2) then
			if (domoticz.devices('Lamp hal boven').state == 'On') then
				domoticz.devices('Lamp hal boven').switchOff()
				domoticz.devices('Yeelight Slaapkamer').switchOff().checkFirst()				
				domoticz.log('No movement floor2 timeout is reached -> lamp hal boven uitgezet')
			end
			if (domoticz.devices('Dimmer bed Martijn').state == 'On' ) then
				domoticz.devices('Dimmer bed Martijn').switchOff()
				domoticz.log('No movement floor2 timeout is reached -> dimmer martijn slaapkamer uitgezet')
			end
			if (domoticz.devices('Dimmer bed Suzanne').state == 'On') then
				domoticz.devices('Dimmer bed Suzanne').switchOff()
				domoticz.log('No movement floor2 timeout is reached -> dimmer suzanne slaapkamer uitgezet')
			end
		end
		if (domoticz.globalData.NMC_PIR_kamerLars > NM_timeout_kamerLars) then
			if (domoticz.devices('Roomlars-Stat').SetPoint ~= '10') then
				domoticz.devices('Roomlars-Stat').updateSetPoint(10)
				domoticz.log('No movement kamer Lars timeout is reached -> verwarming Lars naar 10 graden gezet')
				--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
				--domoticz.devices('Toon Scenes').switchSelector(30)
				--domoticz.log('Toon Scenes teruggezet op Home (30) door beweging timeout in kamer Lars de verwarming daar is uitgezet')
			end
		end
	end
}
