function onEvent(name, value1, value2)
	if name == 'Instant Camera Pos' then
		if value1 == 'true' then
			setProperty('cameraSpeed', 100);
		end

		if value1 == 'false' or value1 == null then
			setProperty('cameraSpeed', 1);
		end
	end
end