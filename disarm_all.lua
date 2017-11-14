return {
	active = false,
	on = {
		devices = {
			'Sw4' -- You'd need a switch named like this for this example to work
		}
	},
	execute = function(domoticz, device)
		if device.state == 'Click' then
			local alarm = require "ideAlarmModule"
			for i=1, alarm.qtyAlarmZones() do
				alarm.zones(i).disArmZone(domoticz)
			end
		end
	end
}
