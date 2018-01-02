-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'at sunset'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
		domoticz.log('lampen woonkamer aangezet ivm zonsondergang', domoticz.LOG_INFO)
		domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()
		domoticz.log('Lamp spoelbak keuken aangezet ivm zonsondergang', domoticz.LOG_INFO)
	end
}
