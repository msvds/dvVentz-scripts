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
		domoticz.log('lampen woonkamer aangezet ivm zonsondergang')
	end
}
