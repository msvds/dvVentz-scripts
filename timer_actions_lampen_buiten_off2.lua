-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'5 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.groups('Buitenlampen').switchOff().checkFirst()
		domoticz.log('lampen buiten uitgezet ivm zonsopgang en nacht')
	end
}
