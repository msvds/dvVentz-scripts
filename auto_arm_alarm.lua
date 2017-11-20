return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'SomeoneHome',
		},
		timer = {
			'at 6:00'
		}
	},
	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		local Time = require('Time')
		if (device.name == 'SomeoneHome' and device.state == 'On') then
			if alarm.zones('My Home').armingMode(domoticz) ~= nil then domoticz.log(alarm.zones('My Home').armingMode(domoticz)) end
			if domoticz.SECURITY_DISARMED ~= nil then domoticz.log(domoticz.SECURITY_DISARMED) end
			if domoticz.time.hours ~= nil then domoticz.log(domoticz.time.hours) end
			if (alarm.zones('My Home').armingMode(domoticz) ~= domoticz.SECURITY_DISARMED and domoticz.time.matchesRule('at 6:00-23:00')) then
				alarm.zones('My Home').disArmZone(domoticz)
			end
			--alarm.zones('My Home').disArmZone(domoticz) -- This will disarm the zone "My Home"
		elseif (device.name == 'SomeoneHome' and device.state == 'Off') then
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDAWAY) -- This will  the zone "My Home" to "Armed Away" after the default exit delay
		end
	end
}
