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
				ToonCommand = string.format('http://%s/happ_thermstat?action=setSetpoint&Setpoint=%s', ToonIP, SetPoint*100)
				commandArray['OpenURL'] = ToonCommand
				if debug then domoticz.log('Toon setpoint gezet naar '.. SetPoint .. ' ' .. reason) end
				if sendmessage == true then
					message('Toon setpoint gezet naar '.. SetPoint .. reason)
				end
			end
		end,
		changeToonScene =function(domoticz,s,reason,sendmessage,currentSetpoint,currentActiveState)
			domoticz.log('Huidige setpoint is '.. currentSetpoint)
			local CurrentToonScenesSensorValue = otherdevices_svalues[ToonScenesSensorName]
			local newState 
			if currentActiveState == -1 then currentActiveState = '50' -- Manual
			elseif currentActiveState == 0 then currentActiveState = '40' -- Comfort
			elseif currentActiveState == 1 then currentActiveState = '30' -- Home
			elseif currentActiveState == 2 then currentActiveState = '20' -- Sleep
			elseif currentActiveState == 3 then currentActiveState = '10' -- Away
			end
			SetScene = s
			domoticz.log('currentActiveState = '.. currentActiveState)
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
		changeToonSceneComplete =function(domoticz,s,reason,sendmessage)
			--domoticz.log('Huidige setpoint is '.. currentSetpoint)
			--change toon
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
				domoticz.helpers.changeToonScene(domoticz,s,reason,sendmessage,currentSetpoint,currentActiveState)
			end
			--end change toon
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
		gotosleep = function(domoticz)
			domoticz.log(domoticz.devices('Status').state)
			--local harmony_poweroff = domoticz.devices(6)
			--local radio = domoticz.devices(8)
			--local MediaCenter = domoticz.devices(11)
			--local Televisie = domoticz.devices(7)
			--local Televisie_lage_resolutie = domoticz.devices(9)		
			domoticz.devices('Status').switchSelector(30) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.devices('Lamp boven TV').switchOff()
			domoticz.devices('Lamp spoelb keuken').switchOff()
			domoticz.devices('Lamp bank').switchOff()
			schemerdomoticz.devices('Lamp bank').switchOff()
			domoticz.devices('Schemerlamp deur').switchOff()
			domoticz.helpers.changeToonSceneComplete(domoticz,'10','omdat de gaan slapen knop ingedrukt is',false)
			os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t "Alles is uitgeschakeld. Moet er nog een broodje gebakken worden? Weltrusten alvast!"')
			domoticz.log('Lights turned off and Harmony turned off')
			if (domoticz.devices('Dakraam slaapkamer')amer.state == 'Open') then
			   domoticz.notify('Dakraam slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (domoticz.devices('Zolderdakraam achter')achter.state == 'Open') then
			   domoticz.notify('Dakraam zolder achter is open',domoticz.PRIORITY_HIGH)				
			elseif (domoticz.devices('Eetkamerdeur').state == 'Open') then
			   domoticz.notify('domoticz.devices('Eetkamerdeur') is open',domoticz.PRIORITY_HIGH)
			elseif (domoticz.devices('Balkondeur slaapkamer').state == 'Open') then
			   domoticz.notify('Balkondeur slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (domoticz.devices('Front door').state == 'Open') then
			   domoticz.notify('domoticz.devices('Front door') is open',domoticz.PRIORITY_HIGH)
			elseif (domoticz.devices('Balkondeur Nienke').state == 'Open') then
			   domoticz.notify('Balkondeur Nienke is open',domoticz.PRIORITY_HIGH)
			--elseif (MediaCenter.state == 'On') then
			  -- domoticz.notify('MediaCenter staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie.state == 'On') then
			  -- domoticz.notify('Televisie staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie_lage_resolutie.state == 'On') then
			  -- domoticz.notify('Televisie lage resolutie staat aan',domoticz.PRIORITY_HIGH)
			end 
		end,
		sendnotification = function(domoticz,not_title,not_text,start_state_domoticz.devices('Schemerlamp deur'),start_state_domoticz.devices('Lamp spoelb keuken'),start_state_domoticz.devices('Lamp boven TV'),start_state_schemerdomoticz.devices('Lamp bank'),start_state_domoticz.devices('Lamp hal boven'),duration,repetition,repetitiondelay)
			domoticz.notify(not_title,not_text, domoticz.LOG_INFO)
			domoticz.devices('Schemerlamp deur').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)		
			domoticz.devices('Lamp spoelb keuken').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)		
			domoticz.devices('Lamp boven TV').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)
			schemerdomoticz.devices('Lamp bank').switchOn().forSec(duration).repeatAfterSec(repetitiondelay, repetition)			
			domoticz.devices('Lamp hal boven').switchOn().forSec(1).repeatAfterSec(repetitiondelay, repetition)
			if start_state_domoticz.devices('Schemerlamp deur') == 'On' then
				domoticz.devices('Schemerlamp deur').switchOn().afterSec(30)
			else
				domoticz.devices('Schemerlamp deur').switchOff().afterSec(30)
			end
			if start_state_domoticz.devices('Lamp spoelb keuken') == 'On' then
				domoticz.devices('Lamp spoelb keuken').switchOn().afterSec(30)
			else
				domoticz.devices('Lamp spoelb keuken').switchOff().afterSec(30)
			end
			if start_state_domoticz.devices('Lamp boven TV') == 'On' then
				domoticz.devices('Lamp boven TV').switchOn().afterSec(30)
			else
				domoticz.devices('Lamp boven TV').switchOff().afterSec(30)
			end
			if start_state_schemerdomoticz.devices('Lamp bank') == 'On' then
				schemerdomoticz.devices('Lamp bank').switchOn().afterSec(30)
			else
				schemerdomoticz.devices('Lamp bank').switchOff().afterSec(30)
			end
			if start_state_domoticz.devices('Lamp hal boven') == 'On' then
				domoticz.devices('Lamp hal boven').switchOn().afterSec(30)
			else
				domoticz.devices('Lamp hal boven').switchOff().afterSec(30)
			end
		end
    	},
	data = {
		OpenC_domoticz.devices('Eetkamerdeur') = { initial = 0 },
		ClosedC_domoticz.devices('Eetkamerdeur') = { initial = 0 },
		OpenC_domoticz.devices('Dakraam slaapkamer') = { initial = 0 },
		ClosedC_domoticz.devices('Dakraam slaapkamer') = { initial = 0 },
		OpenC_domoticz.devices('Balkondeur slaapkamer') = { initial = 0 },
		ClosedC_domoticz.devices('Balkondeur slaapkamer') = { initial = 0 },
		OpenC_domoticz.devices('Front door') = { initial = 0 },
		ClosedC_domoticz.devices('Front door') = { initial = 0 },
		OpenC_domoticz.devices('Balkondeur Nienke') = { initial = 0 },
		ClosedC_domoticz.devices('Balkondeur Nienke') = { initial = 0 },
		OpenC_domoticz.devices('Slaapkamerdeur') = { initial = 0 },
		ClosedC_domoticz.devices('Slaapkamerdeur') = { initial = 0 },
		OpenC_domoticz.devices('Zolderdakraam achter') = { initial = 0 },
		ClosedC_domoticz.devices('Zolderdakraam achter') = { initial = 0 },
		OpenC_domoticz.devices('Deur bijkeuken') = { initial = 0 },
		ClosedC_domoticz.devices('Deur bijkeuken') = { initial = 0 },
		OpenC_domoticz.devices('Garage deur') = { initial = 0 },
		ClosedC_domoticz.devices('Garage deur') = { initial = 0 },
		MC_domoticz.devices('Beweging woonkamer')	  = { initial = 0 },
		NMC_domoticz.devices('Beweging woonkamer')	  = { initial = 0 },
		MC_domoticz.devices('Beweging kamer Lars')  = { initial = 0 },
		NMC_domoticz.devices('Beweging kamer Lars')  = { initial = 0 },
		MC_domoticz.devices('Beweging hal boven')  = { initial = 0 },
		NMC_domoticz.devices('Beweging hal boven')  = { initial = 0 },
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
		door_bijkeuken_message_interval  = { initial = 0 }
	}
}
