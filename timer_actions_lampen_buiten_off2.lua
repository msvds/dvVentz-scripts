-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'5 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')
		local lampen_buiten = domoticz.groups(2)

		-- woonkamer bij zonsondergang
		if (lampen_buiten.state == 'On') then
			lampen_buiten.switchOff()
			domoticz.log('lampen buiten uitgezet ivm zonsopgang en nacht')
		end
	end
}
