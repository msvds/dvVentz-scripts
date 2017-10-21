-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'at 06:10'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')
		local lampen_buiten = domoticz.groups(2)

		-- woonkamer bij zonsondergang
		if (lampen_buiten.state == 'Off') then
			lampen_buiten.switchOn()
			domoticz.log('lampen buiten aangezet ivm zonsondergang en ochtends')
		end
	end
}
