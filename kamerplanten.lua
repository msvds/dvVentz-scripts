return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 6 hours'}
	},
	data = {
		plant1 = { history = true, maxItems = 28 },
		plant2 = { history = true, maxItems = 28 }
        },
	execute = function(domoticz, device)
		local hum_plant1 = domoticz.devices(67)
		local hum_plant2 = domoticz.devices(101)
    	local message
		
		-- add new data
		domoticz.data.plant1.add(hum_plant1.percentage)
		domoticz.data.plant2.add(hum_plant2.percentage)

		-- average over 28 items each 6 hours (1 week)
		local average_humidities_plant1  = domoticz.data.plant1.avg()
		local average_humidities_plant2  = domoticz.data.plant2.avg()    
    
		if (hum_plant1.humidity < 25) then				
        	message = message .. 'De plant in de hal boven begint heel erg droog te worden (<25%), namelijk ' ..tonumber(hum_plant1.percentage) .. '), '
		elseif (hum_plant1.humidity < 35) then				
        	message = message .. 'De plant in de hal boven begint erg droog te worden (<35%), namelijk ' ..tonumber(hum_plant1.percentage) .. '), '
		elseif (hum_plant1.humidity < 40) then				
        	message = message .. 'De plant in de hal boven begint droog te worden (<40%), namelijk ' ..tonumber(hum_plant1.percentage) .. '), '
		elseif (hum_plant1.humidity < 50) then				
        	message = message .. 'De plant in de hal boven begint een beetje droog te worden (<50%), namelijk ' ..tonumber(hum_plant1.percentage) .. '), '
		end
    
		if (hum_plant2.percentage < 10) then				
			message = message .. 'De plant in de badkamer begint heel erg droog te worden (<25%), namelijk ' ..tonumber(hum_plant2.percentage) .. '), '
		elseif (hum_plant2.percentage < 15) then				
			message = message .. 'De plant in de badkamer begint erg droog te worden (<35%), namelijk ' ..tonumber(hum_plant2.percentage) .. '), '
		elseif (hum_plant2.percentage < 20) then				
			message = message .. 'De plant in de badkamer begint droog te worden (<40%), namelijk ' ..tonumber(hum_plant2.percentage) .. '), '
		elseif (hum_plant2.percentage < 25) then				
			message = message .. 'De plant in de badkamer begint een beetje droog te worden (<50%), namelijk ' ..tonumber(hum_plant2.percentage) .. '), '
		end

		if (average_humidities_plant1 - hum_plant1.percentage > 15) then
			message = message .. 'De plant in de hal boven drinkt veel, klopt het dat het zomer is?, '
		elseif (average_humidities_plant1 - hum_plant1.percentage > 10) then
			message = message .. 'De plant in de hal boven drinkt redelijk veel, klopt het dat het lente is?, '
		elseif (average_humidities_plant1 - hum_plant1.percentage < 10) then
			message = message .. 'De plant in de hal boven drinkt redelijk weinig, klopt het dat het winter of herfst is?, '
		end

		if (average_humidities_plant2 - hum_plant2.percentage > 5) then
			message = message .. 'De plant in de badkamer drinkt veel, klopt het dat het zomer is?, '
		elseif (average_humidities_plant2 - hum_plant2.percentage > 3) then
			message = message .. 'De plant in de badkamer drinkt redelijk veel, klopt het dat het lente is?, '
		elseif (average_humidities_plant2 - hum_plant2.percentage < 3) then
			message = message .. 'De plant in de badkamer drinkt redelijk weinig, klopt het dat het winter of herfst is?, '
		end
		
		if (message) then
			domoticz.notify('Planten update', message, domoticz.PRIORITY_LOW)
		end		
	end
}
