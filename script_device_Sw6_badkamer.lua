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
		elseif (device.state == 'Long Click') then
		end		
	end
}
