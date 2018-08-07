return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 4 hours'}
	},
	data = {
		plant1 = { history = true, maxItems = 42 },
		plant2 = { history = true, maxItems = 42 }
        },
	execute = function(domoticz, device)
		local message = ''
		
		-- add new data
		domoticz.data.plant1.add(domoticz.devices('plant moisture 1').percentage)
		domoticz.data.plant2.add(domoticz.devices('plant moisture 2').percentage)

		-- average over 42 items each 4 hours (1 week)
		local average_humidities_plant1  = domoticz.data.plant1.avg()
		local average_humidities_plant2  = domoticz.data.plant2.avg()
		
		debug = true
		if debug == true then 
			domoticz.log('start kamerplanten.lua')
			domoticz.log('average_humidities_plant1 = ' ..average_humidities_plant1)
			domoticz.log('average_humidities_plant2 = ' ..average_humidities_plant2)
		end
		
		if (domoticz.devices('plant moisture 1').percentage < 25) then				
        	message = message .. 'De plant in de hal boven begint heel erg droog te worden (<25%), namelijk ' ..tonumber(domoticz.devices('plant moisture 1').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 1').percentage < 35) then				
        	message = message .. 'De plant in de hal boven begint erg droog te worden (<35%), namelijk ' ..tonumber(domoticz.devices('plant moisture 1').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 1').percentage < 40) then				
        	message = message .. 'De plant in de hal boven begint droog te worden (<40%), namelijk ' ..tonumber(domoticz.devices('plant moisture 1').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 1').percentage < 50) then				
        	message = message .. 'De plant in de hal boven begint een beetje droog te worden (<50%), namelijk ' ..tonumber(domoticz.devices('plant moisture 1').percentage) .. '), '
		end
    
		if (domoticz.devices('plant moisture 2').percentage < 5) then				
			message = message .. 'De plant in de badkamer begint heel erg droog te worden (<5%), namelijk ' ..tonumber(domoticz.devices('plant moisture 2').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 2').percentage < 10) then				
			message = message .. 'De plant in de badkamer begint erg droog te worden (<10%), namelijk ' ..tonumber(domoticz.devices('plant moisture 2').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 2').percentage < 15) then				
			message = message .. 'De plant in de badkamer begint droog te worden (<15%), namelijk ' ..tonumber(domoticz.devices('plant moisture 2').percentage) .. '), '
		elseif (domoticz.devices('plant moisture 2').percentage < 20) then				
			message = message .. 'De plant in de badkamer begint een beetje droog te worden (<20%), namelijk ' ..tonumber(domoticz.devices('plant moisture 2').percentage) .. '), '
		end
		
		--if (average_humidities_plant1 - domoticz.devices('plant moisture 1').percentage > 6) then
		--	message = message .. 'De plant in de hal boven drinkt veel, klopt het dat het zomer is?, '
		--elseif (average_humidities_plant1 - domoticz.devices('plant moisture 1').percentage > 4) then
		--	message = message .. 'De plant in de hal boven drinkt redelijk veel, klopt het dat het lente is?, '
		--elseif (average_humidities_plant1 - domoticz.devices('plant moisture 1').percentage < 4) then
		--	message = message .. 'De plant in de hal boven drinkt redelijk weinig, klopt het dat het winter of herfst is?, '
		--end

		--if (average_humidities_plant2 - domoticz.devices('plant moisture 2').percentage > 4) then
		--	message = message .. 'De plant in de badkamer drinkt veel, klopt het dat het zomer is?, '
		--elseif (average_humidities_plant2 - domoticz.devices('plant moisture 2').percentage > 2) then
		--	message = message .. 'De plant in de badkamer drinkt redelijk veel, klopt het dat het lente is?, '
		--elseif (average_humidities_plant2 - domoticz.devices('plant moisture 2').percentage < 2) then
		--	message = message .. 'De plant in de badkamer drinkt redelijk weinig, klopt het dat het winter of herfst is?, '
		--end
		
		domoticz.devices('Status Notifications').updateText(message).silent()
		if (string.len(message) > 5 and domoticz.devices('Notifications').level == 20) then
			domoticz.notify('Planten update', message, domoticz.PRIORITY_LOW)
		end		
	end
}
