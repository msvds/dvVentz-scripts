return {
	active = true, -- set to false to disable this script
	logging = {marker = "Zacht licht"},
	on = {
		devices = {'Zacht licht'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Zacht licht').state == 'On') then
			--activeer sfeerlichten
			domoticz.devices('Tradfri - Group - bar').dimTo(10)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(10)
			domoticz.devices('Tradfri - Group - keuken').dimTo(10)			
			domoticz.devices('Tradfri - Group - hal').dimTo(10)
			domoticz.devices('Tradfri - Group - entree').dimTo(10)
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(10)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(10)
			domoticz.devices('Normaal licht').setState('Off').silent()			
			domoticz.devices('Fel licht').setState('Off').silent()
		else
			--deactiveer sfeerlichten, terug naar normaal
			domoticz.devices('Normaal licht').setState('On')			
		end
	end
}
