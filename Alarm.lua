return {
	active = true, -- set to false to disable this script
	logging = {marker = "Alarm"},
	on = {
		devices = {'Alarm'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Alarm').state == 'On') then
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDAWAY) -- This will  the zone "My Home" to "Armed Away" after the default exit delay
			domoticz.log('Alarm aangezet',domoticz.LOG_INFO)
			domoticz.devices('Alarm').setState('Off').silent()
		else
			alarm.zones('My Home').disArmZone(domoticz)
			domoticz.log('Alarm uitgezet',domoticz.LOG_INFO)
			domoticz.devices('Alarm').setState('Off').silent()
		end
	end
}
