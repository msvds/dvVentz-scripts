
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw1'
		},
	},

	execute = function(domoticz, device)
	    local lamp_boven_tv = domoticz.devices('Lamp boven TV')
	    local lamp_spoelb_keuken = domoticz.devices('Lamp spoelb keuken')
	    local lamp_bank = domoticz.devices('Lamp bank')
	    local schemerlamp_bank = domoticz.devices('Schemerlamp bank')
	    local schemerlamp_deur = domoticz.devices('Schemerlamp deur')
	    local harmony_poweroff = domoticz.devices('Harmony PowerOff')
	    local radio = domoticz.devices('Radio')
		domoticz.log(device.state)
		if (device.state == 'Long Click') then
			lamp_boven_tv.switchOn()
			lamp_spoelb_keuken.switchOn()
			lamp_bank.switchOn()
			schemerlamp_bank.switchOn()
			schemerlamp_deur.switchOn()
			domoticz.log('Lights turned on')
		elseif (device.state == 'Click') then
			lamp_boven_tv.switchOff()
			lamp_spoelb_keuken.switchOff()
			lamp_bank.switchOff()
			schemerlamp_bank.switchOff()
			schemerlamp_deur.switchOff()
            harmony_poweroff.switchOn()
			os.execute ('/usr/local/bin/izsynth -e voicerss -v nl-nl -W 75 -t "Alles is uitgeschakeld. Moet er nog een broodje gebakken worden? Weltrusten alvast!"')
			domoticz.log('Lights turned off and Harmony turned off')
		elseif (device.state == 'Double Click') then
            radio.switchOn()
			domoticz.log('Radio turned on')
		end
	end
}