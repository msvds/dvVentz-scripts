-- Timer action

return {
	active = true, -- set to false to disable this script
	logging = {marker = "timer_actions_lampen_kamerlars"},
	on = {
		devices = {
			'Sw Lamp Lars'
		},
	},
	--on = {
	--	timer = {'at 20:50'}
	--},
	execute = function(domoticz, device)
		local Time = require('Time')
		domoticz.devices('Leeslamp Lars').switchOff()
		domoticz.devices('Single Wall Switch Lamp Lars').switchOff()	
		domoticz.devices('Leeslamp Lars').switchOn().forSec(2).repeatAfterSec(1, 3)
		domoticz.devices('Leeslamp Lars').switchOff().afterMin(2)
		domoticz.log('Lars lampen uitgezet',domoticz.LOG_INFO)
	end
}
