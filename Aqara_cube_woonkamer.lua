return {
	active = true, -- set to false to disable this script
	logging = {marker = "Aqara_cube_woonkamer"},
	on = {
		devices = {'Aqara Cube woonkamer'},
	},

	execute = function(domoticz, device)
		if (device.state == 'flip90') then
			--activeer Normaal
			--domoticz.devices('Tradfri - Group - bar').dimTo(50)
			if (domoticz.devices('Fel licht').state == 'On') then								
				--activeer Normaal
				domoticz.devices('Tradfri - Group - bar').dimTo(50)
				domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
				domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
				domoticz.devices('Tradfri - Group - hal').dimTo(50)
				domoticz.devices('Tradfri - Group - entree').dimTo(50)
				domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
				domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
				domoticz.devices('Fel licht').setState('Off').silent()
				domoticz.devices('Zacht licht').setState('Off').silent()				
				domoticz.devices('Normaal licht').setState('On').silent()
			elseif (domoticz.devices('Zacht licht').state == 'On') then
				--activeer fel licht
				domoticz.devices('Tradfri - Group - bar').dimTo(100)
				domoticz.devices('Tradfri - Group - boven tv').dimTo(100)
				domoticz.devices('Tradfri - Group - keuken').dimTo(100)			
				domoticz.devices('Tradfri - Group - hal').dimTo(100)
				domoticz.devices('Tradfri - Group - entree').dimTo(100)
				domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(100)
				domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(100)
				domoticz.devices('Fel licht').setState('On').silent()
				domoticz.devices('Normaal licht').setState('Off').silent()
				domoticz.devices('Zacht licht').setState('Off').silent()
			elseif (domoticz.devices('Normaal licht').state == 'On') then
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
				domoticz.devices('Zacht licht').setState('On').silent()
			else
				--activeer Normaal
				domoticz.devices('Tradfri - Group - bar').dimTo(50)
				domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
				domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
				domoticz.devices('Tradfri - Group - hal').dimTo(50)
				domoticz.devices('Tradfri - Group - entree').dimTo(50)
				domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
				domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
				domoticz.devices('Fel licht').setState('Off').silent()
				domoticz.devices('Zacht licht').setState('Off').silent()
			end
		elseif (device.state == 'flip180') then
			--deactiveer Normaal, normaal uit
			--domoticz.devices('Tradfri - Group - bar').dimTo(5)
			
			domoticz.devices('Fel licht').setState('Off')
			domoticz.devices('Zacht licht').setState('Off')
			domoticz.devices('Normaal licht').setState('Off')
		elseif (device.state == 'rotate') then
		elseif (device.state == 'move') then
		elseif (device.state == 'tap_twice') then
		elseif (device.state == 'shake_air') then
		elseif (device.state == 'alert') then
		end
	end
}
