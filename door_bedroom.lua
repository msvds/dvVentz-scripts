return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 5 minutes'},
		--devices = {'Test Switch'},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		local Open_timeout_floor2 = 10
		local Temperature_limit = '12'
		message_interval = 60
		domoticz.globalData.door_bedroom_message_interval = domoticz.globalData.door_bedroom_message_interval + 1  
		debug = true
		if debug == true then 
			domoticz.log('domoticz.globalData.OpenC_Slaapkdeur = ' ..domoticz.globalData.OpenC_Slaapkdeur,domoticz.LOG_INFO)
			domoticz.log('Open_timeout_floor2 = ' ..Open_timeout_floor2,domoticz.LOG_INFO)
		end
		
		--Do something when outside temp > limit
		if tonumber(domoticz.devices('Temperatuur Buiten').temperature) >  tonumber(Temperature_limit) then
			if (domoticz.globalData.OpenC_Slaapkdeur > Open_timeout_floor2 and domoticz.globalData.door_bedroom_message_interval > message_interval) then
				domoticz.helpers.sendnotification(domoticz,'Slaapkamerdeur open','Deur slaapkamer open voor ' ..domoticz.globalData.OpenC_Slaapkdeur .. ' minuten.')
				--domoticz.helpers.flash_lights(domoticz, domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,3,5,5)
				domoticz.globalData.OpenC_Slaapkdeur = 0
			end
		end
	end
}
