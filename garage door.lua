--Send a warning when the garage door has been open for more than 30 minutes

return {
	active = true,
	on = {
		['timer'] = 'every minute',
	},
	execute = function(domoticz)

		local garagedoor = domoticz.devices[105]

		if (garagedoor.state == 'Open' and garagedoor.lastUpdate.minutesAgo > 30) then
			domoticz.notify('Garage door alert',
				'The garage door has been open for more than 10 minutes!',
				domoticz.PRIORITY_HIGH)
		end
	end
}
