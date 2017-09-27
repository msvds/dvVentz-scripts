return {
	active = true,
	on = {
		['timer'] = 'every minute'
	},
	execute = function(domoticz)
            domoticz.globalData.MC_Eetkamerdeur = domoticz.globalData.MC_Eetkamerdeur + 1
	end
}
