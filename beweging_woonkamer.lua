return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Beweging woonkamer 1','Beweging woonkamer 2'
		}
	},
	execute = function(domoticz, device)
		if (domoticz.devices('Beweging woonkamer 1').state == 'On' or domoticz.devices('Beweging woonkamer 2').state == 'On') then
			domoticz.devices('Beweging woonkamer').switchOn()
			domoticz.log('Beweging woonkamer')
		else
			domoticz.devices('Beweging woonkamer').switchOff()
			domoticz.log('Stop beweging woonkamer')
		end
	end
}
