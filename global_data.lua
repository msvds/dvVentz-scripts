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
		changeSetPoint =function(s,reason,sendmessage,currentSetpoint)
			SetPoint = s
			if currentSetpoint ~= SetPoint then
				ToonCommand = string.format('http://%s/happ_thermstat?action=setSetpoint&Setpoint=%s', ToonIP, SetPoint*100)
				commandArray['OpenURL'] = ToonCommand
				if debug then print('script_time_thermostaat: Toon setpoint gezet naar '.. SetPoint .. reason) end
				if sendmessage == true then
					message('Toon setpoint gezet naar '.. SetPoint .. reason)
				end
			end
		end,
		changeToonScene =function(s,reason,sendmessage,currentSetpoint)
			local CurrentToonScenesSensorValue = otherdevices_svalues[ToonScenesSensorName]
			if currentActiveState == -1 then currentActiveState = '50' -- Manual
			elseif currentActiveState == 0 then currentActiveState = '40' -- Comfort
			elseif currentActiveState == 1 then currentActiveState = '30' -- Home
			elseif currentActiveState == 2 then currentActiveState = '20' -- Sleep
			elseif currentActiveState == 3 then currentActiveState = '10' -- Away
			end
			SetScene = s
			if currentActiveState ~= SetScene then
				commandArray[1] = {['UpdateDevice'] = string.format('%s|1|%s', otherdevices_idx['Toon Thermostat'], s)}
				if debug then print('Huidige programma Toon veranderd naar ' ..s.. ' omdat de woonkamerdeur open staat') end
				if debug then print('Huidige setpoint is '.. currentSetpoint) end
			end
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
			--domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
			--DeviceName = domoticz.devices(85).name
			DeviceName = device.name
			--acc = tonumber(domoticz.globalData.OpenC_Dakraamzolder)
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
		end
    	},
	data = {
		OpenC_Eetkamerdeur = { initial = 0 },
		ClosedC_Eetkamerdeur = { initial = 0 },
		MC_PIR_woonkamer = { initial = 0 },
		NMC_PIR_woonkamer = { initial = 0 },
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
		MC_PIR_woonk  = { initial = 0 },
		NMC_PIR_woonk  = { initial = 0 },
		MC_PIR_kamerLars  = { initial = 0 },
		NMC_PIR_kamerLars  = { initial = 0 },
		MC_PIR_halboven  = { initial = 0 },
		NMC_PIR_halboven  = { initial = 0 },
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
		MC_Overall  = { initial = 0 },
		NMC_Overall  = { initial = 0 },
		OpenC_Overall  = { initial = 0 },
		ClosedC_Overall  = { initial = 0 },
		Counters_time_message  = { initial = 0 }
	}
}
