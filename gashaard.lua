return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Gashaard'
		},
	},
	execute = function(domoticz, device)
		if (device.state == 'Run Up') then			
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes op Sleep gezet omdat de gashaard aangezet is')
		end
	end
}
