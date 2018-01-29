return {
	active = true,
	on = {
		devices = {
			'Yeelight Dimmer eetkamer 2'
		},
	},
	execute = function(domoticz, device)
		local IP = '192.168.178.38';
		local PORT = '55443'
		if(domoticz.devices('White Temp Yeelight eetkamer 2').state=='Off') then 
			DomValue = 0;
			runcommandoff = "sudo echo -ne '{\"id\":1,\"method\":\"set_power\", \"params\":[\"off\", \"smooth\", 500]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";;
			os.execute(runcommandoff);
		else
			TempValue = otherdevices_svalues['White Temp Yeelight eetkamer 2'];   
			CalcValue = ((TempValue-1) * 48)+1700;
			DomValue = otherdevices_svalues['Yeelight Dimmer eetkamer 2']; 
		end
		if CalcValue==nil then CalcValue=0 end

		runcommand = "sudo echo -ne '{\"id\":1, \"method\":\"set_scene\", \"params\":[\"ct\", " .. CalcValue .. ", " .. DomValue .. "]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";
		os.execute(runcommand);
		print(runcommand)
		print("bright value= "..DomValue);
	end
}
