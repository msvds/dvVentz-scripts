-- Timer action

return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'at sunset'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.helpers.switch_lights(domoticz,'Woonkamer','Off')
		domoticz.log('lampen woonkamer aangezet ivm zonsondergang', domoticz.LOG_INFO)
		domoticz.helpers.switch_lights(domoticz,'Woonkamer','On')
		domoticz.log('Lamp spoelbak keuken aangezet ivm zonsondergang', domoticz.LOG_INFO)
	end
}
