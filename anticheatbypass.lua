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
            print("Ruh roh raggy looksie likie the anticheat fubmled the bag")
            return
        end
    elseif method == "Kick" and self == LocalPlayer then 
        print("the kick got kicked in the balls")
        return
    end
    return old(self, ...)
end))
