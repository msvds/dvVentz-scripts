-- when motion, no motion, open or closed windows/door are detected, the counters are set to 0 here
return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 6 hours'}
	},
	data = {
            lastMessageSent = {initial=0}
        },
	execute = function(domoticz, device)
		local hum_woonk = domoticz.devices(21)
		local hum_k_lars = domoticz.devices(63)
		local hum_buiten = domoticz.devices(60)
        local hum_string
        
		if (hum_woonk.humidity > 70) then
			hum_string = "extreem"
		elseif (hum_woonk.humidity > 65) then
			hum_string = "heel erg"
		elseif (hum_woonk.humidity > 60) then
			hum_string = "erg"
		elseif (hum_woonk.humidity > 55) then
			hum_string = "redelijk"
		end

		if (hum_woonk.humidity > 55) then
			if (hum_buiten.humidity < hum_woonk.humidity) then
				domoticz.notify('Vochtigheid hoog',"De vochtigheid in de woonkamer begint " ..hum_string .. " te worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.",domoticz.PRIORITY_LOW)  
				lastMessageSent = domoticz.time		
			elseif (hum_buiten.humidity > hum_woonk.humidity) then
				domoticz.notify('Vochtigheid hoog',"De vochtigheid in de woonkamer begint " ..hum_string .. " te worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid hoger, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten helpt helaas niet.",domoticz.PRIORITY_LOW)  
				lastMessageSent = domoticz.time	
			end
		end
	end
}

--function message (u)
--    if (time > lastMessageSent + MessageInterval) then
--        commandArray['SendNotification']=u
--        os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t ' ..u)
--        os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t ' ..u)
--    end
--    commandArray["Variable:HumidityMessage"] = tostring(time) --Last run time of the script is updated to Kamerplant1Message variable
--end
