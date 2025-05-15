-- bypass made by me
loadstring(game:HttpGet('https://raw.githubusercontent.com/lordishow/Whispering_Pines/refs/heads/main/anticheatbypass.lua'))()

-- recursive check

local _WPR_Environment = getgenv().whispering_pines_environment
local WPR_RUNTIME = nil
if _WPR_Environment then 
    _WPR_Environment.library:Notify({
        Title = "[DEFAULT: L] TO CLOSE INTERFACE",
        Content = "Press [DEFAULT: L] to close the interface to run the new one",
        Duration = 6.5,
        Image = 4483362458,
    })
    print("Close user interface by pressing [DEFAULT: L]")
    return
else
    getgenv().whispering_pines_environment = {
        RUNTIME = {
            _running_ = true,
        }
    }
    WPR_RUNTIME = getgenv().whispering_pines_environment.RUNTIME
end

-- // CORE VARIABLES // --
local CURRENT_THREAD_RUNNING = true
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local SERVICES = {
    REPLICATED = game:GetService("ReplicatedStorage"),
    PLAYERS = game:GetService("Players"),
    RUN = game:GetService("RunService"),
    USERINPUT = game:GetService("UserInputService")
}

local GLOBALS = {
    TOOLDROPS = workspace.Debris.ToolDrops
}

local this_player = {
    player = SERVICES.PLAYERS.LocalPlayer,
    character = SERVICES.PLAYERS.LocalPlayer.Character,
    humanoid = SERVICES.PLAYERS.LocalPlayer.Character:WaitForChild("Humanoid"),
    root = SERVICES.PLAYERS.LocalPlayer.Character:WaitForChild("HumanoidRootPart"),
    backpack = SERVICES.PLAYERS.LocalPlayer.Backpack
}

-- // update when char dies // .. .. .. ..
this_player.player.CharacterAdded:Connect(function(new_character)
    this_player.character = new_character
    this_player.humanoid = new_character:WaitForChild("Humanoid")
    this_player.root = new_character:WaitForChild("HumanoidRootPart")
    this_player.backpack = this_player.player.Backpack
end)

-- // VARIABLES // --

-- \\ GENERAL VARIABLES \\
local General_Variables = {
    no_fall_damage = false,
}

-- \\ MOVEMENT VARIABLES \\
local Movement_Variables = {
    walkspeed = 16,
    walkspeed_enabled = false,
}

-- \\ \\ \\ UI LIBRARY VARIABLES \\ \\ \\ --

-- // FUNCTIONS // --

-- // HOOKS // --
local old_namecall_hook;
old_namecall_hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...) 
    if not CURRENT_THREAD_RUNNING then 
        return old_namecall_hook(self, ...)
    end

    if (self.Name == "FallDamage" or self.Parent and self.Parent.Name == "FallDamage") and General_Variables.no_fall_damage then 
        return
    end

    return old_namecall_hook(self, ...)
end)) 
-- // RUNTIME // --

local __runtime_connection__;
__runtime_connection__ = SERVICES.RUN.RenderStepped:Connect(function(_delta_) 
    if not WPR_RUNTIME._running_ then 
        -- cleanup
        CURRENT_THREAD_RUNNING = false
        getgenv().whispering_pines_environment = nil
        Rayfield:Destroy()
        __runtime_connection__:Disconnect()
    end
    -- // CUSTOM MOVEMENT // --
    if Movement_Variables.walkspeed_enabled then 
        this_player.humanoid.WalkSpeed = Movement_Variables.walkspeed
    else
        if this_player.humanoid.WalkSpeed == Movement_Variables.walkspeed and Movement_Variables.walkspeed ~= 25 and Movement_Variables.walkspeed ~= 11 then 
            this_player.humanoid.WalkSpeed = 11
        end
    end 
end)

-- // UI LIBRARY // --

local Window = Rayfield:CreateWindow({
   Name = "Whispering Pine Rayfield",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Whispering Pine Suite",
   LoadingSubtitle = "by | lord is a hoe |",
   Theme = "DarkBlue", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "WhisperingPinePZ"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

-- // general // -- // general // -- // general // -- // general //

-- // general // -- // general // -- // general // -- // general //

local General_Tab = Window:CreateTab("General", 4483362458) -- Title, Image

local Keybind = General_Tab:CreateKeybind({
    Name = "Destroy Interface",
    CurrentKeybind = "L",
    HoldToInteract = false,
    Flag = "destroyinterface_keybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function()
        WPR_RUNTIME._running_ = false
    end,
})

local No_Fall_Damage_Toggle = General_Tab:CreateToggle({
    Name = "No Fall Damage",
    CurrentValue = false,
    Flag = "nofalldamage_flag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        General_Variables.no_fall_damage = Value
    end,
})

-- // MOVEMENT TAB // -- -- // MOVEMENT TAB // -- -- // MOVEMENT TAB // --

-- // MOVEMENT TAB // -- -- // MOVEMENT TAB // -- -- // MOVEMENT TAB // --

local Movement_Tab = Window:CreateTab("Movement", 4483362458) -- Title, Image

local Movement_Speed_Slider = Movement_Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = Movement_Variables.walkspeed,
    Flag = "walkspeed_flag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        Movement_Variables.walkspeed = Value
    end,
})

local Movement_Speed_Toggle = Movement_Tab:CreateToggle({
    Name = "Use Custom WalkSpeed",
    CurrentValue = false,
    Flag = "usecustomwalkspeed_flag", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        Movement_Variables.walkspeed_enabled = Value
    end,
})

local Keybind = Movement_Tab:CreateKeybind({
    Name = "Custom WalkSpeed Keybind",
    CurrentKeybind = "V",
    HoldToInteract = false,
    Flag = "customwalkspeed_keybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function()
        Movement_Speed_Toggle:Set(not Movement_Variables.walkspeed_enabled)
    end,
})

-- // ITEMS TAB // -- -- // ITEMS TAB // -- -- // ITEMS TAB // --

-- // ITEMS TAB // -- -- // ITEMS TAB // -- -- // ITEMS TAB // --

local Items_Tab = Window:CreateTab("Movement", 4483362458) -- Title, Image

local Collect_All_Items_Button = Items_Tab:CreateButton({
    Name = "Collect Every Item",
    Callback = function()
        local safe_cframe = this_player.root.CFrame
        for _,item in GLOBALS.TOOLDROPS:GetChildren() do 
            if this_player.backpack:FindFirstChild(item:FindFirstChildOfClass("Model").Name) then continue end

            local prompt = item.DropPivot.ItemDropPrompt
            local old = prompt.MaxActivationDistance
            prompt.MaxActivationDistance = math.huge
            this_player.root.CFrame = item.DropPivot.CFrame
            task.wait(0.3)
            fireproximityprompt(prompt)
            task.wait(0.1)
            prompt.MaxActivationDistance = old
        end
        this_player.CFrame = safe_cframe
    end,
})



Rayfield:LoadConfiguration()
