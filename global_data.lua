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
		changeSetPoint =function(s,reason,sendmessage)
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
		OpenC = function(domoticz,device,count)
			domoticz.log('device.state = ' ..device.state)
			domoticz.log('count = ' ..count)
			local DeviceName = device.name
			local count = domoticz.devices().reduce(function(Counter, device)
			--domoticz.log('device.state = ' ..device.state)
			--domoticz.log('device.name = ' ..device.name)
			--domoticz.log('DeviceName = ' ..DeviceName)
			Counter = count
			if (device.name == DeviceName) then
				if (device.state == 'Open') then
					Counter = Counter + 1 -- increase the counter
					domoticz.log('If Counter = ' ..Counter)
				else
					domoticz.log('else Counter = ' ..Counter)
					Counter = 0
				end
			end
			    return Counter -- always return the counter
			end,0)
			return count
		end,
		ClosedC = function(domoticz,device,count)
			domoticz.log('device.state = ' ..device.state)
			domoticz.log('Counter = ' ..count)
			local DeviceName = device.name
			local count = domoticz.devices().reduce(function(Counter, device)
			--domoticz.log('device.state = ' ..device.state)
			--domoticz.log('device.name = ' ..device.name)
			--domoticz.log('DeviceName = ' ..DeviceName)
			if (device.name == DeviceName) then
				if (device.state == 'Closed') then
					Counter = Counter + 1 -- increase the counter
					domoticz.log('If Counter = ' ..Counter)
				else
					domoticz.log('else Counter = ' ..Counter)
					Counter = 0
				end
			end
			    return Counter -- always return the counter
			end,0)
			return count
		end,
		--CountersDevice =function(domoticz,DeviceIdx,DeviceType,DeviceGroup1,DeviceGroup2)
		--	local Device = domoticz.devices(DeviceIdx)
		--	local On_string
		--	local message
		--	message = 'domoticz'
		--	message = message .. ' ' .. DeviceIdx
		--	message = message .. ' ' .. DeviceType
		--	message = message .. ' ' .. DeviceGroup1
		--	message = message .. ' ' .. DeviceGroup2
		--	domoticz.log(message)
		--	if (DeviceType == 'Door') then
		--		On_string = 'Open'
		--	elseif (DeviceType == 'Window') then
		--		On_string = 'Open'
		--	elseif (DeviceType == 'PIR') then
		--		On_string = 'On'
		--	end
		--	domoticz.log('Device.state = ' ..Device.state)	
		--	domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		--	if (Device.state == On_string) then
		--		domoticz.globalData.OpenC_Eetkamerdeur  = domoticz.globalData.OpenC_Eetkamerdeur + 1
		--		domoticz.log('OpenC_Eetkamerdeur = ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		--		domoticz.globalData.OpenC_Floor1 = domoticz.globalData.OpenC_Floor1 + 1
		--	end
		--	domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		--	domoticz.log('domoticz.globalData.OpenC_Floor1: ' ..domoticz.globalData.OpenC_Floor1)
		--end,		
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
		MC_Total  = { initial = 0 },
		NMC_Total  = { initial = 0 },
		OpenC_Total  = { initial = 0 },
		ClosedC_Total  = { initial = 0 }
	}
}
