-- Timer action

return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'at 00:10'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		-- woonkamer bij zonsondergang
		domoticz.helpers.switch_lights(domoticz,'Outside','Off')
		domoticz.log('Outside Lights turned off',domoticz.LOG_INFO)
	end
}
