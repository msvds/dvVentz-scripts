-- Counters for motion, no motion, open and closed windows/doors in minutes
-- PIR for floor 3 missing
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
		-- ClosedC increases only if all doors on a floor are closed
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
		local message_time = 5
		domoticz.globalData.Counters_time_message = domoticz.globalData.Counters_time_message + 1  
		
		
		OpenC_Eetkamerdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(25), tonumber(domoticz.globalData.OpenC_Eetkamerdeur),'Open')
		domoticz.globalData.OpenC_Eetkamerdeur = OpenC_Eetkamerdeur
		ClosedC_Eetkamerdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(25), tonumber(domoticz.globalData.ClosedC_Eetkamerdeur),'Closed')
		domoticz.globalData.ClosedC_Eetkamerdeur = ClosedC_Eetkamerdeur
		if (domoticz.globalData.OpenC_Eetkamerdeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		end
		if (domoticz.globalData.ClosedC_Eetkamerdeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Eetkamerdeur: ' ..domoticz.globalData.ClosedC_Eetkamerdeur)		
		end
		
		OpenC_Dakraamslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(81), tonumber(domoticz.globalData.OpenC_Dakraamslaapk),'Open')
		domoticz.globalData.OpenC_Dakraamslaapk = OpenC_Dakraamslaapk
		ClosedC_Dakraamslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(81), tonumber(domoticz.globalData.ClosedC_Dakraamslaapk),'Closed')
		domoticz.globalData.ClosedC_Dakraamslaapk = ClosedC_Dakraamslaapk	
		if (domoticz.globalData.OpenC_Dakraamslaapk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Dakraamslaapk: ' ..domoticz.globalData.OpenC_Dakraamslaapk)		
		end
		if (domoticz.globalData.ClosedC_Dakraamslaapk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Dakraamslaapk: ' ..domoticz.globalData.ClosedC_Dakraamslaapk)
		end
		
		OpenC_Balkondeurslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(83), tonumber(domoticz.globalData.OpenC_Balkondeurslaapk),'Open')
		domoticz.globalData.OpenC_Balkondeurslaapk = OpenC_Balkondeurslaapk
		ClosedC_Balkondeurslaapk = domoticz.helpers.Counter(domoticz, domoticz.devices(83), tonumber(domoticz.globalData.ClosedC_Balkondeurslaapk),'Closed')
		domoticz.globalData.ClosedC_Balkondeurslaapk = ClosedC_Balkondeurslaapk	
		if (domoticz.globalData.OpenC_Balkondeurslaapk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Balkondeurslaapk: ' ..domoticz.globalData.OpenC_Balkondeurslaapk)	
		end
		if (domoticz.globalData.ClosedC_Balkondeurslaapk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Balkondeurslaapk: ' ..domoticz.globalData.ClosedC_Balkondeurslaapk)
		end
		
		OpenC_Voordeur = domoticz.helpers.Counter(domoticz, domoticz.devices(107), tonumber(domoticz.globalData.OpenC_Voordeur),'Open')
		domoticz.globalData.OpenC_Voordeur = OpenC_Voordeur
		ClosedC_Voordeur = domoticz.helpers.Counter(domoticz, domoticz.devices(107), tonumber(domoticz.globalData.ClosedC_Voordeur),'Closed')
		domoticz.globalData.ClosedC_Voordeur = ClosedC_Voordeur
		if (domoticz.globalData.OpenC_Voordeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Voordeur: ' ..domoticz.globalData.OpenC_Voordeur)
		end
		if (domoticz.globalData.ClosedC_Voordeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Voordeur: ' ..domoticz.globalData.ClosedC_Voordeur)
		end
		
		OpenC_BalkondeurNienke = domoticz.helpers.Counter(domoticz, domoticz.devices(116), tonumber(domoticz.globalData.OpenC_BalkondeurNienke),'Open')
		domoticz.globalData.OpenC_BalkondeurNienke = OpenC_BalkondeurNienke
		ClosedC_BalkondeurNienke = domoticz.helpers.Counter(domoticz, domoticz.devices(116), tonumber(domoticz.globalData.ClosedC_BalkondeurNienke),'Closed')
		domoticz.globalData.ClosedC_BalkondeurNienke = ClosedC_BalkondeurNienke
		if (domoticz.globalData.OpenC_BalkondeurNienke ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_BalkondeurNienke: ' ..domoticz.globalData.OpenC_BalkondeurNienke)
		end
		if (domoticz.globalData.ClosedC_BalkondeurNienke ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_BalkondeurNienke: ' ..domoticz.globalData.ClosedC_BalkondeurNienke)
		end
		
		OpenC_Slaapkdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(153), tonumber(domoticz.globalData.OpenC_Slaapkdeur),'Open')
		domoticz.globalData.OpenC_Slaapkdeur = OpenC_Slaapkdeur
		ClosedC_Slaapkdeur = domoticz.helpers.Counter(domoticz, domoticz.devices(153), tonumber(domoticz.globalData.ClosedC_Slaapkdeur),'Closed')
		domoticz.globalData.ClosedC_Slaapkdeur = ClosedC_Slaapkdeur
		if (domoticz.globalData.OpenC_Slaapkdeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Slaapkdeur: ' ..domoticz.globalData.OpenC_Slaapkdeur)
		end
		if (domoticz.globalData.ClosedC_Slaapkdeur ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Slaapkdeur: ' ..domoticz.globalData.ClosedC_Slaapkdeur)
		end
		
		OpenC_Dakraamzolder = domoticz.helpers.Counter(domoticz, domoticz.devices(85), tonumber(domoticz.globalData.OpenC_Dakraamzolder),'Open')
		domoticz.globalData.OpenC_Dakraamzolder = OpenC_Dakraamzolder
		ClosedC_Dakraamzolder = domoticz.helpers.Counter(domoticz, domoticz.devices(85), tonumber(domoticz.globalData.ClosedC_Dakraamzolder),'Closed')
		domoticz.globalData.ClosedC_Dakraamzolder = ClosedC_Dakraamzolder
		if (domoticz.globalData.ClosedC_Dakraamzolder ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)
		end
		if (domoticz.globalData.OpenC_Dakraamzolder ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
		end
		
		MC_PIR_woonk = domoticz.helpers.Counter(domoticz, domoticz.devices(23), tonumber(domoticz.globalData.MC_PIR_woonk),'On')
		domoticz.globalData.MC_PIR_woonk = MC_PIR_woonk
		NMC_PIR_woonk = domoticz.helpers.Counter(domoticz, domoticz.devices(23), tonumber(domoticz.globalData.NMC_PIR_woonk),'Off')
		domoticz.globalData.NMC_PIR_woonk = NMC_PIR_woonk
		if (domoticz.globalData.MC_PIR_woonk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.MC_PIR_woonk: ' ..domoticz.globalData.MC_PIR_woonk)
		end
		if (domoticz.globalData.NMC_PIR_woonk ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.NMC_PIR_woonk: ' ..domoticz.globalData.NMC_PIR_woonk)
		end
		
		MC_PIR_kamerLars = domoticz.helpers.Counter(domoticz, domoticz.devices(66), tonumber(domoticz.globalData.MC_PIR_kamerLars),'On')
		domoticz.globalData.MC_PIR_kamerLars = MC_PIR_kamerLars
		NMC_PIR_kamerLars = domoticz.helpers.Counter(domoticz, domoticz.devices(66), tonumber(domoticz.globalData.NMC_PIR_kamerLars),'Off')
		domoticz.globalData.NMC_PIR_kamerLars = NMC_PIR_kamerLars
		if (domoticz.globalData.MC_PIR_kamerLars ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.MC_PIR_kamerLars: ' ..domoticz.globalData.MC_PIR_kamerLars)
		end
		if (domoticz.globalData.NMC_PIR_kamerLars ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.NMC_PIR_kamerLars: ' ..domoticz.globalData.NMC_PIR_kamerLars)
		end
		
		MC_PIR_halboven = domoticz.helpers.Counter(domoticz, domoticz.devices(119), tonumber(domoticz.globalData.MC_PIR_halboven),'On')
		domoticz.globalData.MC_PIR_halboven = MC_PIR_halboven
		NMC_PIR_halboven = domoticz.helpers.Counter(domoticz, domoticz.devices(119), tonumber(domoticz.globalData.NMC_PIR_halboven),'Off')
		domoticz.globalData.NMC_PIR_halboven = NMC_PIR_halboven
		if (domoticz.globalData.MC_PIR_halboven ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.MC_PIR_halboven: ' ..domoticz.globalData.MC_PIR_halboven)
		end
		if (domoticz.globalData.NMC_PIR_halboven ~= 0 and domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('domoticz.globalData.NMC_PIR_halboven: ' ..domoticz.globalData.NMC_PIR_halboven)
		end
		
		--Floor1
		--Eetkamerdeur
		--Voordeur
		--PIR_woonk
		if (domoticz.globalData.OpenC_Eetkamerdeur ~= 0 or domoticz.globalData.OpenC_Voordeur ~= 0) then
			domoticz.globalData.OpenC_Floor1 = domoticz.globalData.OpenC_Floor1 + 1
			domoticz.globalData.ClosedC_Floor1 = 0
		end
		if (domoticz.globalData.ClosedC_Eetkamerdeur ~= 0 and domoticz.globalData.ClosedC_Voordeur ~= 0) then
			domoticz.globalData.ClosedC_Floor1 = domoticz.globalData.ClosedC_Floor1 + 1
			domoticz.globalData.OpenC_Floor1 = 0
		end		
		if (domoticz.globalData.MC_PIR_woonk ~= 0) then
			domoticz.globalData.MC_Floor1 = domoticz.globalData.MC_Floor1 + 1
			domoticz.globalData.NMC_Floor1 = 0
		end
		if (domoticz.globalData.NMC_PIR_woonk ~= 0) then
			domoticz.globalData.NMC_Floor1 = domoticz.globalData.NMC_Floor1 + 1
			domoticz.globalData.MC_Floor1 = 0
		end
		--Floor2
		--Dakraamslaapk
		--Balkondeurslaapk
		--BalkondeurNienke
		--Slaapkdeur
		--PIR_kamerLars
		--PIR_halboven
		if (domoticz.globalData.OpenC_Dakraamslaapk ~= 0 or domoticz.globalData.OpenC_Balkondeurslaapk ~= 0 or domoticz.globalData.OpenC_BalkondeurNienke ~= 0 or domoticz.globalData.OpenC_Slaapkdeur ~= 0) then
			domoticz.globalData.OpenC_Floor2 = domoticz.globalData.OpenC_Floor2 + 1
			domoticz.globalData.ClosedC_Floor2 = 0
		end
		if (domoticz.globalData.ClosedC_Dakraamslaapk ~= 0 and domoticz.globalData.ClosedC_Balkondeurslaapk ~= 0 and domoticz.globalData.ClosedC_BalkondeurNienke ~= 0 and domoticz.globalData.ClosedC_Slaapkdeur ~= 0) then
			domoticz.globalData.ClosedC_Floor2 = domoticz.globalData.ClosedC_Floor2 + 1
			domoticz.globalData.OpenC_Floor2 = 0
		end		
		if (domoticz.globalData.MC_PIR_kamerLars ~= 0 or domoticz.globalData.MC_PIR_halboven ~= 0) then
			domoticz.globalData.MC_Floor2 = domoticz.globalData.MC_Floor2 + 1
			domoticz.globalData.NMC_Floor2 = 0
		end
		if (domoticz.globalData.NMC_PIR_kamerLars ~= 0 and domoticz.globalData.NMC_PIR_halboven ~= 0) then
			domoticz.globalData.NMC_Floor2 = domoticz.globalData.NMC_Floor2 + 1
			domoticz.globalData.MC_Floor2 = 0
		end
		
		--Floor3
		--Dakraamzolder
		if (domoticz.globalData.OpenC_Dakraamzolder ~= 0) then
			domoticz.globalData.OpenC_Floor3 = domoticz.globalData.OpenC_Floor3 + 1
			domoticz.globalData.ClosedC_Floor3 = 0
		end
		if (domoticz.globalData.OClosedC_Dakraamzolder ~= 0) then
			domoticz.globalData.ClosedC_Floor3 = domoticz.globalData.ClosedC_Floor3 + 1
			domoticz.globalData.OpenC_Floor3 = 0
		end
		
		--Total
		if (domoticz.globalData.OpenC_Floor1 ~= 0 or domoticz.globalData.OpenC_Floor2 ~= 0 or domoticz.globalData.OpenC_Floor3 ~= 0) then
			domoticz.globalData.OpenC_Total = domoticz.globalData.OpenC_Total + 1
			domoticz.globalData.ClosedC_Total = 0
		end
		if (domoticz.globalData.ClosedC_Floor1 ~= 0 and domoticz.globalData.ClosedC_Floor2 ~= 0 and domoticz.globalData.ClosedC_Floor3 ~= 0) then
			domoticz.globalData.ClosedC_Total = domoticz.globalData.ClosedC_Total + 1
			domoticz.globalData.OpenC_Total = 0
		end
		if (domoticz.globalData.MC_Floor1 ~= 0 or domoticz.globalData.MC_Floor2 ~= 0) then
			domoticz.globalData.MC_Total = domoticz.globalData.MC_Total + 1
			domoticz.globalData.NMC_Total = 0
		end
		if (domoticz.globalData.NMC_Floor1 ~= 0 and domoticz.globalData.NMC_Floor2 ~= 0) then
			domoticz.globalData.NMC_Total = domoticz.globalData.NMC_Total + 1
			domoticz.globalData.MC_Total = 0
		end
		if (domoticz.globalData.Counters_time_message == message_time) then
			domoticz.log('OpenC_Floor1 = ' ..domoticz.globalData.OpenC_Floor1)
			domoticz.log('ClosedC_Floor1 = ' ..domoticz.globalData.ClosedC_Floor1)
			domoticz.log('MC_Floor1 = ' ..domoticz.globalData.MC_Floor1)
			domoticz.log('NMC_Floor1 = ' ..domoticz.globalData.NMC_Floor1)
			domoticz.log('OpenC_Floor2 = ' ..domoticz.globalData.OpenC_Floor2)
			domoticz.log('ClosedC_Floor2 = ' ..domoticz.globalData.ClosedC_Floor2)
			domoticz.log('MC_Floor2 = ' ..domoticz.globalData.MC_Floor2)
			domoticz.log('NMC_Floor2 = ' ..domoticz.globalData.NMC_Floor2)
			domoticz.log('OpenC_Floor3 = ' ..domoticz.globalData.OpenC_Floor3)	
			domoticz.log('ClosedC_Floor3 = ' ..domoticz.globalData.ClosedC_Floor3)
			domoticz.log('OpenC_Total = ' ..domoticz.globalData.OpenC_Total)
			domoticz.log('ClosedC_Total = ' ..domoticz.globalData.ClosedC_Total)
			domoticz.log('MC_Total = ' ..domoticz.globalData.MC_Total)	
			domoticz.log('NMC_Total = ' ..domoticz.globalData.NMC_Total)
		end
		if (domoticz.globalData.Counters_time_message >= message_time) then
			domoticz.globalData.Counters_time_message = 0
		end
	end
}
