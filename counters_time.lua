-- Counters for motion, no motion, open and closed windows/doors in minutes
return {
	active = true,
	on = {
		timer = {'every minute'}
	},
	execute = function(domoticz)
		--domoticz.log('counters_time.lua executed')
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
		-- OpenC increases if 1 door on a floor is open
		-- ClosedC increases only if all doors on a floor are open
		local OpenC_Floor1 = 0
		local OpenC_Floor2 = 0
		local OpenC_Floor3 = 0
		local ClosedC_Floor1 = 0
		local ClosedC_Floor2 = 0
		local ClosedC_Floor3 = 0
		local MC_Floor1 = 0
		local MC_Floor2 = 0
		local MC_Floor3 = 0
		local NMC_Floor1 = 0
		local NMC_Floor2 = 0
		local NMC_Floor3 = 0
		OpenC_Eetkamerdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(25), tonumber(domoticz.globalData.OpenC_Eetkamerdeur),'Open')
		domoticz.globalData.OpenC_Eetkamerdeur = OpenC_Eetkamerdeur
		ClosedC_Eetkamerdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(25), tonumber(domoticz.globalData.ClosedC_Eetkamerdeur),'Closed')
		domoticz.globalData.ClosedC_Eetkamerdeur = ClosedC_Eetkamerdeur
		domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		domoticz.log('domoticz.globalData.ClosedC_Eetkamerdeur: ' ..domoticz.globalData.ClosedC_Eetkamerdeur)		
		
		OpenC_Dakraamslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(81), tonumber(domoticz.globalData.OpenC_Dakraamslaapk),'Open')
		domoticz.globalData.OpenC_Dakraamslaapk = OpenC_Dakraamslaapk
		ClosedC_Dakraamslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(81), tonumber(domoticz.globalData.ClosedC_Dakraamslaapk),'Closed')
		domoticz.globalData.ClosedC_Dakraamslaapk = ClosedC_Dakraamslaapk	
		domoticz.log('domoticz.globalData.OpenC_Dakraamslaapk: ' ..domoticz.globalData.OpenC_Dakraamslaapk)		
		domoticz.log('domoticz.globalData.ClosedC_Dakraamslaapk: ' ..domoticz.globalData.ClosedC_Dakraamslaapk)
		
		OpenC_Balkondeurslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(83), tonumber(domoticz.globalData.OpenC_Balkondeurslaapk),'Open')
		domoticz.globalData.OpenC_Balkondeurslaapk = OpenC_Balkondeurslaapk
		ClosedC_Balkondeurslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(83), tonumber(domoticz.globalData.ClosedC_Balkondeurslaapk),'Closed')
		domoticz.globalData.ClosedC_Balkondeurslaapk = ClosedC_Balkondeurslaapk	
		domoticz.log('domoticz.globalData.OpenC_Balkondeurslaapk: ' ..domoticz.globalData.OpenC_Balkondeurslaapk)		
		domoticz.log('domoticz.globalData.ClosedC_Balkondeurslaapk: ' ..domoticz.globalData.ClosedC_Balkondeurslaapk)
		
		OpenC_Voordeur = domoticz.helpers.Counter(domoticz, domoticz.devices(107), tonumber(domoticz.globalData.OpenC_Voordeur),'Open')
		domoticz.globalData.OpenC_Voordeur = OpenC_Voordeur
		ClosedC_Voordeur = domoticz.helpers.Counter(domoticz, domoticz.devices(107), tonumber(domoticz.globalData.ClosedC_Voordeur),'Closed')
		domoticz.globalData.ClosedC_Voordeur = ClosedC_Voordeur
		domoticz.log('domoticz.globalData.OpenC_Voordeur: ' ..domoticz.globalData.OpenC_Voordeur)		
		domoticz.log('domoticz.globalData.ClosedC_Voordeur: ' ..domoticz.globalData.ClosedC_Voordeur)
		
		OpenC_BalkondeurNienke = domoticz.helpers.Counter(domoticz, domoticz.devices(116), tonumber(domoticz.globalData.OpenC_BalkondeurNienke),'Open')
		domoticz.globalData.OpenC_BalkondeurNienke = OpenC_BalkondeurNienke
		ClosedC_BalkondeurNienke = domoticz.helpers.Counter(domoticz, domoticz.devices(116), tonumber(domoticz.globalData.ClosedC_BalkondeurNienke),'Closed')
		domoticz.globalData.ClosedC_BalkondeurNienke = ClosedC_BalkondeurNienke
		domoticz.log('domoticz.globalData.OpenC_BalkondeurNienke: ' ..domoticz.globalData.OpenC_BalkondeurNienke)		
		domoticz.log('domoticz.globalData.ClosedC_BalkondeurNienke: ' ..domoticz.globalData.ClosedC_BalkondeurNienke)
		
		OpenC_Slaapkdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(153), tonumber(domoticz.globalData.OpenC_Slaapkdeur),'Open')
		domoticz.globalData.OpenC_Slaapkdeur = OpenC_Slaapkdeur
		ClosedC_Slaapkdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(153), tonumber(domoticz.globalData.ClosedC_Slaapkdeur),'Closed')
		domoticz.globalData.ClosedC_Slaapkdeur = ClosedC_Slaapkdeur
		domoticz.log('domoticz.globalData.OpenC_Slaapkdeur: ' ..domoticz.globalData.OpenC_Slaapkdeur)		
		domoticz.log('domoticz.globalData.ClosedC_Slaapkdeur: ' ..domoticz.globalData.ClosedC_Slaapkdeur)
		
		OpenC_Dakraamzolder = domoticz.helpers.Counter(domoticz, domoticz.devices(85), tonumber(domoticz.globalData.OpenC_Dakraamzolder),'Open')
		domoticz.globalData.OpenC_Dakraamzolder = OpenC_Dakraamzolder
		ClosedC_Dakraamzolder = domoticz.helpers.Counter(domoticz, domoticz.devices(85), tonumber(domoticz.globalData.ClosedC_Dakraamzolder),'Closed')
		domoticz.globalData.ClosedC_Dakraamzolder = ClosedC_Dakraamzolder
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)		
		domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)		
		
		MC_PIR_woonk = domoticz.helpers.Counter(domoticz, domoticz.devices(23), tonumber(domoticz.globalData.MC_PIR_woonk),'On')
		domoticz.globalData.MC_PIR_woonk = MC_PIR_woonk
		NMC_PIR_woonk = domoticz.helpers.Counter(domoticz, domoticz.devices(23), tonumber(domoticz.globalData.NMC_PIR_woonk),'Off')
		domoticz.globalData.NMC_PIR_woonk = NMC_PIR_woonk
		domoticz.log('domoticz.globalData.MC_PIR_woonk: ' ..domoticz.globalData.MC_PIR_woonk)		
		domoticz.log('domoticz.globalData.NMC_PIR_woonk: ' ..domoticz.globalData.NMC_PIR_woonk)
		
		if (PIR_kamerLars.state  == 'On') then
			domoticz.globalData.MC_PIR_kamerLars  = domoticz.globalData.MC_PIR_kamerLars + 1
			domoticz.log('MC_PIR_kamerLars = ' ..domoticz.globalData.MC_PIR_kamerLars)
		else
			domoticz.globalData.NMC_PIR_kamerLars = domoticz.globalData.NMC_PIR_kamerLars + 1
			domoticz.log('NMC_PIR_kamerLars = ' ..domoticz.globalData.NMC_PIR_kamerLars)
		end
		
		if (PIR_halboven.state  == 'On') then
			domoticz.globalData.MC_PIR_halboven  = domoticz.globalData.MC_PIR_halboven + 1
			domoticz.log('MC_PIR_halboven = ' ..domoticz.globalData.MC_PIR_halboven)
		else
			domoticz.globalData.NMC_PIR_halboven = domoticz.globalData.NMC_PIR_halboven + 1
			domoticz.log('NMC_PIR_halboven = ' ..domoticz.globalData.NMC_PIR_halboven)
		end
		domoticz.globalData.OpenC_Floor1 = domoticz.globalData.OpenC_Floor1 + 1	
		domoticz.globalData.OpenC_Floor2 = domoticz.globalData.OpenC_Floor2 + 1
		domoticz.globalData.OpenC_Floor3 = domoticz.globalData.OpenC_Floor3 + 1
		domoticz.globalData.ClosedC_Floor1 = domoticz.globalData.ClosedC_Floor1 + 1	
		domoticz.globalData.ClosedC_Floor2 = domoticz.globalData.ClosedC_Floor2 + 1
		domoticz.globalData.ClosedC_Floor3 = domoticz.globalData.ClosedC_Floor3 + 1	
		domoticz.log('OpenC_Floor1 = ' ..domoticz.globalData.OpenC_Floor1)

	end
}
