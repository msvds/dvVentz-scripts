-- Timer action

return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'at 06:10'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.groups('Buitenlampen').switchOn().checkFirst()
		domoticz.log('lampen buiten aangezet ivm zonsondergang en ochtends')
	end
}
