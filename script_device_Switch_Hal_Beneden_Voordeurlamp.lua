return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Wireless Wall Switch Voordeurlamp'
		},
	},

	execute = function(domoticz, device)
		if domoticz.devices(33).state == 'On' then
			domoticz.devices(33).switchOff()
			domoticz.log('Voordeurlamp uitgezet',domoticz.LOG_INFO)
		elseif domoticz.devices(33).state == 'Off' then
			domoticz.devices(33).switchOn()
			domoticz.log('Voordeurlamp aangezet',domoticz.LOG_INFO)
		end	
	end
}
