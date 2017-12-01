-- temperature checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 2 hours'}
	},
	data = {
        woonk = { history = true, maxItems = 12 },
		k_lars = { history = true, maxItems = 12 },
		k_nienke = { history = true, maxItems = 12 },
		badk = { history = true, maxItems = 12 },
		bijkeuken = { history = true, maxItems = 12 },
		buiten = { history = true, maxItems = 12 },
		garage = { history = true, maxItems = 12 },
		zolder = { history = true, maxItems = 12 }
        },
	execute = function(domoticz, device)     	
		message_interval = 480
		domoticz.globalData.temperature_message_interval = domoticz.globalData.temperature_message_interval + 120
		local message = ''
		-- add new data
		domoticz.data.woonk.add(domoticz.devices('Temperatuur woonkamer').temperature)
		domoticz.data.k_lars.add(domoticz.devices('Temperatuur Kamer Lars').temperature)
		domoticz.data.k_nienke.add(domoticz.devices('Temperatuur Kamer Nienke').temperature)
		domoticz.data.badk.add(domoticz.devices('Temperatuur Badkamer').temperature)
		domoticz.data.buiten.add(domoticz.devices('Temperatuur Buiten').temperature)
		domoticz.data.bijkeuken.add(domoticz.devices('Temperatuur Bijkeuken').temperature)
		domoticz.data.garage.add(domoticz.devices('Temperatuur garage').temperature)
		domoticz.data.zolder.add(domoticz.devices('Temperatuur zolder').temperature)
		
		domoticz.log('average_temperatures_woonk = ' ..domoticz.data.woonk.avg())
		domoticz.log('average_temperatures_k_lars = ' ..domoticz.data.k_lars.avg())
		domoticz.log('average_temperatures_k_nienke = ' ..domoticz.data.k_nienke.avg())
		domoticz.log('average_temperatures_badk = ' ..domoticz.data.badk.avg())
		domoticz.log('average_temperatures_buiten = ' ..domoticz.data.buiten.avg())
		domoticz.log('average_temperatures_bijkeuken = ' ..domoticz.data.bijkeuken.avg())
		domoticz.log('average_temperatures_garage = ' ..domoticz.data.garage.avg())
		domoticz.log('average_temperatures_zolder = ' ..domoticz.data.zolder.avg())
		
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
				message = message .."De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus deuren en ramen open zetten kan helpen. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(domoticz.data.woonk.avg()) .."."
				--TODO Need to adapt intervals at the end of next line
				domoticz.helpers.message("De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur lager, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus een raampje open zetten kan helpen.", 100,90)	
			elseif (domoticz.devices('Temperatuur Buiten').temperature > domoticz.devices('Temperatuur woonkamer').temperature) then
				message = message .."De temperatuur in de woonkamer begint " ..temperature_string_woonk .. " hoog te worden, namelijk " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature) .. ". Buiten is de temperatuur hoger, namelijk " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature) .." dus deuren en ramen open zetten helpt helaas niet. De gemiddelde temperatuur in de woonkamer de afgelopen 24 uur was " ..tonumber(domoticz.data.woonk.avg()) .."." 
			end
		end

		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() > 2) then
			message = message .." De temperatuur stijgt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg()) 
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() > 2) then
			message = message .."De temperatuur stijgt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg())
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() > 2) then
			message = message .."De temperatuur stijgt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg()) 
		end
		if (domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg() > 5) then
			message = message .."De temperatuur stijgt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg())
		end
		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() < -2) then
			message = message .."De temperatuur daalt snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.woonk.avg() - domoticz.devices('Temperatuur woonkamer').temperature)  
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() < -2) then
			message = message .."De temperatuur daalt snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.k_lars.avg() - domoticz.devices('Temperatuur Kamer Lars').temperature) 
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() < -2) then
			message = message .."De temperatuur daalt snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.badk.avg() - domoticz.devices('Temperatuur Badkamer').temperature) 
		end
		if (domoticz.devices('Temperatuur Buiten').temperature - domoticz.data.buiten.avg() < -5) then
			message = message .." De temperatuur daalt snel buiten, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.data.buiten.avg()-domoticz.devices('Temperatuur Buiten').temperature)  
		end
		
		
		if (domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg() > 20) then
			message = message .."De temperatuur stijgt extreem snel in de woonkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur woonkamer').temperature - domoticz.data.woonk.avg())
		end
		if (domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg() > 20) then
			message = message .."De temperatuur stijgt extreem snel in de kamer van Lars, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Kamer Lars').temperature - domoticz.data.k_lars.avg()) 
		end
		if (domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg() > 20) then
			message = message .."De temperatuur stijgt extreem snel in de badkamer, namelijk het verschil in temperatuur met het gemiddelde van de afgelopen 24 uur is " ..tonumber(domoticz.devices('Temperatuur Badkamer').temperature - domoticz.data.badk.avg())
		end
		
		if (domoticz.devices('Temperatuur Bijkeuken').temperature < 5) then
			message = message .."De temperatuur in de bijkeuken wordt laag, namelijk " ..tonumber(domoticz.devices('Temperatuur Bijkeuken').temperature)
		end
		if (domoticz.devices('Temperatuur garage').temperature < 5) then
			message = message .."De temperatuur in de garage wordt laag, namelijk " ..tonumber(domoticz.devices('Temperatuur garage').temperature)
		end
		
		if (domoticz.devices('Temperatuur woonkamer').temperature > 25) then			
			domoticz.devices('Gashaard').setState('Run Down')
			message = message ..'De gashaard is uitgezet omdat het warmer is dan 25 graden in de woonkamer' 
		
		end
		if (string.len(message) > 5 and domoticz.globalData.temperature_message_interval > message_interval) then
			domoticz.notify('Temperatuur waarschuwing',message,domoticz.PRIORITY_LOW)
			domoticz.globalData.temperature_message_interval = 0
		end
		
	end
}
