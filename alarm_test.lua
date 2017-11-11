return {
	active = true,
	logging = {
		level = domoticz.LOG_INFO,
		marker = "TEST"
	},
	on = {
		devices = {
			'Test Switch',
		},
	},
	execute = function(domoticz, device)
		if device.state == 'On' then
			local alarm = require "ideAlarmModule"
			domoticz.log(alarm.statusAll(domoticz))
		end
	end
}