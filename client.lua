local SoundEffects = {
	["info"]    = {'CHALLENGE_UNLOCKED', 'HUD_AWARDS'},
	["success"] = {'BASE_JUMP_PASSED', 'HUD_AWARDS'},
	["warning"] = {'CHECKPOINT_MISSED', 'HUD_AWARDS'},
	["error"]   = {'Bed', 'WastedSounds'},
}

RegisterNetEvent('MpGameMessage:send')
AddEventHandler('MpGameMessage:send', function(message, subtitle, ms, sound, top)

	if ms == nil then
		ms = 3500
	end
	
	if sound == nil then
		sound = 'info'
	end
	
	if top == true then
		MethodName = "SHOW_PLANE_MESSAGE"
	else
		MethodName = "SHOW_SHARD_WASTED_MP_MESSAGE"
	end
	
	Citizen.CreateThread(function()
		
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		
		if sound ~= false then
			PlaySoundFrontend(-1, SoundEffects[sound][1], SoundEffects[sound][2], true)
		end
		
		BeginScaleformMovieMethod(scaleform, MethodName)
		PushScaleformMovieMethodParameterString(message)
		PushScaleformMovieMethodParameterString(subtitle)
		PushScaleformMovieMethodParameterInt(0)
		EndScaleformMovieMethod()

		local time = GetGameTimer() + ms
        
        while(GetGameTimer() < time) do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
		
		SetScaleformMovieAsNoLongerNeeded(scaleform)
	end)
	
end)

RegisterNetEvent('MpGameMessage:warning')
AddEventHandler('MpGameMessage:warning', function(message, subtitle, bottom, ms, sound)

	if ms == nil then
		ms = 3500
	end
	
	if sound == nil then
		sound = 'info'
	end
	
	Citizen.CreateThread(function()
		
		local scaleform = RequestScaleformMovie("POPUP_WARNING")
		
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		
		if sound ~= false then
			PlaySoundFrontend(-1, SoundEffects[sound][1], SoundEffects[sound][2], true)
		end
		
		BeginScaleformMovieMethod(scaleform, "SHOW_POPUP_WARNING")
		PushScaleformMovieMethodParameterFloat(500.0)
		PushScaleformMovieMethodParameterString(message)
		PushScaleformMovieMethodParameterString(subtitle)
		PushScaleformMovieMethodParameterString(bottom)
		PushScaleformMovieMethodParameterBool(true)
		EndScaleformMovieMethod()

		local time = GetGameTimer() + ms
        
        while(GetGameTimer() < time) do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
		
		SetScaleformMovieAsNoLongerNeeded(scaleform)
	end)
	
end)