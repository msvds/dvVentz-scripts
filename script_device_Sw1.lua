
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
		local harmony_poweroff = domoticz.devices(6)
		local radio = domoticz.devices(8)
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
