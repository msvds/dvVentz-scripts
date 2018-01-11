local alarm = require "ideAlarmModule"
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			alarm.zones('My Home').armingModeTextDevID
		},
	},
	execute = function(domoticz, device)

		-- Handle the Alarm Status Indicator
		if (device.id == alarm.zones('My Home').armingModeTextDevID) then
			if device.state == domoticz.SECURITY_DISARMED then 
				domoticz.devices('Xiaomi RGB Gateway eetkamer').switchOff() -- light off
				domoticz.devices('Xiaomi RGB Gateway hal boven').switchOff() -- light off
				domoticz.log('SECURITY DISARMED')
			else
				--domoticz.devices('Xiaomi RGB Gateway eetkamer').switchOn() -- Red light on
				--domoticz.devices('Xiaomi RGB Gateway hal boven').switchOn() -- Red light on
				domoticz.log('SECURITY ARMED')
			end
		end

	end
}
