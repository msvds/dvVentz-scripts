-- Send a warning when the garage door has been open for more than 30 minutes
-- Switch off when timeout is reached

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 10 minutes'},
		devices = {'Test Switch'},
	},
	execute = function(domoticz, device)
		testing_on = false
		local Open_timeout_outside = 10
		message_interval = 60
		domoticz.globalData.door_garage_message_interval = domoticz.globalData.door_garage_message_interval + 1  
		local Time = require('Time')
		debug = false
		if (domoticz.devices('Garage deur').state == 'Open' and domoticz.devices('Garage deur').lastUpdate.minutesAgo > 30) then
			if ((domoticz.globalData.OpenC_domoticz.devices('Garage deur') > Open_timeout_outside and domoticz.globalData.door_garage_message_interval > message_interval) or (test == true and domoticz.devices('Test Switch').state == 'On')) then
				domoticz.helpers.sendnotification(domoticz,'Garage deur alarm','De garage deur is voor meer dan 30 minuten open!',domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,3,3,5)
				domoticz.globalData.OpenC_domoticz.devices('Garage deur') = 0
			end
		end
	end
}
