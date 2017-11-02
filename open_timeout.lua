-- Switch off when timeout is reached

return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {91},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		test = false
		local test_switch = domoticz.devices(91)
		local Open_timeout_floor1 = 10
		local Open_timeout_floor2 = 10
		message_interval = 60
		local Status_selector = domoticz.devices(90)
		domoticz.globalData.Open_timeout_message_interval = domoticz.globalData.Open_timeout_message_interval + 1  
		local Time = require('Time')
		local lamp_hal_boven = domoticz.devices(151)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local schemerlamp_bank = domoticz.devices(16)
		local lamp_boven_tv = domoticz.devices(13)
		local temperature_bijkeuken = domoticz.devices(110)
		local temperature_woonk = domoticz.devices(20)
		start_state_schemerlamp_deur = schemerlamp_deur.state
		start_state_lamp_spoelb_keuken = lamp_spoelb_keuken.state
		start_state_lamp_boven_tv = lamp_boven_tv.state
		start_state_schemerlamp_bank = schemerlamp_bank.state
		start_state_lamp_hal_boven = lamp_hal_boven.state
		debug = false
		if debug == true then 
			domoticz.log('temperature_woonk.temperature = ' ..temperature_woonk.temperature)
			domoticz.log('temperature_bijkeuken.temperature = ' ..temperature_bijkeuken.temperature)
			domoticz.log('domoticz.globalData.OpenC_Deurbijkeuken = ' ..domoticz.globalData.OpenC_Deurbijkeuken)
			domoticz.log('Open_timeout_floor1 = ' ..Open_timeout_floor1)
		end
		if ((temperature_woonk.temperature - temperature_bijkeuken.temperature > temp_diff) or (test == true and test_switch.state == 'On'))  then
			if ((domoticz.globalData.OpenC_Deurbijkeuken > Open_timeout_floor1 and domoticz.globalData.Open_timeout_message_interval > message_interval and Status_selector == '40') or (test == true and test_switch.state == 'On')) then			
				domoticz.notify('Bijkeukendeur open','Deur bijkeuken open voor ' ..domoticz.globalData.OpenC_Deurbijkeuken .. ' minuten terwijl het koud is in de bijkeuken (' ..domoticz.round(temperature_bijkeuken.temperature,1) ..' graden). Graag deur sluiten.', domoticz.LOG_INFO)
				schemerlamp_deur.switchOn().forSec(3).repeatAfterSec(5, 3)		
				lamp_spoelb_keuken.switchOn().forSec(3).repeatAfterSec(5, 3)		
				lamp_boven_tv.switchOn().forSec(3).repeatAfterSec(5, 3)	
				schemerlamp_bank.switchOn().forSec(3).repeatAfterSec(5, 3)				
				lamp_hal_boven.switchOn().forSec(1).repeatAfterSec(5, 3)
				if start_state_schemerlamp_deur == 'On' then
					schemerlamp_deur.switchOn().afterSec(30)
				else
					schemerlamp_deur.switchOff().afterSec(30)
				end
				if start_state_lamp_spoelb_keuken == 'On' then
					lamp_spoelb_keuken.switchOn().afterSec(30)
				else
					lamp_spoelb_keuken.switchOff().afterSec(30)
				end
				if start_state_lamp_boven_tv == 'On' then
					lamp_boven_tv.switchOn().afterSec(30)
				else
					lamp_boven_tv.switchOff().afterSec(30)
				end
				if start_state_schemerlamp_bank == 'On' then
					schemerlamp_bank.switchOn().afterSec(30)
				else
					schemerlamp_bank.switchOff().afterSec(30)
				end
				if start_state_lamp_hal_boven == 'On' then
					lamp_hal_boven.switchOn().afterSec(30)
				else
					lamp_hal_boven.switchOff().afterSec(30)
				end
				domoticz.globalData.OpenC_Deurbijkeuken = 0
			end
		end
		if ((domoticz.time.months == 5 or domoticz.time.months == 6 or domoticz.time.months == 7 or domoticz.time.months == 8 or domoticz.time.months == 9) or (test == true and test_switch.state == 'On')) then
			if ((domoticz.globalData.OpenC_Slaapkdeur > Open_timeout_floor2 and domoticz.globalData.Open_timeout_message_interval > message_interval and Status_selector == '40') or (test == true and test_switch.state == 'On')) then
				domoticz.notify('Deur slaapkamer open voor ' ..domoticz.globalData.OpenC_Slaapkdeur .. ' minuten.', domoticz.LOG_INFO)
				schemerlamp_deur.switchOn().forSec(5).repeatAfterSec(5,5)		
				lamp_spoelb_keuken.switchOn().forSec(5).repeatAfterSec(5,5)		
				lamp_boven_tv.switchOn().forSec(5).repeatAfterSec(5,5)	
				schemerlamp_bank.switchOn().forSec(5).repeatAfterSec(5,5)				
				lamp_hal_boven.switchOn().forSec(5).repeatAfterSec(5,5)
				if start_state_schemerlamp_deur == 'On' then
					schemerlamp_deur.switchOn().afterSec(30)
				else
					schemerlamp_deur.switchOff().afterSec(30)
				end
				if start_state_lamp_spoelb_keuken == 'On' then
					lamp_spoelb_keuken.switchOn().afterSec(30)
				else
					lamp_spoelb_keuken.switchOff().afterSec(30)
				end
				if start_state_lamp_boven_tv == 'On' then
					lamp_boven_tv.switchOn().afterSec(30)
				else
					lamp_boven_tv.switchOff().afterSec(30)
				end
				if start_state_schemerlamp_bank == 'On' then
					schemerlamp_bank.switchOn().afterSec(30)
				else
					schemerlamp_bank.switchOff().afterSec(30)
				end
				if start_state_lamp_hal_boven == 'On' then
					lamp_hal_boven.switchOn().afterSec(30)
				else
					lamp_hal_boven.switchOff().afterSec(30)
				end
				domoticz.globalData.OpenC_Slaapkdeur = 0
			end
		end
	end
}
