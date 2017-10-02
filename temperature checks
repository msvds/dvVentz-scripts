-- temperature checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 2 hours'}
	},
	data = {
		woonk = { history = true, maxItems = 12 },
		k_lars = { history = true, maxItems = 12 },
		badk = { history = true, maxItems = 12 },
		buiten = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)
		local temperature_woonk = domoticz.devices(20)
		local temperature_k_lars = domoticz.devices(62)
		local temperature_buiten = domoticz.devices(59)		
		local temperature_badk = domoticz.devices(113)        	
		
		-- add new data
		domoticz.data.woonk.add(temperature_woonk.temperature)
		domoticz.data.k_lars.add(temperature_k_lars.temperature)
		domoticz.data.badk.add(temperature_badk.temperature)
		domoticz.data.buiten.add(temperature_buiten.temperature)

		-- average over 12 items each 2 hours (1 day)
		local average_temperatures_woonk = domoticz.data.woonk.avg()
		local average_temperatures_k_lars = domoticz.data.k_lars.avg()
		local average_temperatures_badk = domoticz.data.badk.avg()
		local average_temperatures_buiten = domoticz.data.buiten.avg()
		
		domoticz.log("De temperatuur in de woonkamer is " ..tonumber(temperature_woonk.temperature) .. ". De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_woonk) .)
		domoticz.log("De temperatuur in de kamer van Lars is " ..tonumber(temperature_k_lars.temperature) .. ". De gemiddelde temperatuur in de kamer van Lars de afgelopen 24 uur was " ..tonumber(average_temperatures_k_lars) .)
		domoticz.log("De temperatuur in de badkamer is " ..tonumber(temperature_badk.temperature) .. ". De gemiddelde temperatuur in de badkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_badk) .)
		domoticz.log("De temperatuur buiten is " ..tonumber(temperature_buiten.temperature) .. ". De gemiddelde temperatuur buiten de afgelopen 24 uur was " ..tonumber(average_temperatures_buiten) .)
		
		local temperature_string_woonk
		if (woonk.temperature > 30) then
			temperature_string_woonk = "extreem"
		elseif (woonk.temperature > 28) then
			temperature_string_woonk = "heel erg"
		elseif (woonk.temperature > 26) then
			temperature_string_woonk = "erg"
		elseif (woonk.temperature > 24) then
			temperature_string_woonk = "redelijk"
		end

		if (woonk.temperature > 24) then
			if (buiten.temperature < woonk.temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(woonk.temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(buiten.temperature) .." dus deuren en ramen open zetten kan helpen. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_woonk) ..".",domoticz.PRIORITY_LOW)  
				--TODO Need to adapt intervals at the end of next line
				domoticz.helpers.message("De vochtigheid in de woonkamer begint " ..hum_string_woonk .. " hoogte worden, namelijk " ..tonumber(hum_woonk.humidity) .. ". Buiten is de vochtigheid lager, namelijk " ..tonumber(hum_buiten.humidity) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (buiten.temperature > woonk.temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(woonk.temperature) .. ". Buiten is de temperatuur hoger, namelijk " ..tonumber(buiten.temperature) .." dus deuren en ramen open zetten helpt helaas niet. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_woonk) ..".",domoticz.PRIORITY_LOW)  
			end
		end

		if (woonk.temperature - average_temperatures_woonk > 10) then
			domoticz.notify('Grote temperatuur stijging woonkamer'," De temperatuur stijgt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((woonk.temperature - average_temperatures_woonk)),domoticz.PRIORITY_LOW)  
		end
		if (k_lars.temperature - average_temperatures_k_lars > 10) then
			domoticz.notify('Grote temperatuur stijging kamer Lars'," De temperatuur stijgt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((k_lars.temperature - average_temperatures_k_lars)),domoticz.PRIORITY_LOW)  
		end
		if (badk.temperature - average_temperatures_badk > 10) then
			domoticz.notify('Grote temperatuur stijging badkamer'," De temperatuur stijgt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((badk.temperature - average_temperatures_badk)),domoticz.PRIORITY_LOW)  
		end
		if (buiten.temperature - average_temperatures_buiten > 10) then
			domoticz.notify('Grote temperatuur stijging buiten'," De temperatuur stijgt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((buiten.temperature - average_temperatures_buiten)),domoticz.PRIORITY_LOW)  
		end
		
		if (woonk.temperature - average_temperatures_woonk > 30) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging woonkamer'," De temperatuur stijgt extreem snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((woonk.temperature - average_temperatures_woonk)),domoticz.PRIORITY_HIGH)  
		end
		if (k_lars.temperature - average_temperatures_k_lars > 30) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging kamer Lars'," De temperatuur stijgt extreem snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((k_lars.temperature - average_temperatures_k_lars)),domoticz.PRIORITY_HIGH)  
		end
		if (badk.temperature - average_temperatures_badk > 30) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging badkamer'," De temperatuur stijgt extreem snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber((badk.temperature - average_temperatures_badk)),domoticz.PRIORITY_HIGH)  
		end
		
	end
}
