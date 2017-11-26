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
		buiten = { history = true, maxItems = 12 },
		garage = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)     	
		
		-- add new data
		domoticz.data.woonk.add(domoticz.devices('Temperatuur woonkamer').temperature)
		domoticz.data.k_lars.add(domoticz.devices('Temperatuur Kamer Lars').temperature)
		domoticz.data.badk.add(domoticz.devices('Temperatuur Badkamer').temperature)
		domoticz.data.buiten.add(domoticz.devices('Temperatuur Buiten').temperature)		
		domoticz.data.bijkeuken.add(domoticz.devices('Temperatuur Bijkeuken').temperature)
		domoticz.data.garage.add(domoticz.devices('Temperatuur garage').temperature)
		
		domoticz.log('average_temperatures_woonk = ' ..domoticz.data.woonk.avg())
		domoticz.log('average_temperatures_k_lars = ' ..domoticz.data.k_lars.avg())
		domoticz.log('average_temperatures_badk = ' ..domoticz.data.badk.avg())
		domoticz.log('average_temperatures_buiten = ' ..domoticz.data.buiten.avg())
		domoticz.log('average_temperatures_bijkeuken = ' ..domoticz.data.bijkeuken.avg())
		domoticz.log('average_temperatures_garage = ' ..domoticz.data.garage.avg())
		
		--domoticz.log("De temperatuur in de woonkamer is " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(round(domoticz.data.woonk.avg(),1)) .. ".")
		--domoticz.log("De temperatuur in de kamer van Lars is " ..tonumber(domoticz.devices('Temperatuur Kamer Lars').temperature) .. ". De gemiddelde temperatuur in de kamer van Lars de afgelopen 24 uur was " ..tonumber(round(domoticz.data.k_lars.avg(),1)) .. ".")
		--domoticz.log("De temperatuur in de badkamer is " ..tonumber(domoticz.devices('Temperatuur Badkamer').temperature) .. ". De gemiddelde temperatuur in de badkamer de afgelopen 24 uur was " ..tonumber(round(domoticz.data.badk.avg(),1)) .. ".")
		--domoticz.log("De temperatuur buiten is " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .. ". De gemiddelde temperatuur buiten de afgelopen 24 uur was " ..tonumber(round(domoticz.data.buiten.avg(),1)) .. ".")
		--domoticz.log("De temperatuur in de bijkeuken is " ..tonumber(domoticz.devices('Temperatuur Bijkeuken').temperature) .. ". De gemiddelde temperatuur in de bijkeuken de afgelopen 24 uur was " ..tonumber(round(domoticz.data.bijkeuken.avg(),1)) .. ".")
		--domoticz.log("De temperatuur in de garage is " ..tonumber(domoticz.devices('Temperatuur garage').temperature) .. ". De gemiddelde temperatuur in de garage de afgelopen 24 uur was " ..tonumber(round(domoticz.data.garage.avg(),1)) .. ".")
		
		local temperature_string_woonk
		if (domoticz.devices('Temperatuur woonkamer').temperature > 30) then
			temperature_string_woonk = "extreem"
		elseif (domoticz.devices('Temperatuur woonkamer').temperature > 28) then
			temperature_string_woonk = "heel erg"
		elseif (domoticz.devices('Temperatuur woonkamer').temperature > 26) then
			temperature_string_woonk = "erg"
		elseif (domoticz.devices('Temperatuur woonkamer').temperature > 24) then
			temperature_string_woonk = "redelijk"
		end

		if (domoticz.devices('Temperatuur woonkamer').temperature > 24) then
			if (domoticz.devices('Temperatuur Buiten').temperature < domoticz.devices('Temperatuur woonkamer').temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus deuren en ramen open zetten kan helpen. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(domoticz.data.woonk.avg()) ..".",domoticz.PRIORITY_LOW)  
				--TODO Need to adapt intervals at the end of next line
				domoticz.helpers.message("De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (domoticz.devices('Temperatuur Buiten').temperature > domoticz.devices('Temperatuur woonkamer').temperature) then
				domoticz.notify('Hoge temperatuur binnen',"De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur hoger, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus deuren en ramen open zetten helpt helaas niet. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(domoticz.data.woonk.avg()) ..".",domoticz.PRIORITY_LOW)  
			end
		end

		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() > 2) then
			domoticz.notify('Grote temperatuur stijging woonkamer'," De temperatuur stijgt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg()),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() > 2) then
			domoticz.notify('Grote temperatuur stijging kamer Lars'," De temperatuur stijgt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg()),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() > 2) then
			domoticz.notify('Grote temperatuur stijging badkamer'," De temperatuur stijgt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg()),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg() > 5) then
			domoticz.notify('Grote temperatuur stijging buiten'," De temperatuur stijgt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg()),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() < -2) then
			domoticz.notify('Grote temperatuur daling woonkamer'," De temperatuur daalt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.woonk.avg() - domoticz.devices('Temperatuur woonkamer').temperature),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() < -2) then
			domoticz.notify('Grote temperatuur daling kamer Lars'," De temperatuur daalt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.k_lars.avg() - domoticz.devices('Temperatuur Kamer Lars').temperature),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() < -2) then
			domoticz.notify('Grote temperatuur daling badkamer'," De temperatuur daalt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.badk.avg() - domoticz.devices('Temperatuur Badkamer').temperature),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg() < -5) then
			domoticz.notify('Grote temperatuur daling buiten'," De temperatuur daalt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.buiten.avg()-domoticz.devices('Temperatuur Buiten').temperature),domoticz.PRIORITY_LOW)  
		end
		
		
		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging woonkamer'," De temperatuur stijgt extreem snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg()),domoticz.PRIORITY_HIGH)  
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging kamer Lars'," De temperatuur stijgt extreem snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg()),domoticz.PRIORITY_HIGH)  
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() > 20) then
			domoticz.notify('Brand! Extreem grote temperatuur stijging badkamer'," De temperatuur stijgt extreem snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg()),domoticz.PRIORITY_HIGH)  
		end
		
		if (domoticz.devices('Temperatuur Bijkeuken').temperature < 5) then
			domoticz.notify('Koud!'," De temperatuur in de bijkeuken wordt laag, namelijk " ..tonumber(domoticz.devices('Temperatuur Bijkeuken').temperature),domoticz.PRIORITY_LOW)  
		end
		if (domoticz.devices('Temperatuur garage').temperature < 5) then
			domoticz.notify('Koud!'," De temperatuur in de garage wordt laag, namelijk " ..tonumber(domoticz.devices('Temperatuur garage').temperature),domoticz.PRIORITY_LOW)  
		end
		
	end
}
