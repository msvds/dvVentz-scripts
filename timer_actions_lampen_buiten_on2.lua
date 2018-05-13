-- Timer action

return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'at 06:10'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		if (domoticz.devices('IsDonker (virt)').state == 'Off') then
			domoticz.groups('Buitenlampen').switchOn().checkFirst()
			domoticz.log('lampen buiten aangezet ivm zonsondergang en ochtends')
		
		else
			domoticz.groups('Buitenlampen').switchOff().checkFirst()
		end
	end
}
