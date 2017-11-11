-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {'Test Switch'},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		testing_on = false
		local Open_timeout_floor1 = 10
		message_interval = 60
		domoticz.globalData.door_bijkeuken_message_interval = domoticz.globalData.door_bijkeuken_message_interval + 1  
		local Time = require('Time')
		debug = true
		if debug == true then 
			domoticz.log('domoticz.devices('Temperatuur woonkamer').temperature = ' ..domoticz.devices('Temperatuur woonkamer').temperature)
			domoticz.log('domoticz.devices('Temperatuur Bijkeuken').temperature = ' ..domoticz.devices('Temperatuur Bijkeuken').temperature)
			domoticz.log('domoticz.globalData.OpenC_Deurbijkeuken = ' ..domoticz.globalData.OpenC_Deurbijkeuken)
			domoticz.log('Open_timeout_floor1 = ' ..Open_timeout_floor1)
		end
		if ((domoticz.devices('Temperatuur woonkamer').temperature - domoticz.devices('Temperatuur Bijkeuken').temperature > temp_diff) or (testing_on == true and domoticz.devices('Test Switch').state == 'On'))  then
			--domoticz.log('temp_diff = ' ..temp_diff)
			--domoticz.log('domoticz.devices('Status').state = ' ..domoticz.devices('Status').state)
			if ((domoticz.globalData.OpenC_Deurbijkeuken > Open_timeout_floor1 and domoticz.globalData.door_bijkeuken_message_interval > message_interval and domoticz.devices('Status').state == 'Home') or (testing_on == true and domoticz.devices('Test Switch').state == 'On')) then			
			--if ((domoticz.globalData.OpenC_Deurbijkeuken > Open_timeout_floor1 and domoticz.globalData.door_bijkeuken_message_interval > message_interval) or (testing_on == true and domoticz.devices('Test Switch').state == 'On')) then	
				domoticz.helpers.sendnotification(domoticz,'Bijkeukendeur open','Deur bijkeuken open voor ' ..domoticz.globalData.OpenC_Deurbijkeuken .. ' minuten terwijl het koud is in de bijkeuken (' ..domoticz.round(domoticz.devices('Temperatuur Bijkeuken').temperature,1) ..' graden). Graag deur sluiten.',domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,3,3,5)
				domoticz.globalData.OpenC_Deurbijkeuken = 0
			end
		end
	end
}
