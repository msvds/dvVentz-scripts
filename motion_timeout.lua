-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	logging = {marker = "motion_timeout"},
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		--timeout nacht
		local NM_timeout_floor1 = 5
		local NM_timeout_floor2 = 5
		local NM_timeout_kamerLars = 5
		local NM_timeout_kamerNienke = 5
		if (domoticz.time.matchesRule('at 7:00-23:30')) then		
			if (domoticz.devices('Status').state ~= 50) then
				--timeout dag
				NM_timeout_floor1 = 45
				NM_timeout_floor2 = 10
				NM_timeout_kamerLars = 5
				NM_timeout_kamerNienke = 5
			else
				--timeout dag met gasten
				NM_timeout_floor1 = 90
				NM_timeout_floor2 = 30
				NM_timeout_kamerLars = 5
				NM_timeout_kamerNienke = 5
			end		
		end	
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
			domoticz.helpers.switch_lights(domoticz,'Floor1','Off',3)
			-- Gateway status resetten
			domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
			domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
			--domoticz.log('Gateway status gereset',domoticz.LOG_INFO)
		end		
		if (domoticz.globalData.NMC_Floor2 > NM_timeout_floor2) then
			domoticz.helpers.switch_lights(domoticz,'Floor2','Off',10)
			-- Gateway status resetten
			domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
			domoticz.devices('Gateway light hal boven').switchSelector(0)--off
			--domoticz.log('Gateway status gereset',domoticz.LOG_INFO)
		end
		if (domoticz.globalData.NMC_PIR_kamerLars > NM_timeout_kamerLars) then
			if (domoticz.devices('eQ-3 - Roomlars-Rad - Thermostat').setPoint ~= '10') then
				domoticz.helpers.change_heat(domoticz,'KamerLars','Away',0)
			end
		end
		if (domoticz.globalData.NMC_PIR_kamerNienke > NM_timeout_kamerNienke) then
			if (domoticz.devices('eQ-3 - Roomnienke-Rad - Thermostat').setPoint ~= '10') then
				domoticz.helpers.change_heat(domoticz,'KamerNienke','Away',0)
			end
		end
	end
}
