return {
	active = false,
	on = {
		devices = {
			'Sw4' -- You'd need a switch named like this for this example to work
		}
	},
	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		if device.state == 'Click' then			
			for i=1, alarm.qtyAlarmZones() do
				alarm.zones(i).disArmZone(domoticz)
			end
		elseif device.state == 'Double Click' then
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDAWAY) -- This will  the zone "My Home" to "Armed Away" after the default exit delay
		end
	end
}
