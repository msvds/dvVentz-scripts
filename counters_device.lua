-- Counters for motion, no motion, open and closed windows/doors
-- When motion, no motion, open or closed windows/door are detected, the counters are set to 0 here
return {
	active = true,
	on = {
		devices = {25,81,83,107,116,153,85,23,66,119},
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
		domoticz.log('Dakraamzolder.state: ' ..Dakraamzolder.state)
		domoticz.log('domoticz.globalData.ClosedC_Dakraamslaapk: ' ..domoticz.globalData.ClosedC_Dakraamslaapk)		
		domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
		domoticz.log('PIR_halboven.state: ' ..PIR_halboven.state)
		
		if (Eetkamerdeur.state == 'Open') then
			domoticz.globalData.ClosedC_Eetkamerdeur = 0
			domoticz.globalData.ClosedC_Floor1 = 0			  
			domoticz.log('ClosedC_Eetkamerdeur & ClosedC_Floor1 set to zero')
		end
		if (Dakraamslaapk.state == 'Open') then
			domoticz.globalData.ClosedC_Dakraamslaapk = 0
			domoticz.globalData.ClosedC_Floor3 = 0
			domoticz.log('ClosedC_Dakraamslaapk & ClosedC_Floor3 set to zero')
		end
		if (Balkondeurslaapk.state == 'Open') then
			domoticz.globalData.ClosedC_Balkondeurslaapk = 0
			domoticz.globalData.ClosedC_Floor2 = 0
			domoticz.log('ClosedC_Balkondeurslaapk & ClosedC_Floor2 set to zero')
		end
		if (Voordeur.state == 'Open') then
			domoticz.globalData.ClosedC_Voordeur = 0
			domoticz.globalData.ClosedC_Floor1 = 0
			domoticz.log('ClosedC_Voordeur & ClosedC_Floor1 set to zero')
		end
		if (BalkondeurNienke.state == 'Open') then
			domoticz.globalData.ClosedC_BalkondeurNienke = 0
			domoticz.globalData.ClosedC_Floor2 = 0
			domoticz.log('ClosedC_BalkondeurNienke & ClosedC_Floor2 set to zero')
		end
		if (Slaapkdeur.state == 'Open') then
			domoticz.globalData.ClosedC_Slaapkdeur = 0
			domoticz.globalData.ClosedC_Floor2 = 0
			domoticz.log('ClosedC_Slaapkdeur & ClosedC_Floor2 set to zero')
		end
		if (Dakraamzolder.state == 'Open') then
			domoticz.globalData.ClosedC_Dakraamzolder = 0
			domoticz.globalData.ClosedC_Floor3 = 0
			domoticz.log('ClosedC_Dakraamzolder & ClosedC_Floor3 set to zero')
		end
		if (PIR_woonk.state == 'On') then
			domoticz.globalData.NMC_PIR_woonk = 0
			domoticz.globalData.NMC_Floor1 = 0
			domoticz.log('NMC_PIR_woonk & NMC_Floor1 set to zero')
		end
		if (PIR_kamerLars.state == 'On') then
			domoticz.globalData.NMC_PIR_kamerLars = 0
			domoticz.globalData.NMC_Floor2 = 0
			domoticz.log('NMC_PIR_kamerLars & NMC_Floor2 set to zero')
		end
		if (PIR_halboven.state == 'On') then
			domoticz.globalData.NMC_PIR_halboven = 0
			domoticz.globalData.NMC_Floor2 = 0
			domoticz.log('NMC_PIR_halboven & NMC_Floor2 set to zero')
		end
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)		
		domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
	end
}
