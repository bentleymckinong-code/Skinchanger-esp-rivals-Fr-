repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

-- Remove old GUIs
pcall(function()
    if LocalPlayer.PlayerGui:FindFirstChild("Hazeyware") then
        LocalPlayer.PlayerGui.Hazeyware:Destroy()
    end

    if game.CoreGui:FindFirstChild("Hazeyware") then
        game.CoreGui.Hazeyware:Destroy()
    end
end)

-- Loading notification
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Loading Skin Changer...",
        Duration = 3
    })
end)

-- Load script
local SCRIPT_URL = "https://pastebin.com/raw/4rVNKnw0"

pcall(function()
    loadstring(game:HttpGet(SCRIPT_URL))()
end)

-- Success notification
task.wait(1)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Skin Changer Loaded ✓",
        Duration = 5
    })
end)
