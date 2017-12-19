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
			if (domoticz.devices('Sony TV').state == 'Off') then
			--if (MediaCenter.state == 'Off') then	
				if (domoticz.groups('Lampen woonkamer').state == 'On') then
					domoticz.groups('Lampen woonkamer').switchOff()
					domoticz.log('No movement floor1 timeout is reached -> lampen woonkamer uit gezet', domoticz.LOG_INFO)
				elseif (domoticz.devices('Schemerlamp deur').state == 'On') then
					domoticz.devices('Schemerlamp deur').switchOff()
					domoticz.log('No movement floor1 timeout is reached -> Schemerlamp deur uit gezet', domoticz.LOG_INFO)
				elseif (domoticz.devices('Lamp spoelb keuken').state == 'On') then
					domoticz.devices('Lamp spoelb keuken').switchOff()
					domoticz.log('No movement floor1 timeout is reached -> lamp spoelbak keuken uit gezet', domoticz.LOG_INFO)
				end
			end
		end		
		if (domoticz.globalData.NMC_Floor2 > NM_timeout_floor2) then
			if (domoticz.devices('Lamp hal boven').state == 'On') then
				domoticz.devices('Lamp hal boven').switchOff()
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
			if (domoticz.devices('Roomlars-Stat').SetPoint == '21') then
				domoticz.devices('Roomlars-Stat').updateSetPoint(15)
				domoticz.log('No movement kamer Lars timeout is reached -> verwarming Lars naar 15 graden gezet')
			end
		end
	end
}
