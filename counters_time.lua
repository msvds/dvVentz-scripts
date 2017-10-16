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
		
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)		
		domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
		domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		--CountersDevice = function(domoticz,25,'Door','OpenC_Floor1','OpenC_Total')
		local OpenC_Eetkamerdeur = domoticz.devices().reduce(function(acc, device)
		    if (device.state == 'On') then
			acc = acc + 1 -- increase the accumulator
		    end
		    return acc -- always return the accumulator
		end, 0)
		domoticz.globalData.OpenC_Eetkamerdeur = OpenC_Eetkamerdeur		
		domoticz.log('domoticz.globalData.OpenC_Eetkamerdeur: ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		OpenC_Eetkamerdeur = domoticz.helpers.OpenC(domoticz, OpenC_Eetkamerdeur)
		domoticz.globalData.OpenC_Eetkamerdeur = OpenC_Eetkamerdeur		
		domoticz.log(OpenC_Eetkamerdeur)
		--if (Eetkamerdeur.state == 'Open') then
		--	domoticz.globalData.OpenC_Eetkamerdeur  = domoticz.globalData.OpenC_Eetkamerdeur + 1
		--	domoticz.log('OpenC_Eetkamerdeur = ' ..domoticz.globalData.OpenC_Eetkamerdeur)
		--	OpenC_Floor1 = 1
		--else
		--	domoticz.globalData.ClosedC_Eetkamerdeur = domoticz.globalData.ClosedC_Eetkamerdeur + 1
		--	domoticz.log('ClosedC_Eetkamerdeur = ' ..domoticz.globalData.ClosedC_Eetkamerdeur)
		--	ClosedC_Floor1 = 1
		--end
		if (Dakraamslaapk.state == 'Open') then
			domoticz.globalData.OpenC_Dakraamslaapk = domoticz.globalData.OpenC_Dakraamslaapk + 1
			domoticz.log('OpenC_Dakraamslaapk = ' ..domoticz.globalData.OpenC_Dakraamslaapk)
			OpenC_Floor2 = 1
		else
			domoticz.globalData.ClosedC_Dakraamslaapk = domoticz.globalData.ClosedC_Dakraamslaapk + 1
			domoticz.log('ClosedC_Dakraamslaapk = ' ..domoticz.globalData.ClosedC_Dakraamslaapk)
			ClosedC_Floor2 = 1
		end
		if (Balkondeurslaapk.state == 'Open') then
			domoticz.globalData.OpenC_Balkondeurslaapk = domoticz.globalData.OpenC_Balkondeurslaapk + 1
			domoticz.log('OpenC_Balkondeurslaapk = ' ..domoticz.globalData.OpenC_Balkondeurslaapk)
			OpenC_Floor2 = 1
		else
			domoticz.globalData.ClosedC_Balkondeurslaapk = domoticz.globalData.ClosedC_Balkondeurslaapk + 1
			domoticz.log('ClosedC_Balkondeurslaapk = ' ..domoticz.globalData.ClosedC_Balkondeurslaapk)
			if (ClosedC_Floor2 == 1) then
				ClosedC_Floor2 = 1
			else
				ClosedC_Floor2 = 0
			end
		end
		if (Voordeur.state == 'Open') then
			domoticz.globalData.OpenC_Voordeur = domoticz.globalData.OpenC_Voordeur + 1
			domoticz.log('OpenC_Voordeur = ' ..domoticz.globalData.OpenC_Voordeur)
		else
			domoticz.globalData.ClosedC_Voordeur = domoticz.globalData.ClosedC_Voordeur + 1
			domoticz.log('ClosedC_Voordeur = ' ..domoticz.globalData.ClosedC_Voordeur)
		end
		if (BalkondeurNienke.state == 'Open') then
			domoticz.globalData.OpenC_BalkondeurNienke = domoticz.globalData.OpenC_BalkondeurNienke + 1
			domoticz.log('OpenC_BalkondeurNienke = ' ..domoticz.globalData.OpenC_BalkondeurNienke)
		else
			domoticz.globalData.ClosedC_BalkondeurNienke = domoticz.globalData.ClosedC_BalkondeurNienke + 1
			domoticz.log('ClosedC_BalkondeurNienke = ' ..domoticz.globalData.ClosedC_BalkondeurNienke)
		end
		if (Slaapkdeur.state == 'Open') then
			domoticz.globalData.OpenC_Slaapkdeur = domoticz.globalData.OpenC_Slaapkdeur + 1
			domoticz.log('OpenC_Slaapkdeur = ' ..domoticz.globalData.OpenC_Slaapkdeur)
		else
			domoticz.globalData.ClosedC_Slaapkdeur = domoticz.globalData.ClosedC_Slaapkdeur + 1
			domoticz.log('ClosedC_Slaapkdeur = ' ..domoticz.globalData.ClosedC_Slaapkdeur)
		end
		--CountersDevice =function(domoticz,85,'Raam','OpenC_Floor3','OpenC_Total')
		--if (Dakraamzolder.state == 'Open') then
		--	domoticz.globalData.OpenC_Dakraamzolder = domoticz.globalData.OpenC_Dakraamzolder + 1
		--	domoticz.log('OpenC_Dakraamzolder = ' ..domoticz.globalData.OpenC_Dakraamzolder)
		--else
		--	domoticz.globalData.ClosedC_Dakraamzolder = domoticz.globalData.ClosedC_Dakraamzolder + 1
		--	domoticz.log('ClosedC_Dakraamzolder = ' ..domoticz.globalData.ClosedC_Dakraamzolder)
		--end
		
		if (PIR_woonk.state == 'On') then
			domoticz.globalData.MC_PIR_woonk = domoticz.globalData.MC_PIR_woonk + 1
			domoticz.log('MC_PIR_woonk = ' ..domoticz.globalData.MC_PIR_woonk)
		else
			domoticz.globalData.NMC_PIR_woonk = domoticz.globalData.NMC_PIR_woonk + 1
			domoticz.log('NMC_PIR_woonk = ' ..domoticz.globalData.NMC_PIR_woonk)
		end
		
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
			
		domoticz.log('domoticz.globalData.ClosedC_Dakraamzolder: ' ..domoticz.globalData.ClosedC_Dakraamzolder)		
		domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
	end
}
