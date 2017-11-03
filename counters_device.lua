-- Counters for motion, no motion, open and closed windows/doors
-- When motion, no motion, open or closed windows/door are detected, the counters are set to 0 here
-- Also when manually a light is switched on, counters reset
return {
	active = true,
	on = {
		devices = {25,81,83,107,116,153,85,23,66,119,149,150,1,151,97,36},
	},
	execute = function(domoticz,device)
		local Eetkamerdeur = domoticz.devices(25)
		local Dakraamslaapk = domoticz.devices(81)
		local Balkondeurslaapk = domoticz.devices(83)
		local Voordeur = domoticz.devices(107)
		local BalkondeurNienke = domoticz.devices(116)
		local Slaapkdeur = domoticz.devices(153)
		local Dakraamzolder = domoticz.devices(85)
		local Deurbijkeuken = domoticz.devices(235)
		-------------------------->local Deurgarage = domoticz.devices()
		local PIR_woonk = domoticz.devices(23)		
		local PIR_kamerLars = domoticz.devices(66)
		local PIR_halboven = domoticz.devices(119)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		local lampen_woonkamer = domoticz.groups(1)
		local lamp_hal_boven = domoticz.devices(151)
		local Schemerlamp_deur = domoticz.devices(97)
		local Lamp_spoelb_keuken = domoticz.devices(36)	
		--domoticz.log('device.name: ' ..device.name)
		--domoticz.log('Dakraamzolder.state: ' ..Dakraamzolder.state)
		--domoticz.log('domoticz.globalData.ClosedC_Dakraamslaapk: ' ..domoticz.globalData.ClosedC_Dakraamslaapk)		
		--domoticz.log('domoticz.globalData.OpenC_Dakraamzolder: ' ..domoticz.globalData.OpenC_Dakraamzolder)
		--domoticz.log('PIR_halboven.state: ' ..PIR_halboven.state)
		
		if (device.name == Eetkamerdeur.name and Eetkamerdeur.state == 'Open') then
			domoticz.globalData.ClosedC_Eetkamerdeur = 0
			domoticz.globalData.ClosedC_Floor1  = 0	
			domoticz.log('ClosedC_Eetkamerdeur and ClosedC_Floor1 set to zero')
		elseif (device.name == Eetkamerdeur.name and Eetkamerdeur.state == 'Closed') then
			domoticz.globalData.OpenC_Eetkamerdeur = 0
			domoticz.globalData.OpenC_Floor1 = 0
			domoticz.log('OpenC_Eetkamerdeur and OpenC_Floor1 set to zero')
		end
		if (device.name == Dakraamslaapk.name and Dakraamslaapk.state == 'Open') then
			domoticz.globalData.ClosedC_Dakraamslaapk = 0			
			domoticz.globalData.ClosedC_Floor2  = 0
			domoticz.log('ClosedC_Dakraamslaapk and ClosedC_Floor2 set to zero')
		elseif (device.name == Dakraamslaapk.name and Dakraamslaapk.state == 'Closed') then
			domoticz.globalData.OpenC_Dakraamslaapk = 0
			domoticz.globalData.OpenC_Floor2 = 0
			domoticz.log('OpenC_Dakraamslaapk and OpenC_Floor2 set to zero')
		end
		if (device.name == Balkondeurslaapk.name and Balkondeurslaapk.state == 'Open') then
			domoticz.globalData.ClosedC_Balkondeurslaapk = 0
			domoticz.globalData.ClosedC_Floor2  = 0
			domoticz.log('ClosedC_Balkondeurslaapk and ClosedC_Floor2 set to zero')
		elseif (device.name == Balkondeurslaapk.name and Balkondeurslaapk.state == 'Closed') then
			domoticz.globalData.OpenC_Balkondeurslaapk = 0
			domoticz.globalData.OpenC_Floor2 = 0
			domoticz.log('OpenC_Balkondeurslaapk and OpenC_Floor2 set to zero')
		end
		if (device.name == Voordeur.name and Voordeur.state == 'Open') then
			domoticz.globalData.ClosedC_Voordeur = 0
			domoticz.globalData.ClosedC_Floor1  = 0	
			domoticz.log('ClosedC_Voordeur and ClosedC_Floor1 set to zero')
		elseif (device.name == Voordeur.name and Voordeur.state == 'Closed') then
			domoticz.globalData.OpenC_Voordeur = 0
			domoticz.globalData.OpenC_Floor1 = 0
			domoticz.log('OpenC_Voordeur and OpenC_Floor1 set to zero')
		end
		if (device.name == BalkondeurNienke.name and BalkondeurNienke.state == 'Open') then
			domoticz.globalData.ClosedC_BalkondeurNienke = 0
			domoticz.globalData.ClosedC_Floor2  = 0
			domoticz.log('ClosedC_BalkondeurNienke and ClosedC_Floor2 set to zero')
		elseif (device.name == BalkondeurNienke.name and BalkondeurNienke.state == 'Closed') then
			domoticz.globalData.OpenC_BalkondeurNienke = 0
			domoticz.globalData.OpenC_Floor2 = 0
			domoticz.log('OpenC_BalkondeurNienke and OpenC_Floor2 set to zero')
		end
		if (device.name == Slaapkdeur.name and Slaapkdeur.state == 'Open') then
			domoticz.globalData.ClosedC_Slaapkdeur = 0
			domoticz.globalData.ClosedC_Floor2  = 0
			domoticz.log('ClosedC_Slaapkdeur and ClosedC_Floor2 set to zero')
		elseif (device.name == Slaapkdeur.name and Slaapkdeur.state == 'Closed') then
			domoticz.globalData.OpenC_Slaapkdeur = 0
			domoticz.globalData.OpenC_Floor2 = 0
			domoticz.log('OpenC_Slaapkdeur and OpenC_Floor2 set to zero')
		end
		if (device.name == Deurbijkeuken.name and Deurbijkeuken.state == 'Open') then
			domoticz.globalData.ClosedC_Deurbijkeuken = 0
			domoticz.globalData.ClosedC_Floor1  = 0
			domoticz.log('ClosedC_Deurbijkeuken and ClosedC_Floor2 set to zero')
		elseif (device.name == Deurbijkeuken.name and Deurbijkeuken.state == 'Closed') then
			domoticz.globalData.OpenC_Deurbijkeuken = 0
			domoticz.globalData.OpenC_Floor1 = 0
			domoticz.log('OpenC_Deurbijkeuken and OpenC_Floor2 set to zero')
		end
		if (device.name == Dakraamzolder.name and Dakraamzolder.state == 'Open') then
			domoticz.globalData.ClosedC_Dakraamzolder = 0
			domoticz.globalData.ClosedC_Floor3 = 0
			domoticz.log('ClosedC_Dakraamzolder and ClosedC_Floor3 set to zero')
		elseif (device.name == Dakraamzolder.name and Dakraamzolder.state == 'Closed') then
			domoticz.globalData.OpenC_Dakraamzolder = 0
			domoticz.globalData.OpenC_Floor3 = 0
			domoticz.log('OpenC_Dakraamzolder and OpenC_Floor3 set to zero')
		end		
		if (device.name == Deurgarage.name and Deurgarage.state == 'Open') then
			domoticz.globalData.ClosedC_Deurgarage = 0
			domoticz.globalData.ClosedC_Outside = 0
			domoticz.log('ClosedC_Deurgarage and ClosedC_Outside set to zero')
		elseif (device.name == Deurgarage.name and Deurgarage.state == 'Closed') then
			domoticz.globalData.OpenC_Deurgarage = 0
			domoticz.globalData.OpenC_Outside = 0
			domoticz.log('OpenC_Deurgarage and OpenC_Outside set to zero')
		end		
		if (device.name == PIR_woonk.name and PIR_woonk.state == 'On') then
			domoticz.globalData.NMC_PIR_woonk = 0
			domoticz.globalData.NMC_Floor1  = 0	
			domoticz.log('NMC_PIR_woonk and NMC_Floor1 set to zero')
		elseif (device.name == PIR_woonk.name and PIR_woonk.state == 'Off') then
			domoticz.globalData.MC_PIR_woonk = 0
			domoticz.globalData.MC_Floor1   = 0	
			domoticz.log('MC_PIR_woonk and MC_Floor1 set to zero')
		end
		if (device.name == PIR_kamerLars.name and PIR_kamerLars.state == 'On') then
			domoticz.globalData.NMC_PIR_kamerLars = 0
			domoticz.globalData.NMC_Floor2  = 0	
			domoticz.log('NMC_PIR_kamerLars and NMC_Floor2 set to zero')
		elseif (device.name == PIR_kamerLars.name and PIR_kamerLars.state == 'Off') then
			domoticz.globalData.MC_PIR_kamerLars = 0
			domoticz.globalData.MC_Floor2   = 0
			domoticz.log('MC_PIR_kamerLars and MC_Floor2 set to zero')
		end
		if (device.name == PIR_halboven.name and PIR_halboven.state == 'On') then
			domoticz.globalData.NMC_PIR_halboven = 0
			domoticz.globalData.NMC_Floor2  = 0	
			domoticz.log('NMC_PIR_halboven and NMC_Floor2 set to zero')
		elseif (device.name == PIR_halboven.name and PIR_halboven.state == 'Off') then
			domoticz.globalData.MC_PIR_halboven = 0
			domoticz.globalData.MC_Floor2   = 0
			domoticz.log('MC_PIR_halboven and MC_Floor2 set to zero')
		end
		if (device.name == dimmer_bed_martijn.name and dimmer_bed_martijn.state == 'On') then
			domoticz.globalData.NMC_Floor2 = 0
			domoticz.log('NMC_Floor2 set to zero')
		elseif (device.name == dimmer_bed_suzanne.name and dimmer_bed_suzanne.state == 'Off') then
			domoticz.globalData.MC_Floor2 = 0		  
			domoticz.log('MC_Floor2 set to zero')
		end		
		if (device.name == dimmer_bed_suzanne.name and dimmer_bed_suzanne.state == 'On') then
			domoticz.globalData.NMC_Floor2 = 0
			domoticz.log('NMC_Floor2 set to zero')
		elseif (device.name == dimmer_bed_suzanne.name and dimmer_bed_suzanne.state == 'Off') then
			domoticz.globalData.MC_Floor2 = 0		  
			domoticz.log('MC_Floor2 set to zero')
		end
		if (device.name == lampen_woonkamer.name and lampen_woonkamer.state == 'On') then
			domoticz.globalData.NMC_Floor1 = 0
			domoticz.log('NMC_Floor1 set to zero')
		elseif (device.name == lampen_woonkamer.name and lampen_woonkamer.state == 'Off') then
			domoticz.globalData.MC_Floor1 = 0		  
			domoticz.log('MC_Floor1 set to zero')
		end
		if (device.name == lamp_hal_boven.name and lamp_hal_boven.state == 'On') then
			domoticz.globalData.NMC_Floor2 = 0
			domoticz.log('NMC_Floor2 set to zero')
		elseif (device.name == lamp_hal_boven.name and lamp_hal_boven.state == 'Off') then
			domoticz.globalData.MC_Floor2 = 0		  
			domoticz.log('MC_Floor2 set to zero')
		end
		if (device.name == Schemerlamp_deur.name and Schemerlamp_deur.state == 'On') then
			domoticz.globalData.NMC_Floor1 = 0
			domoticz.log('NMC_Floor1 set to zero')
		elseif (device.name == Schemerlamp_deur.name and Schemerlamp_deur.state == 'Off') then
			domoticz.globalData.MC_Floor1 = 0		  
			domoticz.log('MC_Floor1 set to zero')
		end
		if (device.name == Lamp_spoelb_keuken.name and Lamp_spoelb_keuken.state == 'On') then
			domoticz.globalData.NMC_Floor1 = 0
			domoticz.log('NMC_Floor1 set to zero')
		elseif (device.name == Lamp_spoelb_keuken.name and Lamp_spoelb_keuken.state == 'Off') then
			domoticz.globalData.MC_Floor1 = 0		  
			domoticz.log('MC_Floor1 set to zero')
		end
		if (domoticz.globalData.OpenC_Floor1 == 0 or domoticz.globalData.OpenC_Floor2 == 0 or domoticz.globalData.OpenC_Floor3 == 0 or domoticz.globalData.OpenC_Outside == 0) then
			domoticz.globalData.OpenC_Overall = 0
		end
		if (domoticz.globalData.ClosedC_Floor1 == 0 and domoticz.globalData.ClosedC_Floor2 == 0 and domoticz.globalData.ClosedC_Floor3 == 0 nd domoticz.globalData.ClosedC_Outside == 0) then
			domoticz.globalData.ClosedC_Overall = 0
		end
		if (domoticz.globalData.MC_Floor1 == 0 or domoticz.globalData.MC_Floor2 == 0) then
			domoticz.globalData.MC_Overall = 0
		end
		if (domoticz.globalData.NMC_Floor1 == 0 and domoticz.globalData.NMC_Floor2 == 0) then
			domoticz.globalData.NMC_Overall = 0
		end
	end
}
