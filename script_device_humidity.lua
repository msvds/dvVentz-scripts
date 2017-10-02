-- humidity checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 2 hours'}
	},
	data = {
        	humidities_woonk = { history = true, maxItems = 12 },
		humidities_k_lars = { history = true, maxItems = 12 },
		humidities_badk = { history = true, maxItems = 12 },
		humidities_buiten = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)
		local hum_woonk = domoticz.devices(21)
		local hum_k_lars = domoticz.devices(63)
		local hum_buiten = domoticz.devices(60)		
		local hum_badk = domoticz.devices(114)        	
		
		-- add new data
		domoticz.data.humidities_woonk.add(hum_woonk)
		domoticz.data.humidities_k_lars.add(hum_k_lars)
		domoticz.data.humidities_badk.add(hum_buiten)
		domoticz.data.humidities_buiten.add(hum_badk)

		-- average over 12 items each 2 hours (1 day)
		local average_humidities_woonk = domoticz.data.humidities_woonk.avg()
		local average_humidities_k_lars = domoticz.data.humidities_k_lars.avg()
		local average_humidities_badk = domoticz.data.humidities_badk.avg()
		local average_humidities_buiten = domoticz.data.humidities_buiten.avg()
		
		domoticz.log("De vochtigheid in de woonkamer is " ..tonumber(hum_woonk.humidity) .. ". De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_woonk) .)
		domoticz.log("De vochtigheid in de woonkamer is " ..tonumber(hum_k_lars.humidity) .. ". De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_k_lars) .)
		domoticz.log("De vochtigheid in de woonkamer is " ..tonumber(hum_badk.humidity) .. ". De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_badk) .)
		domoticz.log("De vochtigheid in de woonkamer is " ..tonumber(hum_buiten.humidity) .. ". De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_buiten) .)
		
		local hum_string_woonk
		if (hum_woonk.humidity > 70) then
			hum_string_woonk = "extreem"
		elseif (hum_woonk.humidity > 65) then
			hum_string_woonk = "heel erg"
		elseif (hum_woonk.humidity > 60) then
			hum_string_woonk = "erg"
		elseif (hum_woonk.humidity > 55) then
			hum_string_woonk = "redelijk"
		end

		if (hum_woonk.humidity > 55) then
			if (hum_buiten.humidity < hum_woonk.humidity) then
				domoticz.notify('Vochtigheid hoog',"De vochtigheid in de woonkamer begint " ..hum_string_woonk .. " hoog te worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen. De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_woonk) ..".",domoticz.PRIORITY_LOW)  
				--TODO Need to adapt intervals at the end of next line
				domoticz.helpers.message("De vochtigheid in de woonkamer begint " ..hum_string_woonk .. " hoogte worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (hum_buiten.humidity > hum_woonk.humidity) then
				domoticz.notify('Vochtigheid hoog',"De vochtigheid in de woonkamer begint " ..hum_string_woonk .. " te worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid hoger, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten helpt helaas niet. De gemiddelde vochtigheid in de woonkamer de afgelopen 24 uur was " ..tonumber(average_humidities_woonk) ..".",domoticz.PRIORITY_LOW)  
			end
		end
		
		local hum_string_badk
		if (hum_badk.humidity - average_humidities_badk > 10) then
			hum_string_badk = "Waarschijnlijk wordt er gedouched of zit er iemand in bad"		
			domoticz.notify('Douchen of bad?',hum_string_badk .. " namelijk het verschil in vochtigheid met het gemiddelde van de afgelopen 24 uur is " ..tonumber((hum_badk.humidity - average_humidities_badk)),domoticz.PRIORITY_LOW)  
		end
		
	end
}
