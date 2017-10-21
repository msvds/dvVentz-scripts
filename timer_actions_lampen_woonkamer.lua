-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'at sunset'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')
		local lampen_woonkamer = domoticz.groups(1)

		-- woonkamer bij zonsondergang
		if (lampen_woonkamer.state == 'Off') then
			lampen_woonkamer.switchOn()
			domoticz.log('lampen woonkamer aangezet ivm zonsondergang')
		end
	end
}
