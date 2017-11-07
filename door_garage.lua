-- Send a warning when the garage door has been open for more than 30 minutes
-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {91},
	},
	execute = function(domoticz, device)
		testing_on = false
		local test_switch = domoticz.devices(91)
		local Open_timeout_outside = 10
		message_interval = 60
		local Status_selector = domoticz.devices(90)
		domoticz.globalData.door_garage_message_interval = domoticz.globalData.door_garage_message_interval + 1  
		local Time = require('Time')
		local lamp_hal_boven = domoticz.devices(151)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local schemerlamp_bank = domoticz.devices(16)
		local lamp_boven_tv = domoticz.devices(13)
		local Deurgarage = domoticz.devices(105)
		debug = false
		if (Deurgarage.state == 'Open' and door.lastUpdate.minutesAgo > 30) then
			if ((domoticz.globalData.OpenC_Deurgarage > Open_timeout_outside and domoticz.globalData.door_garage_message_interval > message_interval) or (test == true and test_switch.state == 'On')) then
				domoticz.helpers.sendnotification('Garage deur alarm','De garage deur is voor meer dan 30 minuten open!',schemerlamp_deur.state,lamp_spoelb_keuken.state,lamp_boven_tv.state,schemerlamp_bank.state,lamp_hal_boven.state,3,3,5)
				domoticz.globalData.OpenC_Deurgarage = 0
			end
		end
	end
}

