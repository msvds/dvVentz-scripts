local devicesToCheck = {
	{ ['idx'] = 25 , ['threshold'] = 30 },
	{ ['idx'] = 81 , ['threshold'] = 30 },
	{ ['idx'] = 83 , ['threshold'] = 30 },
	{ ['idx'] = 107 , ['threshold'] = 30 },
	{ ['idx'] = 116 , ['threshold'] = 30 },
	{ ['idx'] = 153 , ['threshold'] = 30 },
	{ ['idx'] = 85 , ['threshold'] = 30 },
	{ ['idx'] = 105 , ['threshold'] = 30 },
	{ ['idx'] = 23 , ['threshold'] = 30 },
	{ ['idx'] = 66 , ['threshold'] = 30 },
	{ ['idx'] = 119 , ['threshold'] = 30 },
	{ ['idx'] = 67 , ['threshold'] = 30 },
	{ ['idx'] = 101 , ['threshold'] = 30 },
	{ ['idx'] = 91 , ['threshold'] = 30 }
}
return {
	active = true,
	logging = {marker = "check_dead_devices"},
	on = {
		['timer'] = 'every 5 minutes'
	},
	execute = function(domoticz)

		local message=""

		for i, deviceToCheck in pairs(devicesToCheck) do
			local idx = deviceToCheck['idx']
			local threshold = deviceToCheck['threshold']
			local minutes = domoticz.devices[idx].lastUpdate.minutesAgo
			local name = domoticz.devices[idx].name

			if ( minutes > threshold) then
				message = message .. 'Device ' ..
						name .. ' seems to be dead. No heartbeat for at least ' ..
						minutes .. ' minutes.\r'
			end
		end

		if (string.len(message) > 5 and domoticz.devices('Notifications').level == 20) then			
			domoticz.log('Dead devices found: ' .. message, domoticz.LOG_ERROR)
			domoticz.notify('Dead devices','Dead devices found: ' .. message,domoticz.PRIORITY_LOW)
			domoticz.devices('Status Notifications').updateText(message).silent()
		end
	end
}
