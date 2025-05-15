local bypass_already_loaded = getgenv().whispering_pines_bypass_loaded_pz
if bypass_already_loaded then print("Bypass Already Loaded (WP_PZ)") return end
getgenv().whispering_pines_bypass_loaded_pz = true

-- ADONIS BYPASS WASNT MADE BY ME
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/refs/heads/main/Source.lua'))()
-- the actual bypass
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local old;
old = hookmetamethod(game,"__namecall", newcclosure(function(self, ...) 
    local method = getnamecallmethod()
    if method == "FireServer" then 
        if self.Name == "Anticheat" then 
            print("Ruh roh raggy looksie likie the anticheat had a little oopsie UwU")
            return
        end
    elseif method == "Kick" and self == LocalPlayer then 
        print("almost got kicked in the balls")
        return
    end
    return old(self, ...)
end))
