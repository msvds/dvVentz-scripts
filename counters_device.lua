-- Counters for motion, no motion, open and closed windows/doors
-- When motion, no motion, open or closed windows/door are detected, the counters are set to 0 here
return {
	active = true,
	on = {
		devices = {25,81,83,107,116,153},
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
			domoticz.globalData.MC_Eetkamerdeur = 0
			domoticz.log('MC_Eetkamerdeur set to zero')
		end
		if (Dakraamslaapk == 'On') then
			domoticz.globalData.MC_Dakraamslaapk = 0
			domoticz.log('MC_Dakraamslaapk set to zero')
		end
		if (Balkondeurslaapk == 'On') then
			domoticz.globalData.MC_Balkondeurslaapk = 0
			domoticz.log('MC_Balkondeurslaapk set to zero')
		end
		if (Voordeur == 'On') then
			domoticz.globalData.MC_Voordeur = 0
			domoticz.log('MC_Voordeur set to zero')
		end
		if (BalkondeurNienke == 'On') then
			domoticz.globalData.MC_BalkondeurNienke = 0
			domoticz.log('MC_BalkondeurNienke set to zero')
		end
		if (Slaapkdeur == 'On') then
			domoticz.globalData.MC_Slaapkdeur = 0
			domoticz.log('MC_Slaapkdeur set to zero')
		end
		if (Dakraamzolder == 'On') then
			domoticz.globalData.MC_Dakraamzolder = 0
			domoticz.log('MC_Dakraamzolder set to zero')
		end
		if (PIR_woonk == 'On') then
			domoticz.globalData.MC_PIR_woonk = 0
			domoticz.log('MC_PIR_woonk set to zero')
		end
		if (PIR_kamerLars == 'On') then
			domoticz.globalData.MC_PIR_kamerLars = 0
			domoticz.log('MC_PIR_kamerLars set to zero')
		end
		if (PIR_halboven == 'On') then
			domoticz.globalData.MC_PIR_halboven = 0
			domoticz.log('MC_PIR_halboven set to zero')
		end
	end
}
