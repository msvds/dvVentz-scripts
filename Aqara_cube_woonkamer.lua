return {
	active = true, -- set to false to disable this script
	logging = {marker = "Aqara_cube_woonkamer"},
	on = {
		devices = {'Aqara Cube woonkamer'},
	},

	execute = function(domoticz, device)
		if (device.state == 'flip90') then
			--activeer Normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
		elseif (device.state == 'flip180') then
			--deactiveer Normaal, normaal uit
			domoticz.devices('Tradfri - Group - bar').dimTo(5)
		elseif (device.state == 'rotate') then
		elseif (device.state == 'move') then
		elseif (device.state == 'tap_twice') then
		elseif (device.state == 'shake_air') then
		elseif (device.state == 'alert') then
		end
	end
}
