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
		bijkeuken = { history = true, maxItems = 12 },
		buiten = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)
		local temperature_woonk = domoticz.devices(20)
		local temperature_k_lars = domoticz.devices(62)
		local temperature_buiten = domoticz.devices(59)		
		local temperature_badk = domoticz.devices(113)  		
		local temperature_bijkeuken = domoticz.devices(110)       	
		
		-- add new data
		domoticz.data.woonk.add(temperature_woonk.temperature)
		domoticz.data.k_lars.add(temperature_k_lars.temperature)
		domoticz.data.badk.add(temperature_badk.temperature)
		domoticz.data.buiten.add(temperature_buiten.temperature)		
		domoticz.data.bijkeuken.add(temperature_bijkeuken.temperature)

		-- average over 12 items each 2 hours (1 day)
		local average_temperatures_woonk = domoticz.data.woonk.avg()
		local average_temperatures_k_lars = domoticz.data.k_lars.avg()
		local average_temperatures_badk = domoticz.data.badk.avg()
		local average_temperatures_buiten = domoticz.data.buiten.avg()		
		local average_temperatures_bijkeuken = domoticz.data.bijkeuken.avg()
		
		domoticz.log('average_temperatures_woonk = ' ..average_temperatures_woonk)
		domoticz.log('average_temperatures_k_lars = ' ..average_temperatures_k_lars)
		domoticz.log('average_temperatures_badk = ' ..average_temperatures_badk)
		domoticz.log('average_temperatures_buiten = ' ..average_temperatures_buiten)
		domoticz.log('average_temperatures_bijkeuken = ' ..average_temperatures_bijkeuken)
		
		--domoticz.log("De temperatuur in de woonkamer is " ..tonumber(temperature_woonk.temperature) .. ". De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(round(average_temperatures_woonk,1)) .. ".")
		--domoticz.log("De temperatuur in de kamer van Lars is " ..tonumber(temperature_k_lars.temperature) .. ". De gemiddelde temperatuur in de kamer van Lars de afgelopen 24 uur was " ..tonumber(round(average_temperatures_k_lars,1)) .. ".")
		--domoticz.log("De temperatuur in de badkamer is " ..tonumber(temperature_badk.temperature) .. ". De gemiddelde temperatuur in de badkamer de afgelopen 24 uur was " ..tonumber(round(average_temperatures_badk,1)) .. ".")
		--domoticz.log("De temperatuur buiten is " ..tonumber(temperature_buiten.temperature) .. ". De gemiddelde temperatuur buiten de afgelopen 24 uur was " ..tonumber(round(average_temperatures_buiten,1)) .. ".")
		--domoticz.log("De temperatuur in de bijkeuken is " ..tonumber(temperature_bijkeuken.temperature) .. ". De gemiddelde temperatuur buiten de afgelopen 24 uur was " ..tonumber(round(average_temperatures_bijkeuken,1)) .. ".")
		
		local temperature_string_woonk
		if (temperature_woonk.temperature > 30) then
			temperature_string_woonk = "extreem"
		elseif (temperature_woonk.temperature > 28) then
			temperature_string_woonk = "heel erg"
		elseif (temperature_woonk.temperature > 26) then
			temperature_string_woonk = "erg"
		elseif (temperature_woonk.temperature > 24) then
			temperature_string_woonk = "redelijk"
		end

		if (temperature_woonk.temperature > 24) then
			if (temperature_buiten.temperature < temperature_woonk.temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(temperature_woonk.temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(temperature_buiten.temperature) .." dus deuren en ramen open zetten kan helpen. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_woonk) ..".",domoticz.PRIORITY_LOW)  
				--TODO Need to adapt intervals at the end of next line
				domoticz.helpers.message("De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(temperature_woonk.temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(temperature_buiten.temperature) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (temperature_buiten.temperature > temperature_woonk.temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(temperature_woonk.temperature) .. ". Buiten is de temperatuur hoger, namelijk " ..tonumber(temperature_buiten.temperature) .." dus deuren en ramen open zetten helpt helaas niet. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(average_temperatures_woonk) ..".",domoticz.PRIORITY_LOW)  
			end
		end

		if (temperature_woonk.temperature - average_temperatures_woonk > 2) then
			domoticz.notify('Grote temperatuur stijging woonkamer'," De temperatuur stijgt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_woonk.temperature - average_temperatures_woonk),domoticz.PRIORITY_LOW)  
		end
		if (temperature_k_lars.temperature - average_temperatures_k_lars > 2) then
			domoticz.notify('Grote temperatuur stijging kamer Lars'," De temperatuur stijgt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_k_lars.temperature - average_temperatures_k_lars),domoticz.PRIORITY_LOW)  
		end
		if (temperature_badk.temperature - average_temperatures_badk > 2) then
			domoticz.notify('Grote temperatuur stijging badkamer'," De temperatuur stijgt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_badk.temperature - average_temperatures_badk),domoticz.PRIORITY_LOW)  
		end
		if (temperature_buiten.temperature - average_temperatures_buiten > 5) then
			domoticz.notify('Grote temperatuur stijging buiten'," De temperatuur stijgt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_buiten.temperature - average_temperatures_buiten),domoticz.PRIORITY_LOW)  
		end
		
		if (temperature_woonk.temperature - average_temperatures_woonk > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging woonkamer'," De temperatuur stijgt extreem snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_woonk.temperature - average_temperatures_woonk),domoticz.PRIORITY_HIGH)  
		end
		if (temperature_k_lars.temperature - average_temperatures_k_lars > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging kamer Lars'," De temperatuur stijgt extreem snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_k_lars.temperature - average_temperatures_k_lars),domoticz.PRIORITY_HIGH)  
		end
		if (temperature_badk.temperature - average_temperatures_badk > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging badkamer'," De temperatuur stijgt extreem snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(temperature_badk.temperature - average_temperatures_badk),domoticz.PRIORITY_HIGH)  
		end
		
		if (temperature_bijkeuken.temperature < 5) then
			domoticz.notify('Koud!'," De temperatuur in de bijkeuken wordt laag, namelijk " ..tonumber(temperature_bijkeuken),domoticz.PRIORITY_LOW)  
		end
		
	end
}
