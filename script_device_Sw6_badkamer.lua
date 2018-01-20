return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw6_badkamer' -- Switch badkamer
		},
	},

	execute = function(domoticz, device)
		if device.state == 'Double Click' then
		elseif device.state == 'Click' then
			domoticz.devices('Roomlars-Stat').updateSetPoint(21)
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(40)
		elseif (device.state == 'Long Click') then
		end		
	end
}
