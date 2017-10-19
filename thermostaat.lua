return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		local temp_buiten = domoticz.devices(59)
		local Temperature_limit = '18'
		local NM_timeout = 30
		local Open_timeout = 10
		local Time = require('Time')
		debug = true
		--ToonState = '50' -- Manual
		--ToonState = '40' -- Comfort
		--ToonState = '30' -- Home
		--ToonState = '20' -- Sleep
		--ToonState = '10' -- Away
		local ToonScenesSensorName  = 'Toon Temperature' -- Sensor showing current program
		local ToonThermostatSensorName = 'Toon Thermostat' 
		local ToonIP = '192.168.178.183'
		local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)

		local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', ToonIP)))
		local ThermostatInfo = handle:read('*all')
		handle:close()

		local jsonThermostatInfo = json:decode(ThermostatInfo)

		if jsonThermostatInfo ~= nil then
			local currentSetpoint = tonumber(jsonThermostatInfo.currentSetpoint) / 100
			local currentTemperature = tonumber(jsonThermostatInfo.currentTemp) / 100
			local currentProgramState = tonumber(jsonThermostatInfo.programState)
			local currentActiveState = tonumber(jsonThermostatInfo.activeState)
			local currentNextTime = jsonThermostatInfo.nextTime
			local currentNextSetPoint = tonumber(jsonThermostatInfo.nextSetpoint) / 100
			if debug then print('script_time_thermostaat: Huidige programma Toon is '.. currentActiveState) end
			if debug then print('script_time_thermostaat: Huidige setpoint is '.. currentSetpoint) end
		end
		
		if tonumber(temp_buiten.temperature) >  tonumber(Temperature_limit) then
			if debug then print('script_time_thermostaat: De buiten temperatuur is ' ..temp_buiten.temperature .. ' graden') end
			--changeSetPoint('12',' omdat het buiten warmer is dan ' ..Temperature_limit .. ' graden',false)
			domoticz.helpers.changeSetPoint('12',' omdat het buiten warmer is dan ' ..Temperature_limit .. ' graden',false)
		end		
		-- If we have reached the timeout, disable the linked switches
		--if domoticz.globalData.NMC_total > NM_timeout then
		if domoticz.globalData.NMC_total ~= nil then 
			domoticz.log(domoticz.globalData.NMC_total)
			if (domoticz.globalData.NMC_total > 30) then
				if debug then print('thermostaat.lua: domoticz.globalData.NMC_total: ' ..domoticz.globalData.NMC_total) end
				domoticz.helpers.changeSetPoint('12','omdat de total no movement timout bereikt is',true)
			end
		end
		if (domoticz.globalData.OpenC_Total > tonumber(Open_timeout)) then
			if debug then print('thermostaat.lua: domoticz.globalData.OpenC_Total: ' ..domoticz.globalData.OpenC_Total) end
			domoticz.helpers.changeSetPoint('12','omdat de total open timout bereikt is',true)
		end

				--local CurrentToonScenesSensorValue = otherdevices_svalues[ToonScenesSensorName]
				--if currentActiveState == -1 then currentActiveState = '50' -- Manual
				--elseif currentActiveState == 0 then currentActiveState = '40' -- Comfort
				--elseif currentActiveState == 1 then currentActiveState = '30' -- Home
				--elseif currentActiveState == 2 then currentActiveState = '20' -- Sleep
				--elseif currentActiveState == 3 then currentActiveState = '10' -- Away
				--end
				--
				--commandArray[1] = {['UpdateDevice'] = string.format('%s|1|%s', otherdevices_idx[ToonScenesSensorName], '10')}
				--if debug then print('Huidige programma Toon veranderd naar Away omdat de woonkamerdeur open staat') end
				--if debug then print('Huidige setpoint is '.. currentSetpoint) end
	end
}
