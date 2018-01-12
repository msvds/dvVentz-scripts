-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'at 00:10'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.groups('Buitenlampen').switchOff().checkFirst()
		domoticz.log('lampen buiten uitgezet ivm nacht')
	end
}
