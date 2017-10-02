-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = true,
	on = {
		['timer'] = 'every minute'
	},
	execute = function(domoticz)
		local Eetkamerdeur = domoticz.devices(25)
		local Dakraamslaapk = domoticz.devices(81)
		if (Eetkamerdeur == 'On') then
			domoticz.globalData.MC_Eetkamerdeur = domoticz.globalData.MC_Eetkamerdeur + 1
			domoticz.log('MC_Eetkamerdeur = ' ..domoticz.globalData.MC_Eetkamerdeur)
		else
			domoticz.globalData.NMC_Eetkamerdeur = domoticz.globalData.NMC_Eetkamerdeur + 1
			domoticz.log('NMC_Eetkamerdeur = ' ..domoticz.globalData.NMC_Eetkamerdeur)
		end
		if (Dakraamslaapk == 'On') then
			domoticz.globalData.MC_Dakraamslaapk = domoticz.globalData.MC_Dakraamslaapk + 1
			domoticz.log('MC_Dakraamslaapk = ' ..domoticz.globalData.MC_Dakraamslaapk)
		else
			domoticz.globalData.NMC_Dakraamslaapk = domoticz.globalData.NMC_Dakraamslaapk + 1
			domoticz.log('NMC_Dakraamslaapk = ' ..domoticz.globalData.NMC_Dakraamslaapk)
		end
	end
}
