local commonAnims = { -- {dict , clip}
	['typing'] = 		{ 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle' },
	['pressbutton'] = 	{ 'anim@scripted@heist@ig3_button_press@male@', 'button_press' },
	['lockpick'] = 		{ 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds' },
}

local commonScenarios = {
	['clipboard'] =   'WORLD_HUMAN_CLIPBOARD',
	['fishing']   = 'WORLD_HUMAN_STAND_FISHING',
}

---@param dict string|number # string or hash of the dict
local function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(1)
		RequestAnimDict(dict)
	end
end
exports("loadAnimDict", loadAnimDict)


---@param target number # ped to play scenario on
---@param animData string|table # string = using commonAnims else {dict , clip}
---@param duration? number # optional : Default -1 aka looping
---@param enter? number # optional : Default 2.0
---@param exit? number # optional : Default 2.0
---@param flag? number # optional : Default 51
---@param plybackRate? number # optional : Default 0.0
local function PlayAnim(target, animData, duration, enter, exit, flag, plybackRate)
	if type(animData) == "string" then
		animData = commonAnims[animData]
	end
	if not enter then enter = 2.0 end
	if not exit then exit = 2.0 end
	if not duration then duration = -1 end
	if not flag then flag = 51 end
	if not plybackRate then plybackRate = 0.0 end

	loadAnimDict(animData[1])
	TaskPlayAnim(target, animData[1], animData[2], enter, exit, duration, flag, plybackRate, false, false, false)
	RemoveAnimDict(animData[1])
end
exports("PlayAnim", PlayAnim)


---@param target number # ped to play scenario on
---@param scenarioName string # string of scenario can also be from commonScenarios
---@param ttl? number # optional : Default 2.0
---@param introclip? boolean # optional : Default true
local function PlayScenario(target, scenarioName, ttl, introclip)
	if not ttl then ttl = 2.0 end
	if not introclip then introclip = true end
	if commonScenarios[scenarioName] then
		scenarioName = commonScenarios[scenarioName]
	end

	TaskStartScenarioInPlace(target, scenarioName, ttl, introclip)
end
exports("PlayScenario", PlayScenario)
