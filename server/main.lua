Citizen.CreateThread(function()                          -- Version Check
	local updatePath = "TwisleOfficial/tw_utils" -- your git user/repo path
	local resourceName = GetCurrentResourceName()        -- the resource name

	function splitVersion(version)
		local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")
		return tonumber(major), tonumber(minor), tonumber(patch)
	end

	function isVersionNewer(current, new)
		local currentMajor, currentMinor, currentPatch = splitVersion(current)
		local newMajor, newMinor, newPatch = splitVersion(new)

		if not currentMajor or not newMajor then
			return false, "Invalid version format"
		end

		if newMajor > currentMajor then
			return true
		elseif newMajor == currentMajor then
			if newMinor > currentMinor then
				return true
			elseif newMinor == currentMinor then
				if newPatch > currentPatch then
					return true
				end
			end
		end

		return false
	end

	function checkVersion(err, responseText, headers)
		if err ~= 200 then
			print("^2tw-utils ^0| ^2Error: Failed to fetch version. HTTP Error Code: " .. tostring(err))
			return
		end

		if not responseText or responseText == "" then
			print("^2tw-utils ^0| ^2Error: Empty response received from the repository!")
			return
		end

		local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

		if not curVersion then
			print("^2tw-utils ^0| ^2Error: 'version' file is missing in the resource root!")
			return
		end

		curVersion = curVersion:match("^%s*(.-)%s*$")
		responseText = responseText:match("^%s*(.-)%s*$")

		print("^2tw-utils ^0| Local version: " .. tostring(curVersion))
		print("^2tw-utils ^0| Remote version: " .. tostring(responseText))

		local isOutdated, errorMsg = isVersionNewer(curVersion, responseText)

		if errorMsg then
			print("^2tw-utils ^0| ^2Error: " .. errorMsg)
			return
		end

		if isOutdated then
			print("^2tw-utils ^0| ^1" ..
			resourceName .. " is outdated! New version: " .. responseText .. ", Current: " .. curVersion)
		else
			print("^2tw-utils ^0| " .. resourceName .. " is up to date!")
		end
	end

	PerformHttpRequest("https://raw.githubusercontent.com/TwisleOfficial/tw_utils/refs/heads/main/version", checkVersion,
	"GET")
end)
