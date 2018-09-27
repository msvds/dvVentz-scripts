return {
	active = true, -- set to false to disable this script
	logging = {marker = "script_device_Switch_Lamp_Lars"},
	on = {
		devices = {
			'Sw Lamp Lars'
		},
	},

	execute = function(domoticz, device)
		if (domoticz.time.matchesRule('at 7:00-21:00') then
			if device.state == 'Double Click' then
				if domoticz.devices('Single Wall Switch Lamp Lars').state == 'On' then
					if domoticz.devices('Leeslamp Lars').state == 'On' then
						domoticz.devices('Single Wall Switch Lamp Lars').switchOff()
						domoticz.devices('Leeslamp Lars').switchOn()
					else
						domoticz.devices('Single Wall Switch Lamp Lars').switchOff()
						domoticz.devices('Leeslamp Lars').switchOn()
					end
				else
					if domoticz.devices('Leeslamp Lars').state == 'On' then
						domoticz.devices('Single Wall Switch Lamp Lars').switchOn()
						domoticz.devices('Leeslamp Lars').switchOff()
					else
						domoticz.devices('Single Wall Switch Lamp Lars').switchOn()
						domoticz.devices('Leeslamp Lars').switchOff()
					end
				end	
			elseif device.state == 'Click' then
				domoticz.devices('Leeslamp Lars').switchOff()
				domoticz.devices('Single Wall Switch Lamp Lars').switchOff()
				domoticz.log('Lampen kamer Lars uitgezet',domoticz.LOG_INFO)
			elseif (device.state == 'Long Click') then
				domoticz.devices('Leeslamp Lars').switchOn()
				domoticz.devices('Single Wall Switch Lamp Lars').switchOn()	
				domoticz.log('Lampen kamer Lars aangezet',domoticz.LOG_INFO)
			end
		else
			domoticz.devices('Leeslamp Lars').switchOff()
			domoticz.devices('Single Wall Switch Lamp Lars').switchOff()
			domoticz.log('Lampen kamer Lars uitgezet',domoticz.LOG_INFO)
		end
	end
}
