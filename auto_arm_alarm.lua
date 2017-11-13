return {
	active = true,
	},
	on = {
		devices = {
			'SomeoneHome',
		},
	},
	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		if (device.name == 'SomeoneHome' and device.state == 'On') then
			alarm.zones('My Home').disArmZone(domoticz) -- This will disarm the zone "My Home"
		elseif (device.name == 'SomeoneHome' and device.state == 'Off') then
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDAWAY) -- This will  the zone "My Home" to "Armed Away" after the default exit delay
		end

	end
}
