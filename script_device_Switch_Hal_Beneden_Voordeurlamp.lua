return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Wireless Wall Switch Voordeurlamp'
		},
	},

	execute = function(domoticz, device)
		if domoticz.devices('Voordeurlamp').state == 'On' then
			domoticz.devices('Voordeurlamp').switchOff()
			domoticz.log('Voordeurlamp uitgezet',domoticz.LOG_INFO)
		elseif domoticz.devices('Voordeurlamp').state == 'Off' then
			domoticz.devices('Voordeurlamp').switchOn()
			domoticz.log('Voordeurlamp aangezet',domoticz.LOG_INFO)
		end	
	end
}
