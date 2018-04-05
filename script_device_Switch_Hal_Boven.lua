return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Single Wall Switch Hal Boven'
		},
	},

	execute = function(domoticz, device)
		if device.state == 'On' then		
			domoticz.devices('Lampen zolder').switchOn().checkFirst()	
			domoticz.log('Lampen zolder aangezet')
		elseif device.state == 'Off' then
			domoticz.devices('Lampen zolder').switchOff().checkFirst()
			domoticz.log('Lampen zolder uitgezet')
		end		
	end
}
