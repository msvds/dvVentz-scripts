return {
	active = true,
	on = {
		devices = {
			'Yeelight Dimmer bank'
		},
	},
	execute = function(domoticz, device)
		local IP = '192.168.178.36';
		local PORT = '55443'
		if(domoticz.devices('White Temp Yeelight bank').state=='Off') then 
			DomValue = 0;
			runcommandoff = "sudo echo -ne '{\"id\":1,\"method\":\"set_power\", \"params\":[\"off\", \"smooth\", 500]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";;
			os.execute(runcommandoff);
		else
			TempValue = otherdevices_svalues['White Temp Yeelight bank'];   
			CalcValue = ((TempValue-1) * 48)+1700;
			DomValue = otherdevices_svalues['Yeelight Dimmer bank']; 
		end
		if CalcValue==nil then CalcValue=0 end

		runcommand = "sudo echo -ne '{\"id\":1, \"method\":\"set_scene\", \"params\":[\"ct\", " .. CalcValue .. ", " .. DomValue .. "]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";
		os.execute(runcommand);
		print(runcommand)
		print("bright value= "..DomValue);
	end
}
