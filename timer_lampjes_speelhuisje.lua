return {
	active = true,
	logging = {marker = "timer_lampjes_speelhuisje"},
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')		
		if (domoticz.time.matchesRule('at 15:00-22:30') and domoticz.devices('SomeoneHome').state == 'On') then				
			if (domoticz.devices('Lampjes speelhuisje').lastUpdate.minutesAgo > 3) then
				domoticz.devices('Lampjes speelhuisje').switchOn().checkFirst()
			end
			domoticz.log('Lampjes speelhuisje aangezet,domoticz.LOG_INFO)
		elseif (domoticz.time.matchesRule('at 7:15-8:00') and domoticz.devices('SomeoneHome').state == 'On') then			
			if (domoticz.devices('Lampjes speelhuisje').lastUpdate.minutesAgo > 3) then
				domoticz.devices('Lampjes speelhuisje').switchOn().checkFirst()
			end
			domoticz.log('Lampjes speelhuisje aangezet,domoticz.LOG_INFO)
		else
			domoticz.devices('Lampjes speelhuisje').switchOff().checkFirst()
			domoticz.log('Lampjes speelhuisje uitgezet,domoticz.LOG_INFO)
		end
	end
}
