-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = true,
	on = {
		['timer'] = 'every minute'
	},
	execute = function(domoticz)
		local Eetkamerdeur = domoticz.devices(25)
		local Dakraamslaapk = domoticz.devices(81)
		local Balkondeurslaapk = domoticz.devices(83)
		local Voordeur = domoticz.devices(107)
		local BalkondeurNienke = domoticz.devices(116)
		local Slaapkdeur = domoticz.devices(153)
		local Dakraamzolder = domoticz.devices(85)
		local PIR_woonk = domoticz.devices(23)		
		local PIR_kamerLars = domoticz.devices(66)
		local PIR_halboven = domoticz.devices(119)
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
		if (Balkondeurslaapk == 'On') then
			domoticz.globalData.MC_Balkondeurslaapk = domoticz.globalData.MC_Balkondeurslaapk + 1
			domoticz.log('MC_Balkondeurslaapk = ' ..domoticz.globalData.MC_Balkondeurslaapk)
		else
			domoticz.globalData.NMC_Balkondeurslaapk = domoticz.globalData.NMC_Balkondeurslaapk + 1
			domoticz.log('NMC_Balkondeurslaapk = ' ..domoticz.globalData.NMC_Balkondeurslaapk)
		end
		if (Voordeur == 'On') then
			domoticz.globalData.MC_Voordeur = domoticz.globalData.MC_Voordeur + 1
			domoticz.log('MC_Voordeur = ' ..domoticz.globalData.MC_Voordeur)
		else
			domoticz.globalData.NMC_Voordeur = domoticz.globalData.NMC_Voordeur + 1
			domoticz.log('NMC_Voordeur = ' ..domoticz.globalData.NMC_Voordeur)
		end
		if (BalkondeurNienke == 'On') then
			domoticz.globalData.MC_BalkondeurNienke = domoticz.globalData.MC_BalkondeurNienke + 1
			domoticz.log('MC_BalkondeurNienke = ' ..domoticz.globalData.MC_BalkondeurNienke)
		else
			domoticz.globalData.NMC_BalkondeurNienke = domoticz.globalData.NMC_BalkondeurNienke + 1
			domoticz.log('NMC_BalkondeurNienke = ' ..domoticz.globalData.NMC_BalkondeurNienke)
		end
		if (Slaapkdeur == 'On') then
			domoticz.globalData.MC_Slaapkdeur = domoticz.globalData.MC_Slaapkdeur + 1
			domoticz.log('MC_Slaapkdeur = ' ..domoticz.globalData.MC_Slaapkdeur)
		else
			domoticz.globalData.NMC_Slaapkdeur = domoticz.globalData.NMC_Slaapkdeur + 1
			domoticz.log('NMC_Slaapkdeur = ' ..domoticz.globalData.NMC_Slaapkdeur)
		end
		if (Dakraamzolder == 'On') then
			domoticz.globalData.MC_Dakraamzolder = domoticz.globalData.MC_Dakraamzolder + 1
			domoticz.log('MC_Dakraamzolder = ' ..domoticz.globalData.MC_Dakraamzolder)
		else
			domoticz.globalData.NMC_Dakraamzolder = domoticz.globalData.NMC_Dakraamzolder + 1
			domoticz.log('NMC_Dakraamzolder = ' ..domoticz.globalData.NMC_Dakraamzolder)
		end
		
		if (PIR_woonk == 'On') then
			domoticz.globalData.MC_PIR_woonk = domoticz.globalData.MC_PIR_woonk + 1
			domoticz.log('MC_PIR_woonk = ' ..domoticz.globalData.MC_PIR_woonk)
		else
			domoticz.globalData.NMC_PIR_woonk = domoticz.globalData.NMC_PIR_woonk + 1
			domoticz.log('NMC_PIR_woonk = ' ..domoticz.globalData.NMC_PIR_woonk)
		end
		
		if (PIR_kamerLars  == 'On') then
			domoticz.globalData.MC_PIR_kamerLars  = domoticz.globalData.MC_PIR_kamerLars + 1
			domoticz.log('MC_PIR_kamerLars = ' ..domoticz.globalData.MC_PIR_kamerLars)
		else
			domoticz.globalData.NMC_PIR_kamerLars = domoticz.globalData.NMC_PIR_kamerLars + 1
			domoticz.log('NMC_PIR_kamerLars = ' ..domoticz.globalData.NMC_PIR_kamerLars)
		end
		
		if (PIR_halboven  == 'On') then
			domoticz.globalData.MC_PIR_halboven  = domoticz.globalData.MC_PIR_halboven + 1
			domoticz.log('MC_PIR_halboven = ' ..domoticz.globalData.MC_PIR_halboven)
		else
			domoticz.globalData.NMC_PIR_halboven = domoticz.globalData.NMC_PIR_halboven + 1
			domoticz.log('NMC_PIR_halboven = ' ..domoticz.globalData.NMC_PIR_halboven)
		end
	end
}
