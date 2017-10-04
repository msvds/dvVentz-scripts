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
		end
    	},
	data = {
		MC_Eetkamerdeur = { initial = 0 },
		NMC_Eetkamerdeur = { initial = 0 },
		MC_PIR_woonkamer = { initial = 0 },
		NMC_PIR_woonkamer = { initial = 0 },
		MC_Dakraamslaapk = { initial = 0 },
		NMC_Dakraamslaapk = { initial = 0 },
		MC_Balkondeurslaapk = { initial = 0 },
		NMC_Balkondeurslaapk = { initial = 0 },
		MC_Voordeur = { initial = 0 },
		NMC_Voordeur = { initial = 0 },
		MC_BalkondeurNienke = { initial = 0 },
		NMC_BalkondeurNienke = { initial = 0 },
		MC_Slaapkdeur = { initial = 0 },
		NMC_Slaapkdeur = { initial = 0 },
		MC_Dakraamzolder = { initial = 0 },
		NMC_Dakraamzolder = { initial = 0 },
		MC_PIR_woonk  = { initial = 0 },
		NMC_PIR_woonk  = { initial = 0 },
		MC_PIR_kamerLars  = { initial = 0 },
		NMC_PIR_kamerLars  = { initial = 0 },
		MC_PIR_halboven  = { initial = 0 },
		NMC_PIR_halboven  = { initial = 0 }
	}
}
