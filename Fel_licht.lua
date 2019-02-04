return {
	active = true, -- set to false to disable this script
	logging = {marker = "Fel_licht"},
	on = {
		devices = {'Fel licht'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Fel licht').state == 'On') then
			--activeer sfeerlichten
			domoticz.devices('Tradfri - Group - bar').dimTo(100)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(100)
			domoticz.devices('Tradfri - Group - keuken').dimTo(100)			
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(100)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(100)
			domoticz.devices('Normaal licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
		else
			--deactiveer sfeerlichten, terug naar normaal
			domoticz.devices('Normaal licht').setState('On')
		end
	end
}
