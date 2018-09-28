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
		domoticz.devices('Leeslamp Lars').switchOn().forSec(20).afterSec(2)
		domoticz.devices('Leeslamp Lars').switchOff().afterSec(30)
		domoticz.log('Lars lampen uitgezet',domoticz.LOG_INFO)
	end
}
