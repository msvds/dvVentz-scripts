local alarm = require "ideAlarmModule"

return {
	active = true,
	},
	on = {
		devices = {
			alarm.zones('My Home').armingModeTextDevID
		},
	},
	execute = function(domoticz, device)

		-- Handle the Alarm Status Indicator
		if (device.id == alarm.zones('My Home').armingModeTextDevID) then
			if device.state == domoticz.SECURITY_DISARMED then 
				domoticz.devices('Xiaomi RGB Gateway').switchOn() -- Red light on
				domoticz.log('Alarm on')
			else
				domoticz.devices('Xiaomi RGB Gateway').switchOff() -- light off
				domoticz.log('Alarm off')
			end
		end

	end
}
