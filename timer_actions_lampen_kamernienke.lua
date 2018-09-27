-- Timer action

return {
	active = true, -- set to false to disable this script
	logging = {marker = "timer_actions_lampen_kamernienke"},
	on = {
		timer = {'at 20:20'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')
		domoticz.devices('Leeslamp Nienke').switchOff()
		domoticz.devices('Leeslamp Nienke').switchOn().forSec(20).repeatAfterSec(2, 3)
		domoticz.devices('Leeslamp Nienke').switchOff().afterMin(2)
		domoticz.log('Nienke lampen uitgezet',domoticz.LOG_INFO)
	end
}
