-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {91},
	},
	execute = function(domoticz, device)
		local temp_diff = 7
		test = false
		local test_switch = domoticz.devices(91)
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
		debug = false
		if debug == true then 
			domoticz.log('domoticz.globalData.OpenC_Slaapkdeur = ' ..domoticz.globalData.OpenC_Slaapkdeur)
			domoticz.log('Open_timeout_floor2 = ' ..Open_timeout_floor2)
		end		
		if ((domoticz.time.months == 5 or domoticz.time.months == 6 or domoticz.time.months == 7 or domoticz.time.months == 8 or domoticz.time.months == 9) or (test == true and test_switch.state == 'On')) then
			if ((domoticz.globalData.OpenC_Slaapkdeur > Open_timeout_floor2 and domoticz.globalData.Open_timeout_message_interval > message_interval and Status_selector == '40') or (test == true and test_switch.state == 'On')) then
				sendnotification('Slaapkamerdeur open','Deur slaapkamer open voor ' ..domoticz.globalData.OpenC_Slaapkdeur .. ' minuten.', schemerlamp_deur.state,lamp_spoelb_keuken.state,lamp_boven_tv.state,schemerlamp_bank.state,lamp_hal_boven.state,3,5,5)
				domoticz.globalData.OpenC_Slaapkdeur = 0
			end
		end
	end
}
