return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw Lamp Lars'
		},
	},

	execute = function(domoticz, device)
		if device.state == 'Double Click' then
		elseif device.state == 'Click' then
			if domoticz.devices('Single Wall Switch Lamp Lars').state == 'On' then
				domoticz.devices('Single Wall Switch Lamp Lars').switchOff()
				domoticz.log('Lampen kamer Lars uitgezet',domoticz.LOG_INFO)
			elseif domoticz.devices('Single Wall Switch Lamp Lars').state == 'Off' then
				domoticz.devices('Single Wall Switch Lamp Lars').switchOn()	
				domoticz.log('Lampen kamer Lars aangezet',domoticz.LOG_INFO)
			end
		elseif (device.state == 'Long Click') then
		end	
	end
}
