return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'every 6 hours'}
	},
	execute = function(domoticz, device)
		local temp_buiten = domoticz.devices(59)
		local Temperature_limit = '18'
		local timeout = tonumber(5)
		local Time = require('Time')
		--ToonState = '50' -- Manual
		--ToonState = '40' -- Comfort
		--ToonState = '30' -- Home
		--ToonState = '20' -- Sleep
		--ToonState = '10' -- Away
		local ToonScenesSensorName  = uservariables['UV_ToonScenesSensorName'] -- Sensor showing current program
		local ToonThermostatSensorName = uservariables['UV_ToonThermostatSensorName'] -- Sensor showing current setpoint
		local ToonIP = uservariables['UV_ToonIP']
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
			changeSetPoint('12',' omdat het buiten warmer is dan ' ..Temperature_limit .. ' graden',false)
		end		

		-- If we have reached the timeout, disable the linked switches
		if(timeout <= no_change_minutes) then
			if debug then print('script_time_thermostaat: ' ..variable ..': timeout reached.') end
			for i, detector in ipairs(devices['detectors']) do
				if (device == 'Eetkamerdeur' and (deviceValue == 'Open' or test == 'On')) then
					if debug then print('script_time_thermostaat: deviceValue ' ..deviceValue) end
					changeSetPoint('12','omdat de eetkamerdeur open staat',true)
				elseif (device == 'Balkondeur slaapkamer' and (deviceValue == 'Open' or test == 'On')) then
					if debug then print('script_time_thermostaat: deviceValue ' ..deviceValue) end
					changeSetPoint('12','omdat de balkondeur slaapkamer open staat',true)
				elseif (device == 'Dakraam slaapkamer' and (deviceValue == 'Open' or test == 'On')) then
					if debug then print('script_time_thermostaat: deviceValue ' ..deviceValue) end
					changeSetPoint('12','omdat de dakraam slaapkamer open staat',true)
				elseif (device == 'Zolderdakraam achter' and (deviceValue == 'Open' or test == 'On')) then
					if debug then print('script_time_thermostaat: deviceValue ' ..deviceValue) end
					changeSetPoint('12','omdat de zolderdakraam achter open staat',true)
				elseif (device == 'Beweging woonkamer' and (deviceValue == 'Off' or test == 'On')) then
					if (device == 'Beweging kamer Lars' and (deviceValue == 'Off' or test == 'On')) then
						if debug then print('script_time_thermostaat: deviceValue ' ..deviceValue) end
						changeSetPoint('12','omdat er niemand thuis lijkt te zijn',true)
					end
				end
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
		
		domoticz.log(device.name ..' state = ' ..device.state)		
		if (device.state == 'On') then
			if (lampen_woonkamer.state == 'Off') then
				lampen_woonkamer.switchOn()
				domoticz.log('Eetkamerdeur open terwijl het donker is -> Nachtlampjes aangezet')
			end		
		end
	end
}
