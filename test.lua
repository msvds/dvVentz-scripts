-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = true,
	on = {
		timer = {'every minute'}
	},
	execute = function(domoticz)
		local Dakraamzolder = domoticz.devices(85)		
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)
		DeviceName = domoticz.devices(85).name
		--domoticz.globalData.ClosedC_Dakraamzolder = 0
		acc = domoticz.globalData.ClosedC_Dakraamzolder
		
		local count = domoticz.devices().reduce(function(acc, device)
		    if (device.name == DeviceName) then
				if (device.state == 'Closed') then					
					acc = acc + 1
					domoticz.log('If acc = ' ..acc)
				else
					acc = 0
					domoticz.log('else acc = ' ..acc)
				end
		    end
		    return acc
		end, 0)
		domoticz.log('ClosedC_Dakraamzolder: ' .. count)
		domoticz.globalData.ClosedC_Dakraamzolder = count		
	end
}
