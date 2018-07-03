return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Kattenluikje'},
		timer = {'at 10:00'}
	},
	data = {
	   counter = { initial = 0 }
   },
	execute = function(domoticz, device)
		local Time = require('Time')
		if (domoticz.time.matchesRule('at 9:59-10:01') then
			if (domoticz.data.counter = 0) then
				domoticz.helpers.sendnotification(domoticz,'Kattenluikje','De laatste tijd is het kattenluikje niet gebruikt, check even of alles goed werkt')
				domoticz.log('De laatste tijd is het kattenluikje niet gebruikt, check even of alles goed werkt')
			else
				domoticz.helpers.sendnotification(domoticz,'Kattenluikje','Het kattenluikje is de afgelopen 24 uur ' ..domoticz.data.counter .. 'x gebruikt.')
				domoticz.log('Het kattenluikje is de afgelopen 24 uur ' ..domoticz.data.counter .. 'x gebruikt.')
			end
			domoticz.data.counter = 0 -- reset the counter
		else
			if (domoticz.devices('Kattenluikje').lastUpdate.minutesAgo > 2) then
				domoticz.data.counter = domoticz.data.counter + 1
				domoticz.log('De laatste tijd is het kattenluikje niet gebruikt, check even of alles goed werkt')
			end
		end
	end
}
