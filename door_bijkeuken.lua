-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {91},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		testing_on = false
		local test_switch = domoticz.devices(91)
		local Open_timeout_floor1 = 10
		message_interval = 60
		local Status_selector = domoticz.devices(90)
		domoticz.globalData.door_bijkeuken_message_interval = domoticz.globalData.door_bijkeuken_message_interval + 1  
		local Time = require('Time')
		local lamp_hal_boven = domoticz.devices(151)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local schemerlamp_bank = domoticz.devices(16)
		local lamp_boven_tv = domoticz.devices(13)
		local temperature_bijkeuken = domoticz.devices(110)
		local temperature_woonk = domoticz.devices(20)
		debug = false
		if debug == true then 
			domoticz.log('temperature_woonk.temperature = ' ..temperature_woonk.temperature)
			domoticz.log('temperature_bijkeuken.temperature = ' ..temperature_bijkeuken.temperature)
			domoticz.log('domoticz.globalData.OpenC_Deurbijkeuken = ' ..domoticz.globalData.OpenC_Deurbijkeuken)
			domoticz.log('Open_timeout_floor1 = ' ..Open_timeout_floor1)
		end
		if ((temperature_woonk.temperature - temperature_bijkeuken.temperature > temp_diff) or (testing_on == true and test_switch.state == 'On'))  then
			if ((domoticz.globalData.OpenC_Deurbijkeuken > Open_timeout_floor1 and domoticz.globalData.door_bijkeuken_message_interval > message_interval and Status_selector == '40') or (testing_on == true and test_switch.state == 'On')) then			
				domoticz.helpers.sendnotification('Bijkeukendeur open','Deur bijkeuken open voor ' ..domoticz.globalData.OpenC_Deurbijkeuken .. ' minuten terwijl het koud is in de bijkeuken (' ..domoticz.round(temperature_bijkeuken.temperature,1) ..' graden). Graag deur sluiten.',schemerlamp_deur.state,lamp_spoelb_keuken.state,lamp_boven_tv.state,schemerlamp_bank.state,lamp_hal_boven.state,3,3,5)
				domoticz.globalData.OpenC_Deurbijkeuken = 0
			end
		end
	end
}
