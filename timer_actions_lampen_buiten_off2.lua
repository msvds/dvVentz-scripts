-- Timer action

return {
	active = false, -- set to false to disable this script
	on = {
		timer = {'5 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')

		domoticz.helpers.switch_lights(domoticz,'Outside','Off')
		domoticz.log('Outside Lights turned off ivm zonsopgang',domoticz.LOG_INFO)
	end
}
