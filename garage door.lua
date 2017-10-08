-- Send a warning when the garage door has been open for more than 30 minutes
return {
	active = true,
	on = {
		['timer'] = 'every minute',
	},
	execute = function(domoticz)
		local door = domoticz.devices['Garage deur']
		if (door.state == 'Open' and door.lastUpdate.minutesAgo > 30) then
			domoticz.notify('Garage deur alarm','De garage deur is voor meer dan 30 minuten open!',domoticz.PRIORITY_LOW)
		end
	end
}
