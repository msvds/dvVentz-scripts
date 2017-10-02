-- Counters for motion, no motion, open and closed windows/doors
-- When motion, no motion, open or closed windows/door are detected, the counters are set to 0 here
return {
	active = true,
	on = {
		devices = {25},
	},
	execute = function(domoticz)
            local Eetkamerdeur = domoticz.devices(25)
			if (Eetkamerdeur == 'On') then
				domoticz.globalData.MC_Eetkamerdeur = 0
			end
	end
}
