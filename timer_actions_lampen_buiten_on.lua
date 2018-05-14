-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'5 minutes before sunset'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.groups('Buitenlampen').switchOn().checkFirst()
		domoticz.log('lampen buiten aangezet ivm zonsondergang en ochtends')

	end
}
