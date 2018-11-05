return {
	helpers = {
		timedifference = function(s)
			 year = string.sub(s, 1, 4)
			 month = string.sub(s, 6, 7)
			 day = string.sub(s, 9, 10)
			 hour = string.sub(s, 12, 13)
			 minutes = string.sub(s, 15, 16)
			 seconds = string.sub(s, 18, 19)
			 t1 = os.time()
			 t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
			 timedifference = os.difftime (t1, t2)
			 return timedifference
        	end,
		message = function(MessageText,lastMessageSent,MessageInterval)
			if (time > lastMessageSent + MessageInterval) then
				commandArray['SendNotification']=u
				os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t ' ..u)
			end
			commandArray["Variable:ThermostaatMessage"] = tostring(time) --Last run time of the script is updated to Kamerplant1Message variable
		end,
		timeToSeconds = function(s)
			year = string.sub(s, 1, 4)
			month = string.sub(s, 6, 7)
			day = string.sub(s, 9, 10)
			hour = string.sub(s, 12, 13)
			minutes = string.sub(s, 15, 16)
			seconds = string.sub(s, 18, 19)
			timeInSeconds = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
			return timeInSeconds
		end,
		changeSetPoint =function(domoticz,s,reason,sendmessage,currentSetpoint)
			SetPoint = s
			if currentSetpoint ~= SetPoint then
				ToonCommand = string.format('http://%s/happ_thermstat?action=setSetpoint&Setpoint=%s', '192.168.178.6', SetPoint*100)
				commandArray['OpenURL'] = ToonCommand
				if debug then domoticz.log('Toon setpoint gezet naar '.. SetPoint .. ' ' .. reason,domoticz.LOG_INFO) end
				if sendmessage == true then
					message('Toon setpoint gezet naar '.. SetPoint .. reason)
				end
			end
		end,
		changeToonScene =function(domoticz,s,reason,sendmessage,currentSetpoint,currentActiveState)
			domoticz.log('Huidige setpoint is '.. currentSetpoint,domoticz.LOG_INFO)
			local CurrentToonScenesSensorValue = otherdevices_svalues[ToonScenesSensorName]
			local newState 
			if currentActiveState == -1 then currentActiveState = '50' -- Manual
			elseif currentActiveState == 0 then currentActiveState = '40' -- Comfort
			elseif currentActiveState == 1 then currentActiveState = '30' -- Home
			elseif currentActiveState == 2 then currentActiveState = '20' -- Sleep
			elseif currentActiveState == 3 then currentActiveState = '10' -- Away
			end
			SetScene = s
			domoticz.log('currentActiveState = '.. currentActiveState,domoticz.LOG_INFO)
			domoticz.log('s = '.. s)
			if s == '10' then newState = 'Away' end
			if s == '20' then newState = 'Sleep' end
			if s == '30' then newState = 'Home' end
			if s == '40' then newState = 'Comfort' end
			if s == '50' then newState = 'Manual' end
			domoticz.log('newState = '.. newState)
			domoticz.log('currentActiveState = '.. currentActiveState)
			if currentActiveState ~= SetScene then
				commandArray[1] = {['UpdateDevice'] = string.format('%s|1|%s', otherdevices_idx['Toon Scenes'], s)}
				domoticz.log('Huidige programma Toon veranderd naar '.. newState .. ' ' ..reason)
			end
		end,
		currentSetpoint =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentSetpoint = tonumber(jsonThermostatInfo.currentSetpoint) / 100
			end
			return currentSetpoint
		end,
		currentTemperature =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentTemperature = tonumber(jsonThermostatInfo.currentTemp) / 100
				domoticz.log('Huidige temp is '.. currentTemperature)
			end
			return currentTemperature
		end,
		currentProgramState =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentProgramState = tonumber(jsonThermostatInfo.programState)
			end
			return currentProgramState
		end,
		currentActiveState =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentActiveState = tonumber(jsonThermostatInfo.activeState)
			end
			return currentActiveState
		end,
		currentNextTime =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentNextTime = jsonThermostatInfo.nextTime
			end
			return currentNextTime
		end,		
		currentNextSetPoint =function(domoticz)
			local json = assert(loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()  -- For Linux (LEDE)
			local handle = assert(io.popen(string.format('curl -m 5 http://%s/happ_thermstat?action=getThermostatInfo', '192.168.178.6')))
			local ThermostatInfo = handle:read('*all')
			handle:close()
			local jsonThermostatInfo = json:decode(ThermostatInfo)
			if jsonThermostatInfo ~= nil then
				currentNextSetPoint = tonumber(jsonThermostatInfo.nextSetpoint) / 100
			end
			return currentNextSetPoint
		end,
		MotionCounter =function(domoticz,MotionCounterVar)
			if device.state == "On" then
				motion_minutes = tonumber(MotionCounterVar) + 1
				domoticz.log(device.name .. ' voor ' ..tostring(motion_minutes) ..' minuten')
			end
			return motion_minutes
		end,		
		NoMotionCounter =function(domoticz,NoMotionCounterVar,sendmessage)
			if device.state == "Off" then
				no_motion_minutes = tonumber(NoMotionCounterVar) + 1
				domoticz.log(device.name .. ' voor ' ..tostring(no_motion_minutes) ..' minuten')
			end			
			return no_motion_minutes
		end,
		Counter = function(domoticz,device,count,statestring)
			--domoticz.log('domoticz.globalData.OpenC_domoticz.devices('Zolderdakraam achter'): ' ..domoticz.globalData.OpenC_domoticz.devices('Zolderdakraam achter'))
			--DeviceName = domoticz.devices(85).name
			DeviceName = device.name
			--acc = tonumber(domoticz.globalData.OpenC_domoticz.devices('Zolderdakraam achter'))
			acc = count
			if (acc == nil) then
				domoticz.log('Count = nil for deviceName = ' ..device.name)
				acc = 0
			end
			local count = domoticz.devices().reduce(function(acc, device)
			    if (device.name == DeviceName) then
					if (device.state == statestring) then					
						acc = acc + 1
					else
						acc = 0
					end
			    end
			    return acc
			end, acc)
			return count
		end,
		getdevname4idx = function(deviceIDX)
			for i, v in pairs(otherdevices_idx) do
				if v == deviceIDX then
					return i
				end
			end
			return 0
		end,
		switch_lights = function(domoticz,area,onoff,lastUpdateminutesAgo)
			--lastUpdateminutesAgo = 0, always perform switch action
			--lastUpdateminutesAgo = 3, perform switch action when lastupdate > 3 minutes
			--areas:
			--Inside
			----Floor1
			------Woonkamer
			--------Keuken
			--------Eetkamer
			--------Speelkamer
			--------Living (TV)
			------HalBeneden
			------ToiletBeneden
			----Floor2
			------KamerLars
			------KamerNienke
			------Slaapkamer
			------ToiletBoven
			------HalBoven
			------Badkamer
			----Floor3
			------Zolderkamer
			------Logeerkamer
			--Outside
			----Achtertuin
			----Voortuin
			----Zijkant
			--All=Inside+Outside
			------------------------------------------------------------------------
			--Switch off
			------------------------------------------------------------------------
			
			--domoticz.log(domoticz.devices('Lampen Living').lastUpdate.minutesAgo)
			if (area == 'Living' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Living').state == 'On') then
				if (domoticz.devices('Lampen Living').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Grote lamp naast bank').switchOff().checkFirst()
					domoticz.devices('Schemerlamp deur').switchOff().checkFirst()
					domoticz.devices('Schemerlamp bank').switchOff().checkFirst()
					domoticz.devices('Lamp boven TV').switchOff().checkFirst()
					domoticz.devices('Lampen Living').setState('Off').silent()
					domoticz.log('Lights Living turned off')
				end
			end
			if (area == 'Keuken' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Keuken').state == 'On') then
				if (domoticz.devices('Lampen Keuken').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst()
					domoticz.devices('Single Wall Switch Lampen Keuken').switchOff().checkFirst()			
					domoticz.devices('Single Wall Switch Lampen Keuken').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen Keuken').setState('Off').silent()
					domoticz.log('Lights Keuken turned off')
				end
			end
			if (area == 'Eetkamer' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Eetkamer').state == 'On') then
				if (domoticz.devices('Lampen Eetkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst()
					domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst()
					domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen Eetkamer').setState('Off').silent()
					domoticz.log('Lights Eetkamer turned off')
				end
			end
			domoticz.log("Lampen Speelkamer " ..domoticz.devices('Lampen Speelkamer').lastUpdate.minutesAgo)
			if (area == 'Speelkamer' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Speelkamer').state == 'On') then
				if (domoticz.devices('Lampen Speelkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp speelkamer').switchOff().checkFirst()
					domoticz.devices('Lamp ster').switchOff().checkFirst()
					domoticz.devices('Lamp speelkamer muur').switchOff().checkFirst()
					domoticz.devices('Lamp speelkamer muur').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen Speelkamer').setState('Off').silent()
					domoticz.log('Lights Speelkamer turned off')
				end
			end
			if (area == 'HalBeneden' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen HalBeneden').state == 'On') then
				if (domoticz.devices('Lampen HalBeneden').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then	
					domoticz.devices('Lamp Spiegel Hal').switchOff().checkFirst()
					--domoticz.devices('Single Wall Switch Lampen Hal Beneden').switchOff().checkFirst()
					domoticz.devices('Lamp Spiegel Hal').switchOff().checkFirst().afterSec(2)			
					--domoticz.devices('Single Wall Switch Lampen Hal Beneden').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen HalBeneden').setState('Off').silent()
					domoticz.log('Lights hal beneden turned off')
				end
			end
			if (area == 'ToiletBeneden' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen ToiletBeneden').state == 'On') then
				if (domoticz.devices('Lampen ToiletBeneden').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen ToiletBeneden').setState('Off').silent()
					domoticz.log('Lights ToiletBeneden turned off')
				end
			end
			if (area == 'KamerLars' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen KamerLars').state == 'On') then
				if (domoticz.devices('Lampen KamerLars').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Leeslamp Lars').switchOff().checkFirst()
					domoticz.devices('Lamp Lars').switchOff().checkFirst()
					domoticz.devices('Lamp Lars').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen KamerLars').setState('Off').silent()
					domoticz.log('Lights KamerLars turned off')
				end
			end
			if (area == 'KamerNienke' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen KamerNienke').state == 'On') then
				if (domoticz.devices('Lampen KamerNienke').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Leeslamp Nienke').switchOff().checkFirst()
					domoticz.devices('Lampen KamerNienke').setState('Off').silent()
					domoticz.log('Lights KamerNienke turned off')
				end
			end
			if (area == 'Slaapkamer' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Slaapkamer').state == 'On') then
				if (domoticz.devices('Lampen Slaapkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					--if (domoticz.devices('Dimmer bed Martijn').state == 'On') then	
					--	domoticz.devices('Dimmer bed Martijn').switchOff()
					--end
					--if (domoticz.devices('Dimmer bed Suzanne').state == 'On') then
					--	domoticz.devices('Dimmer bed Suzanne').switchOff()
					--end
					domoticz.devices('Dimmer bed Martijn').switchOff()
					domoticz.devices('Dimmer bed Suzanne').switchOff()
					domoticz.devices('Lamp bed Martijn').switchOff()
					domoticz.devices('Lamp bed Suzanne').switchOff()
					domoticz.devices('Yeelight slaapkamer').switchOff().checkFirst()
					domoticz.devices('Yeelight slaapkamer').switchOff().checkFirst().afterSec(2)
					domoticz.devices('Lampen Slaapkamer').setState('Off').silent()
					domoticz.devices('Dimmer bed Martijn').switchOff().afterSec(2)
					domoticz.devices('Dimmer bed Suzanne').switchOff().afterSec(2)
					domoticz.log('Lights Slaapkamer turned off')
				end
			end
			if (area == 'ToiletBoven' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen ToiletBoven').state == 'On') then
				if (domoticz.devices('Lampen ToiletBoven').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen ToiletBoven').setState('Off').silent()
					domoticz.log('Lights ToiletBoven turned off')
				end
			end
			if (area == 'HalBoven' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen HalBoven').state == 'On') then
				if (domoticz.devices('Lampen HalBoven').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp hal boven').switchOff().checkFirst()
					domoticz.devices('Lampen HalBoven').setState('Off').silent()
					domoticz.log('Lights HalBoven turned off')
				end
			end
			if (area == 'Badkamer' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Badkamer').state == 'On') then
				if (domoticz.devices('Lampen Badkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen Badkamer').setState('Off').silent()
					domoticz.log('Lights Badkamer turned off')
				end	
			end
			if (area == 'Zolderkamer' or area == 'Floor3' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Zolderkamer').state == 'On') then
				if (domoticz.devices('Lampen Zolderkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen zolder').switchOff().checkFirst()
					domoticz.devices('Lampen Zolderkamer').setState('Off').silent()
					domoticz.log('Lights Zolderkamer turned off')
				end	
			end
			if (area == 'Logeerkamer' or area == 'Floor3' or area == 'Inside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Logeerkamer').state == 'On') then
				if (domoticz.devices('Lampen Logeerkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen Logeerkamer').setState('Off').silent()
					domoticz.log('Lights Logeerkamer turned off')
				end	
			end
			if (area == 'Achtertuin' or area == 'Outside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Achtertuin').state == 'On') then
				if (domoticz.devices('Lampen Achtertuin').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp Speelhuisje').switchOff().checkFirst()
					domoticz.devices('Lamp Garagedeur').switchOff().checkFirst()
					domoticz.devices('Lampen Achtertuin').setState('Off').silent()
					domoticz.log('Lights Achtertuin turned off')
				end	
			end
			if (area == 'Voortuin' or area == 'Outside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Voortuin').state == 'On') then
				if (domoticz.devices('Lampen Voortuin').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices(33).switchOff().checkFirst()
					domoticz.devices('Lampen Voortuin').setState('Off').silent()
					domoticz.log('Lights Voortuin turned off')
				end	
			end
			if (area == 'Zijkant' or area == 'Outside' or area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen Zijkant').state == 'On') then
				if (domoticz.devices('Lampen Zijkant').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Buiten Zijkant').switchOff().checkFirst()
					domoticz.devices('Lampen Zijkant').setState('Off').silent()
					domoticz.log('Lights Zijkant turned off')
				end	
			end
			if (area == 'Floor1') and (onoff == 'Off') and (domoticz.devices('Lampen Floor1').state == 'On') then
				domoticz.devices('Lampen Floor1').setState('Off').silent()
			end
			if (area == 'Floor2') and (onoff == 'Off') and (domoticz.devices('Lampen Floor2').state == 'On') then
				domoticz.devices('Lampen Floor2').setState('Off').silent()
			end
			if (area == 'Floor3') and (onoff == 'Off') and (domoticz.devices('Lampen Floor3').state == 'On') then
				domoticz.devices('Lampen Floor3').setState('Off').silent()
			end
			if (area == 'Inside') and (onoff == 'Off') and (domoticz.devices('Lampen Inside').state == 'On') then
				domoticz.devices('Lampen Inside').setState('Off').silent()
			end
			if (area == 'Outside') and (onoff == 'Off') and (domoticz.devices('Lampen Outside').state == 'On') then
				domoticz.devices('Lampen Outside').setState('Off').silent()
			end
			if (area == 'All') and (onoff == 'Off') and (domoticz.devices('Lampen All').state == 'On') then
				domoticz.devices('Lampen All').setState('Off').silent()
			end		
			
			------------------------------------------------------------------------
			--Switch on
			------------------------------------------------------------------------
			if (area == 'Living' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Living').state == 'Off') then
				if (domoticz.devices('Lampen Living').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp boven TV').switchOn().checkFirst()
					domoticz.devices('Grote lamp naast bank').switchOn().checkFirst()
					domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
					domoticz.devices('Schemerlamp bank').switchOn().checkFirst()
					domoticz.devices('Lampen Living').setState('On').silent()
					domoticz.log('Lights Living turned on')
				end	
			end
			if (area == 'Keuken' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Keuken').state == 'Off')  then
				if (domoticz.devices('Lampen Keuken').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()
					domoticz.devices('Single Wall Switch Lampen Keuken').switchOn().checkFirst()			
					domoticz.devices('Single Wall Switch Lampen Keuken').switchOn().checkFirst().afterSec(2)			
					domoticz.devices('Lampen Keuken').setState('On').silent()
					domoticz.log('Lights Keuken turned on')
				end	
			end
			if (area == 'Eetkamer' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Eetkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Eetkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Yeelight eetkamer 1').switchOn().checkFirst()		
					--domoticz.devices('White Temp Yeelight eetkamer 1').dimTo(20)
					--domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
					domoticz.devices('Yeelight eetkamer 2').switchOn().checkFirst()
					--domoticz.devices('White Temp Yeelight eetkamer 2').dimTo(20)
					--domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
					domoticz.devices('Yeelight eetkamer 1').switchOn().checkFirst().afterSec(2)
					domoticz.devices('Yeelight eetkamer 2').switchOn().checkFirst().afterSec(2)		
					domoticz.devices('Lampen Eetkamer').setState('On').silent()
					domoticz.log('Lights Eetkamer turned on')
				end	
			end
			domoticz.log("Lampen Speelkamer " ..domoticz.devices('Lampen Speelkamer').lastUpdate.minutesAgo)
			if (area == 'Speelkamer' or area == 'Woonkamer' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Speelkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Speelkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp speelkamer').switchOn().checkFirst()
					domoticz.devices('Lamp ster').switchOn().checkFirst()
					domoticz.devices('Lamp speelkamer muur').switchOn().checkFirst()
					domoticz.devices('Lamp speelkamer muur').switchOn().checkFirst().afterSec(2)							
					domoticz.devices('Lampen Speelkamer').setState('On').silent()
					domoticz.log('Lights Speelkamer turned on')
				end	
			end
			if (area == 'HalBeneden' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen HalBeneden').state == 'Off')  then
				if (domoticz.devices('Lampen HalBeneden').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp Spiegel Hal').switchOn().checkFirst()
					--domoticz.devices('Single Wall Switch Lampen Hal Beneden').switchOn().checkFirst()
					domoticz.devices('Lamp Spiegel Hal').switchOn().checkFirst().afterSec(2)			
					--domoticz.devices('Single Wall Switch Lampen Hal Beneden').switchOn().checkFirst().afterSec(2)
					domoticz.devices('Lampen HalBeneden').setState('On').silent()
					domoticz.log('Lights hal beneden turned on')
				end	
			end
			if (area == 'ToiletBeneden' or area == 'Floor1' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen ToiletBeneden').state == 'Off')  then
				if (domoticz.devices('Lampen ToiletBeneden').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen ToiletBeneden').setState('On').silent()
					domoticz.log('Lights ToiletBeneden turned on')
				end	
			end
			if (area == 'KamerLars' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen KamerLars').state == 'Off')  then
				if (domoticz.devices('Lampen KamerLars').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Leeslamp Lars').switchOn().checkFirst()
					domoticz.devices('Lamp Lars').switchOn().checkFirst()
					domoticz.devices('Lamp Lars').switchOn().checkFirst().afterSec(2)
					domoticz.devices('Lampen KamerLars').setState('On').silent()
					domoticz.log('Lights KamerLars turned on')
				end	
			end
			if (area == 'KamerNienke' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen KamerNienke').state == 'Off')  then
				if (domoticz.devices('Lampen KamerNienke').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen KamerNienke').setState('On').silent()
					domoticz.log('Lights KamerNienke turned on')
				end	
			end
			if (area == 'Slaapkamer' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Slaapkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Slaapkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
						domoticz.devices('Dimmer bed Martijn').dimTo(20)
					end
					if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
						domoticz.devices('Dimmer bed Suzanne').dimTo(20)
					end
					domoticz.devices('Yeelight slaapkamer').switchOn().checkFirst()				
					--domoticz.devices('White Temp Yeelight slaapkamer').dimTo(20)
					--domoticz.devices('Yeelight Dimmer slaapkamer').dimTo(50)
					domoticz.devices('Yeelight slaapkamer').switchOn().checkFirst().afterSec(2)
					domoticz.devices('Lampen Slaapkamer').setState('On').silent()
					domoticz.log('Lights Slaapkamer turned on')
				end	
			end
			if (area == 'ToiletBoven' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen ToiletBoven').state == 'Off')  then
				if (domoticz.devices('Lampen ToiletBoven').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen ToiletBoven').setState('On').silent()
					domoticz.log('Lights ToiletBoven turned on')
				end	
			end
			if (area == 'HalBoven' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen HalBoven').state == 'Off')  then
				if (domoticz.devices('Lampen HalBoven').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp hal boven').switchOn().checkFirst()
					domoticz.devices('Lampen HalBoven').setState('On').silent()
					domoticz.log('Lights HalBoven turned on')
				end	
			end
			if (area == 'Badkamer' or area == 'Floor2' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Badkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Badkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen Badkamer').setState('On').silent()
					domoticz.log('Lights Badkamer turned on')
				end	
			end
			if (area == 'Zolderkamer' or area == 'Floor3' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Zolderkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Zolderkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen zolder').switchOn().checkFirst()
					domoticz.devices('Lampen Zolderkamer').setState('On').silent()
					domoticz.log('Lights Zolderkamer turned on')
				end	
			end
			if (area == 'Logeerkamer' or area == 'Floor3' or area == 'Inside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Logeerkamer').state == 'Off')  then
				if (domoticz.devices('Lampen Logeerkamer').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lampen logeerkamer').switchOn().checkFirst()
					domoticz.devices('Lampen Logeerkamer').setState('On').silent()
					domoticz.log('Lights floor3 turned on')
				end	
			end
			if (area == 'Achtertuin' or area == 'Outside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Achtertuin').state == 'Off')  then
				if (domoticz.devices('Lampen Achtertuin').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Lamp Speelhuisje').switchOn().checkFirst()
					domoticz.devices('Lamp Garagedeur').switchOn().checkFirst()
					domoticz.devices('Lampen Achtertuin').setState('On').silent()
					domoticz.log('Lights Achtertuin turned on')
				end	
			end
			if (area == 'Voortuin' or area == 'Outside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Voortuin').state == 'Off')  then
				if (domoticz.devices('Lampen Voortuin').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices(33).switchOn().checkFirst()
					domoticz.devices('Lampen Voortuin').setState('On').silent()
					domoticz.log('Lights Voortuin turned on')
				end	
			end
			if (area == 'Zijkant' or area == 'Outside' or area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen Zijkant').state == 'Off')  then
				if (domoticz.devices('Lampen Zijkant').lastUpdate.minutesAgo > lastUpdateminutesAgo or lastUpdateminutesAgo == 0) then
					domoticz.devices('Buiten Zijkant').switchOn().checkFirst()
					domoticz.devices('Lampen Zijkant').setState('On').silent()
					domoticz.log('Lights Zijkant turned on')
				end	
			end
			if (area == 'Floor1') and (onoff == 'On') and (domoticz.devices('Lampen Floor1').state == 'Off')  then
				domoticz.devices('Lampen Floor1').setState('On').silent()
			end
			if (area == 'Floor2') and (onoff == 'On') and (domoticz.devices('Lampen Floor2').state == 'Off')  then
				domoticz.devices('Lampen Floor2').setState('On').silent()
			end
			if (area == 'Floor3') and (onoff == 'On') and (domoticz.devices('Lampen Floor3').state == 'Off')  then
				domoticz.devices('Lampen Floor3').setState('On').silent()
			end
			if (area == 'Inside') and (onoff == 'On') and (domoticz.devices('Lampen Inside').state == 'Off') then
				domoticz.devices('Lampen Inside').setState('On').silent()
			end
			if (area == 'Outside') and (onoff == 'On') and (domoticz.devices('Lampen Outside').state == 'Off')  then
				domoticz.devices('Lampen Outside').setState('On').silent()
			end
			if (area == 'All') and (onoff == 'On') and (domoticz.devices('Lampen All').state == 'Off')  then
				domoticz.devices('Lampen All').setState('On').silent()
			end	
			
			--os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t "Alles is uitgeschakeld. Moet er nog een broodje gebakken worden? Weltrusten alvast!"')
		end,
		check_doors_and_windows = function(domoticz)
			local message = ''
			if (domoticz.devices('Dakraam slaapkamer').state == 'Open') then
			   message = message ..'Dakraam slaapkamer is open, '
			elseif (domoticz.devices('Zolderdakraam achter').state == 'Open') then
			   message = message ..'Dakraam zolder achter is open, '			
			elseif (domoticz.devices('Eetkamerdeur').state == 'Open') then
			   message = message ..'De eetkamerdeur is open, '
			elseif (domoticz.devices('Balkondeur slaapkamer').state == 'Open') then
			   message = message ..'Balkondeur slaapkamer is open, '
			elseif (domoticz.devices('Front door').state == 'Open') then
			   message = message ..'De voordeur is open, '
			elseif (domoticz.devices('Balkondeur Nienke').state == 'Open') then
			   message = message ..'Balkondeur Nienke is open, '
			--elseif (domoticz.devices('Zitkamerdeur').state == 'Open') then
			   --message = message ..'Zitkamerdeur is open, '
			--elseif (domoticz.devices('Zitkamerdeur').lastUpdate.hoursAgo < 20) then
			   --message = message ..'Zitkamerdeur is vandaag open geweest, even checken of hij op slot is, '
			end
			if (string.len(message) > 5) then
				domoticz.notify('Door and windows check', message, domoticz.PRIORITY_HIGH)
				domoticz.devices('Status Notifications').updateText(message).silent()
			end
		end,
		gotosleep = function(domoticz)
			local message = ''
			domoticz.log(domoticz.devices('Status').state)
			--local harmony_poweroff = domoticz.devices(6)
			--local radio = domoticz.devices(8)
			--local MediaCenter = domoticz.devices(11)
			--local Televisie = domoticz.devices(7)
			--local Televisie_lage_resolutie = domoticz.devices(9)
			domoticz.helpers.switch_lights(domoticz,'Inside','Off',0)
			domoticz.helpers.check_doors_and_windows(domoticz)
		end,
		sendnotification = function(domoticz,not_title,not_text)
			if (domoticz.devices('Notifications').level == 20) then
				domoticz.notify(not_title,not_text, domoticz.LOG_INFO)
				domoticz.devices('Status Notifications').updateText(not_text).silent()
			end
		end,
		flash_lights = function(domoticz,start_state_schemerlamp_deur,start_state_lamp_spoelb_keuken,start_state_lamp_boven_tv,start_state_schemerlamp_bank,start_state_lamp_hal_boven,duration,repetition,repetitiondelay)
			if (domoticz.devices('Flash lights').state == 'On') then
				domoticz.devices('Schemerlamp deur').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
				--domoticz.devices('Grote lamp naast bank').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
				--domoticz.devices('Lamp speelkamer').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
				--domoticz.devices('Lamp ster').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
				domoticz.devices('Lamp spoelb keuken').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)		
				domoticz.devices('Lamp boven TV').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
				domoticz.devices('Yeelight bank').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)			
				domoticz.devices('Lamp hal boven').switchOn().forSec(1).repeatAfterSec(repetitiondelay, repetition)
				if start_state_schemerlamp_deur == 'On' then
					domoticz.devices('Schemerlamp deur').switchOn().afterSec(30)
				else
					domoticz.devices('Schemerlamp deur').switchOff().afterSec(30)
				end
				if start_state_lamp_spoelb_keuken == 'On' then
					domoticz.devices('Lamp spoelb keuken').switchOn().afterSec(30)
				else
					domoticz.devices('Lamp spoelb keuken').switchOff().afterSec(30)
				end
				if start_state_domoticz.devices('Lamp boven TV') == 'On' then
					domoticz.devices('Lamp boven TV').switchOn().afterSec(30)
				else
					domoticz.devices('Lamp boven TV').switchOff().afterSec(30)
				end
				if start_state_schemerstart_state_schemerlamp_bank == 'On' then
					schemerdomoticz.devices('Yeelight bank').switchOn().afterSec(30)
				else
					schemerdomoticz.devices('Yeelight bank').switchOff().afterSec(30)
				end
				if start_state_start_state_lamp_hal_boven == 'On' then
					domoticz.devices('Lamp hal boven').switchOn().afterSec(30)
				else
					domoticz.devices('Lamp hal boven').switchOff().afterSec(30)
				end
			end
		end
    	},
	data = {
		OpenC_Eetkamerdeur = { initial = 0 },
		ClosedC_Eetkamerdeur = { initial = 0 },
		OpenC_Dakraamslaapk = { initial = 0 },
		ClosedC_Dakraamslaapk = { initial = 0 },
		OpenC_Balkondeurslaapk = { initial = 0 },
		ClosedC_Balkondeurslaapk = { initial = 0 },
		OpenC_Voordeur = { initial = 0 },
		ClosedC_Voordeur = { initial = 0 },
		OpenC_BalkondeurNienke = { initial = 0 },
		ClosedC_BalkondeurNienke = { initial = 0 },
		OpenC_Slaapkdeur = { initial = 0 },
		ClosedC_Slaapkdeur = { initial = 0 },
		OpenC_Dakraamzolder = { initial = 0 },
		ClosedC_Dakraamzolder = { initial = 0 },
		OpenC_Deurbijkeuken = { initial = 0 },
		ClosedC_Deurbijkeuken = { initial = 0 },
		OpenC_Deurgarage = { initial = 0 },
		ClosedC_Deurgarage = { initial = 0 },
		MC_PIR_woonk = { initial = 0 },
		NMC_PIR_woonk = { initial = 0 },
		MC_PIR_kamerLars = { initial = 0 },
		NMC_PIR_kamerLars = { initial = 0 },
		MC_PIR_halboven = { initial = 0 },
		NMC_PIR_halboven = { initial = 0 },
		MC_PIR_garage  = { initial = 0 },
		NMC_PIR_garage  = { initial = 0 },		
		MC_PIR_naasthuis  = { initial = 0 },
		NMC_PIR_naasthuis  = { initial = 0 },
		MC_Floor1  = { initial = 0 },
		NMC_Floor1  = { initial = 0 },
		MC_Floor2  = { initial = 0 },
		NMC_Floor2  = { initial = 0 },
		MC_Floor3  = { initial = 0 },
		NMC_Floor3  = { initial = 0 },
		OpenC_Floor1  = { initial = 0 },
		ClosedC_Floor1  = { initial = 0 },
		OpenC_Floor2  = { initial = 0 },
		ClosedC_Floor2  = { initial = 0 },
		OpenC_Floor3  = { initial = 0 },
		ClosedC_Floor3  = { initial = 0 },
		OpenC_Outside  = { initial = 0 },
		ClosedC_Outside  = { initial = 0 },
		MC_Overall  = { initial = 0 },
		NMC_Overall  = { initial = 0 },
		OpenC_Overall  = { initial = 0 },
		ClosedC_Overall  = { initial = 0 },
		Counters_time_message_interval  = { initial = 0 },		
		door_garage_message_interval  = { initial = 0 },		
		door_bedroom_message_interval  = { initial = 0 },		
		door_bijkeuken_message_interval  = { initial = 0 },
		humidity_message_interval  = { initial = 0 },
		temperature_message_interval = { initial = 0 },
		temperature_message_interval2 = { initial = 0 }
	}
}
