return {
	active = false,
	on = {
		devices = {
			'DISARM ALL ZONES' -- You'd need a switch named like this for this example to work
		}
	},
	execute = function(domoticz, device)
		if device.state == 'On' then
			local alarm = require "ideAlarmModule"
			for i=1, alarm.qtyAlarmZones() do
				alarm.zones(i).disArmZone(domoticz)
			end
		end
	end
}
