local BATTERY_THRESHOLD = 10

return {
	active = true,
	logging = {marker = "check_battery_levels"},
	on = {
		['timer'] = 'every hour'
	},
	execute = function(domoticz)

		local message

		-- first filter on low battery level
		local lowOnBat = domoticz.devices.filter(function(device)

			local level = device.batteryLevel
			return (level ~= nil and -- not all devices have this attribute
					level ~= 255 and -- probably means something like 'not applicable'
					level <= BATTERY_THRESHOLD)

		end)

		-- then loop over the results
		lowOnBat.forEach(function(lowDevice)

			message = message .. 'Device ' ..
					lowDevice.name .. ' is low on batteries (' .. lowDevice.batteryLevel .. '), '

		end)

		if (string.len(message) > 5 and domoticz.devices('Notifications').level == 20) then
			domoticz.notify('Low battery warning', message, domoticz.PRIORITY_NORMAL)
			domoticz.log('Low battery warning: ' .. message, domoticz.LOG_ERROR)
			domoticz.devices('Status Notifications').updateText(message).silent()
		end
	end
}
