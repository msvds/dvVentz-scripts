return {
	on = {
		timer = {
			'every minute'
		}
	},
	execute = function(domoticz)
        local ToonThermostatSensorName = domoticz.variables('UV_ToonThermostatSensorName').value -- Sensor showing current setpoint
        local ToonTemperatureSensorName = domoticz.variables('UV_ToonTemperatureSensorName').value -- Sensor showing current room temperature
        local ToonScenesSensorName  = domoticz.variables('UV_ScenesSensorName').value -- Sensor showing current program
        local ToonAutoProgramSensorName = domoticz.variables('UV_ToonAutoProgramSensorName').value -- Sensor showing current auto program status
        local ToonProgramInformationSensorName = domoticz.variables('UV_ToonProgramInformationSensorName').value -- Sensor showing displaying program information status
        local ToonIP = domoticz.variables('UV_ToonIP').value
        local DomoticzIP = '192.168.178.2'
    
        -- Handle json
        --local json = assert(loadfile "C:\\Program Files (x86)\\Domoticz\\scripts\\lua\\json.lua")()  -- For Windows
        local json = assert(loadfile "/home/maes/domoticz/scripts/lua/JSON.lua")()  -- For Linux
        
        local handle = assert(io.popen(string.format('curl http://%s/happ_thermstat?action=getThermostatInfo', ToonIP)))
            local ThermostatInfo = handle:read('*all')
        handle:close()
        
        local jsonThermostatInfo = json:decode(ThermostatInfo)
        
        if jsonThermostatInfo == nil then
            return
        end
        
        local currentSetpoint = tonumber(jsonThermostatInfo.currentSetpoint) / 100
        local currentTemperature = tonumber(jsonThermostatInfo.currentTemp) / 100
        local currentProgramState = tonumber(jsonThermostatInfo.programState)
            if currentProgramState == 0 then currentProgramState = 10 -- No
                elseif currentProgramState == 1 then currentProgramState = 20 -- Yes
                elseif currentProgramState == 2 then currentProgramState = 30 -- Temporary       
            end      
        local currentActiveState = tonumber(jsonThermostatInfo.activeState)
            if currentActiveState == -1 then currentActiveState = 50 -- Manual
                elseif currentActiveState == 0 then currentActiveState = 40 -- Comfort
                elseif currentActiveState == 1 then currentActiveState = 30 -- Home
                elseif currentActiveState == 2 then currentActiveState = 20 -- Sleep
                elseif currentActiveState == 3 then currentActiveState = 10 -- Away
            end
        local currentNextTime = jsonThermostatInfo.nextTime
        local currentNextSetPoint = tonumber(jsonThermostatInfo.nextSetpoint) / 100
        local currentBoiletSetPoint = jsonThermostatInfo.currentInternalBoilerSetpoint
        ----
        
        -- Update the thermostat sensor to current setpoint
        if domoticz.devices(ToonThermostatSensorName).setPoint*100 ~= currentSetpoint*100 then
            domoticz.log('Updating thermostat sensor to new set point: ' ..currentSetpoint)
            domoticz.devices(ToonThermostatSensorName).updateSetPoint(currentSetpoint).silent()
        end
        

        -- Update the temperature sensor to current room temperature
        if domoticz.round(domoticz.devices(ToonTemperatureSensorName).temperature, 1) ~= domoticz.round(currentTemperature, 1) then 
            domoticz.log('Updating the temperature sensor to new value: ' ..currentTemperature)
            domoticz.devices(ToonTemperatureSensorName).updateTemperature(currentTemperature)
        end
        
        -- Update the toon scene selector sensor to current program state
        if domoticz.devices(ToonScenesSensorName).level ~= currentActiveState then  -- Update toon selector if it has changed
            domoticz.log('Updating Toon Scenes selector to: '..currentActiveState)
            domoticz.devices(ToonScenesSensorName).switchSelector(currentActiveState).silent()
        end
        
        -- Updates the toon auto program switch 
        if domoticz.devices(ToonAutoProgramSensorName).level ~= currentProgramState then -- Update toon auto program selector if it has changed
            domoticz.log('Updating Toon Auto Program selector to: '..currentProgramState)
            domoticz.devices(ToonAutoProgramSensorName).switchSelector(currentProgramState).silent()
        end
        
        -- Updates the toon program information text box
        if currentNextTime == 0 or currentNextSetPoint == 0 then
            ToonProgramInformationSensorValue = 'Op ' ..currentSetpoint.. '°'
        else
            ToonProgramInformationSensorValue = 'Om ' ..os.date('%H:%M', currentNextTime).. ' op ' ..currentNextSetPoint.. '°'
        end
        
        if domoticz.devices(ToonProgramInformationSensorName).text ~= ToonProgramInformationSensorValue then
            domoticz.log('Updating Toon Program Information to: '..ToonProgramInformationSensorValue)
            domoticz.devices(ToonProgramInformationSensorName).updateText(ToonProgramInformationSensorValue)
        end
	end
}
