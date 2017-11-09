
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw1'
		},
	},

	execute = function(domoticz, device)
		local lamp_boven_tv = domoticz.devices(13)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local lamp_bank = domoticz.devices(15)
		local schemerlamp_bank = domoticz.devices(16)
		local schemerlamp_deur = domoticz.devices(97)
		--local harmony_poweroff = domoticz.devices(6)
		--local radio = domoticz.devices(8)
		local dakraamslaapkamer = domoticz.devices(81)
		local dakraamzolderachter = domoticz.devices(85)
		local Eetkamerdeur = domoticz.devices(25)
		local Balkondeurslaapk = domoticz.devices(83)
		local Voordeur = domoticz.devices(107)
		local BalkondeurNienke = domoticz.devices(116)
		local lampen_woonkamer = domoticz.groups(1)
		local lamp_hal_boven = domoticz.devices(151)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		--local MediaCenter = domoticz.devices(11)
		--local Televisie = domoticz.devices(7)
		--local Televisie_lage_resolutie = domoticz.devices(9)
		local Status_selector = domoticz.devices(90)
		domoticz.log(Status_selector.state)
		Status_selector.state = 'Sleep'
		domoticz.log(Status_selector.state)
		if (device.state == 'Long Click') then
			Status_selector = '40' --Home
			lamp_boven_tv.switchOn()
			lamp_spoelb_keuken.switchOn()
			lamp_bank.switchOn()
			schemerlamp_bank.switchOn()
			schemerlamp_deur.switchOn()
			domoticz.log('Lights turned on')
		elseif (device.state == 'Click') then
			Status_selector.state = 'Sleep' 
			lamp_boven_tv.switchOff()
			lamp_spoelb_keuken.switchOff()
			lamp_bank.switchOff()
			schemerlamp_bank.switchOff()
			schemerlamp_deur.switchOff()
            		--harmony_poweroff.switchOn()
			domoticz.helpers.changeToonSceneComplete(domoticz,'10','omdat de gaan slapen knop ingedrukt is',false)
			os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t "Alles is uitgeschakeld. Moet er nog een broodje gebakken worden? Weltrusten alvast!"')
			domoticz.log('Lights turned off and Harmony turned off')
			if (dakraamslaapkamer.state == 'Open') then
			   domoticz.notify('Dakraam slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (dakraamzolderachter.state == 'Open') then
			   domoticz.notify('Dakraam zolder achter is open',domoticz.PRIORITY_HIGH)				
			elseif (Eetkamerdeur.state == 'Open') then
			   domoticz.notify('Eetkamerdeur is open',domoticz.PRIORITY_HIGH)
			elseif (Balkondeurslaapk.state == 'Open') then
			   domoticz.notify('Balkondeur slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (Voordeur.state == 'Open') then
			   domoticz.notify('Voordeur slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (BalkondeurNienke.state == 'Open') then
			   domoticz.notify('Balkondeur Nienke is open',domoticz.PRIORITY_HIGH)
			--elseif (MediaCenter.state == 'On') then
			  -- domoticz.notify('MediaCenter staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie.state == 'On') then
			  -- domoticz.notify('Televisie staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie_lage_resolutie.state == 'On') then
			  -- domoticz.notify('Televisie lage resolutie staat aan',domoticz.PRIORITY_HIGH)
			end 
		elseif (device.state == 'Double Click') then
			--check everything is it's ready to departure
			--check if windows are closed
			if (dakraamslaapkamer.state == 'Open') then
			   domoticz.notify('Dakraam slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (dakraamzolderachter.state == 'Open') then
			   domoticz.notify('Dakraam zolder achter is open',domoticz.PRIORITY_HIGH)				
			elseif (Eetkamerdeur.state == 'Open') then
			   domoticz.notify('Eetkamerdeur is open',domoticz.PRIORITY_HIGH)
			elseif (Balkondeurslaapk.state == 'Open') then
			   domoticz.notify('Balkondeur slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (Voordeur.state == 'Open') then
			   domoticz.notify('Voordeur slaapkamer is open',domoticz.PRIORITY_HIGH)
			elseif (BalkondeurNienke.state == 'Open') then
			   domoticz.notify('Balkondeur Nienke is open',domoticz.PRIORITY_HIGH)
			elseif (lampen_woonkamer.state == 'On') then
			   domoticz.notify('lampen woonkamer staan aan',domoticz.PRIORITY_HIGH)
			elseif (lamp_hal_boven.state == 'On') then
			   domoticz.notify('lamp hal boven staat aan',domoticz.PRIORITY_HIGH)
			elseif (dimmer_bed_martijn.state == 'On') then
			   domoticz.notify('dimmer bed martijn staat aan',domoticz.PRIORITY_HIGH)
			elseif (dimmer_bed_suzanne.state == 'On') then
			   domoticz.notify('dimmer bed suzanne staat aan',domoticz.PRIORITY_HIGH)
			elseif (schemerlamp_deur.state == 'On') then
			   domoticz.notify('Schemerlamp deur staat aan',domoticz.PRIORITY_HIGH)
			elseif (lamp_spoelb_keuken.state == 'On') then
			   domoticz.notify('Lamp spoelbak keuken staat aan',domoticz.PRIORITY_HIGH)
			--elseif (MediaCenter.state == 'On') then
			   --domoticz.notify('MediaCenter staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie.state == 'On') then
			   --domoticz.notify('Televisie staat aan',domoticz.PRIORITY_HIGH)
			--elseif (Televisie_lage_resolutie.state == 'On') then
			   --domoticz.notify('Televisie lage resolutie staat aan',domoticz.PRIORITY_HIGH)
			end 
		end
	end
}
