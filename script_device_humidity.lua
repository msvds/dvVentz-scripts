-- humidity checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 6 hours'}
	},
	data = {
        	woonk = { history = true, maxItems = 12 },
		k_lars = { history = true, maxItems = 12 },
		badk = { history = true, maxItems = 12 },
		bijkeuken = { history = true, maxItems = 12 },
		buiten = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)
		message_interval = 1440
		domoticz.globalData.humidity_message_interval = domoticz.globalData.humidity_message_interval + 360
		local hum_woonk = domoticz.devices(21)
		local hum_k_lars = domoticz.devices(63)
		local hum_badk = domoticz.devices(114) 
		local hum_buiten = domoticz.devices(60)				
		local hum_bijkeuken = domoticz.devices(111)       	
		
		-- add new data
		domoticz.data.woonk.add(hum_woonk.humidity)
		domoticz.data.k_lars.add(hum_k_lars.humidity)
		domoticz.data.badk.add(hum_badk.humidity)
		domoticz.data.buiten.add(hum_buiten.humidity)		
		domoticz.data.bijkeuken.add(hum_bijkeuken.humidity)

		-- average over 12 items each 6 hours (3 days)
		local average_humidities_woonk = domoticz.data.woonk.avg()
		local average_humidities_k_lars = domoticz.data.k_lars.avg()
		local average_humidities_badk = domoticz.data.badk.avg()
		local average_humidities_buiten = domoticz.data.buiten.avg()		
		local average_humidities_bijkeuken = domoticz.data.bijkeuken.avg()
		
		domoticz.log("De vochtigheid in de woonkamer is " ..tonumber(hum_woonk.humidity) .. ". De gemiddelde vochtigheid in de woonkamer de afgelopen 72 uur was " ..tonumber(average_humidities_woonk) .. ".")
		domoticz.log("De vochtigheid in de kamer van Lars is " ..tonumber(hum_k_lars.humidity) .. ". De gemiddelde vochtigheid in de kamer van Lars de afgelopen 72 uur was " ..tonumber(average_humidities_k_lars) .. ".")
		domoticz.log("De vochtigheid in de badkamer is " ..tonumber(hum_badk.humidity) .. ". De gemiddelde vochtigheid in de badkamer de afgelopen 72 uur was " ..tonumber(average_humidities_badk) .. ".")
		domoticz.log("De vochtigheid buiten is " ..tonumber(hum_buiten.humidity) .. ". De gemiddelde vochtigheid buiten de afgelopen 72 uur was " ..tonumber(average_humidities_buiten) .. ".")
		domoticz.log("De vochtigheid in de bijkeuken is " ..tonumber(hum_bijkeuken.humidity) .. ". De gemiddelde vochtigheid in de bijkeuken de afgelopen 72 uur was " ..tonumber(average_humidities_bijkeuken) .. ".")
		
		local hum_string_woonk
		if (hum_woonk.humidity > 75) then
			hum_string_woonk = "extreem"
		elseif (hum_woonk.humidity > 72) then
			hum_string_woonk = "heel erg"
		elseif (hum_woonk.humidity > 68) then
			hum_string_woonk = "erg"
		elseif (hum_woonk.humidity > 65) then
			hum_string_woonk = "redelijk"
		end
		
		local message = ''

		if (hum_woonk.humidity > 65) then
			if (hum_buiten.humidity < hum_woonk.humidity) then
				message = message ..'De vochtigheid in de woonkamer begint ' ..hum_string_woonk .. ' hoog te worden, namelijk ' ..tonumber(hum_woonk.humidity) .. '. Buiten is de vochtigheid lager, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten kan helpen. De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was ' ..tonumber(average_humidities_woonk)  ..'.\r'	
			--TODO Need to adapt intervals at the end of next line
				--domoticz.helpers.message("De vochtigheid in de woonkamer begint " ..hum_string_woonk .. " hoogte worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (hum_buiten.humidity > hum_woonk.humidity) then
				message = message ..'De vochtigheid in de woonkamer begint ' ..hum_string_woonk .. ' te worden, namelijk ' ..tonumber(hum_woonk.humidity) .. '. Buiten is de vochtigheid hoger, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten helpt helaas niet. De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was ' ..tonumber(average_humidities_woonk)  ..'.\r'  
			end
		end
		
		if (hum_k_lars.humidity > 60) then
			if (hum_buiten.humidity < hum_k_lars.humidity) then
				message = message ..'De vochtigheid in de kamer van Lars begint hoog te worden, namelijk ' ..tonumber(hum_k_lars.humidity) .. '. Buiten is de vochtigheid lager, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten kan helpen. De gemiddelde vochtigheid in de kamer van Lars de afgelopen 24 uur was ' ..tonumber(average_humidities_k_lars)  ..'.\r'  
				--TODO Need to adapt intervals at the end of next line
				--domoticz.helpers.message("De vochtigheid in de kamer van Lars begint hoog te worden, namelijk " ..tonumber(hum_k_lars.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (hum_buiten.humidity > hum_woonk.humidity) then
				message = message ..'De vochtigheid in de kamer van Lars begint hoog te worden, namelijk ' ..tonumber(hum_k_lars.humidity) .. '. Buiten is de vochtigheid hoger, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten helpt helaas niet. De gemiddelde vochtigheid in de kamer van Lars de afgelopen 24 uur was '  ..tonumber(average_humidities_k_lars)..'.\r'  
			end
		end
		
		local hum_string_badk
		if (hum_badk.humidity - average_humidities_badk > 10) then
			hum_string_badk = "Waarschijnlijk wordt er gedouched of zit er iemand in bad"		
			message = message ..hum_string_badk .. ' namelijk het verschil in vochtigheid met het gemiddelde van de afgelopen 24 uur is ' ..tonumber((hum_badk.humidity - average_humidities_badk))..'.\r'  
		end
		
		if (hum_woonk.humidity - average_humidities_woonk > 8) then
			domoticz.notify('Grote stijging in vochtigheid woonkamer','De vochtigheid stijgt snel in de woonkamer, namelijk het verschil in vochtigheid met het gemiddelde van de afgelopen 24 uur is ' ..tonumber(hum_woonk.humidity - average_humidities_woonk) ..'. Misschien moet de afzuigkap aan?',domoticz.PRIORITY_LOW)  
		end
		
		if (hum_bijkeuken.humidity > 65) then
			if (hum_buiten.humidity < hum_bijkeuken.humidity) then
				message = message ..'De vochtigheid in de bijkeuken begint hoog te worden, namelijk ' ..tonumber(hum_bijkeuken.humidity) .. '. Buiten is de vochtigheid lager, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten kan helpen. De gemiddelde vochtigheid in de bijkeuken de afgelopen 24 uur was ' ..tonumber(average_humidities_bijkeuken)  ..'.\r'  
				--TODO Need to adapt intervals at the end of next line
				--domoticz.helpers.message("De vochtigheid in de bijkeuken begint hoog te worden, namelijk " ..tonumber(hum_bijkeuken.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (hum_buiten.humidity > hum_bijkeuken.humidity) then
				message = message ..'De vochtigheid in de bijkeuken begint hoog te worden, namelijk ' ..tonumber(hum_bijkeuken.humidity) .. '. Buiten is de vochtigheid hoger, namelijk ' ..tonumber(hum_buiten.humidity) ..' dus een raampje open zetten helpt helaas niet. De gemiddelde vochtigheid in de bijkeuken de afgelopen 24 uur was ' ..tonumber(average_humidities_bijkeuken) ..'.\r'  
			end
		end
		if (string.len(message) > 5 and domoticz.globalData.humidity_message_interval > message_interval) then
			domoticz.notify('Vochtigheid',message,domoticz.PRIORITY_LOW)
			domoticz.globalData.humidity_message_interval = 0
		end
	end
}
