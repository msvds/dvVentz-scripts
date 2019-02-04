return {
	active = true, -- set to false to disable this script
	logging = {marker = "Normaal_licht"},
	on = {
		devices = {'Normaal licht'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Normaal licht').state == 'On') then
			--activeer Normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
			domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
			domoticz.devices('Fel licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
		else
			--deactiveer Normaal, normaal uit
			domoticz.devices('Tradfri - Group - bar').switchOff()
			domoticz.devices('Tradfri - Group - boven tv').switchOff()
			domoticz.devices('Tradfri - Group - keuken').switchOff()		
			domoticz.devices('Yeelight Dimmer eetkamer 1').switchOff()
			domoticz.devices('Yeelight Dimmer eetkamer 2').switchOff()
			domoticz.devices('Fel licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
		end
	end
}
