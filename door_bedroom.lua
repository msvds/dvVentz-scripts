-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		--devices = {'Test Switch'},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		test = false
		local Open_timeout_floor2 = 10
		message_interval = 60
		domoticz.globalData.door_bedroom_message_interval = domoticz.globalData.door_bedroom_message_interval + 1  
		local Time = require('Time')
		debug = true
		if debug == true then 
			domoticz.log('domoticz.globalData.OpenC_Slaapkdeur = ' ..domoticz.globalData.OpenC_Slaapkdeur)
			domoticz.log('Open_timeout_floor2 = ' ..Open_timeout_floor2)
		end		
		if ((domoticz.time.months == 5 or domoticz.time.months == 6 or domoticz.time.months == 7 or domoticz.time.months == 8 or domoticz.time.months == 9) or (test == true and domoticz.devices('Test Switch').state == 'On')) then
			if ((domoticz.globalData.OpenC_Slaapkdeur > Open_timeout_floor2 and domoticz.globalData.door_bedroom_message_interval > message_interval and domoticz.devices('Status').state == 'Home') or (test == true and domoticz.devices('Test Switch').state == 'On')) then
				domoticz.helpers.sendnotification(domoticz,'Slaapkamerdeur open','Deur slaapkamer open voor ' ..domoticz.globalData.OpenC_Slaapkdeur .. ' minuten.')
				domoticz.helpers.flash_lights(domoticz, domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,3,5,5)
				domoticz.globalData.OpenC_Slaapkdeur = 0
			end
		end
	end
}
