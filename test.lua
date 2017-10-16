-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = false,
	on = {
		timer = {'every minute'}
	},
	execute = function(domoticz)
		local Dakraamzolder = domoticz.devices(85)		
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)
		DeviceName = domoticz.devices(85).name
		--domoticz.globalData.ClosedC_Dakraamzolder = 0
		acc = tonumber(domoticz.globalData.ClosedC_Dakraamzolder)
		
		local count = domoticz.devices().reduce(function(acc, device)
		    if (device.name == DeviceName) then
				if (device.state == 'Closed') then					
					domoticz.log('If acc = ' ..acc)
					acc = acc + 1
					domoticz.log('If acc = ' ..acc)
				else
					acc = 0
					domoticz.log('else acc = ' ..acc)
				end
		    end
		    return acc
		end, acc)
		domoticz.log('ClosedC_Dakraamzolder: ' .. count)
		domoticz.globalData.ClosedC_Dakraamzolder = count		
	end
}
