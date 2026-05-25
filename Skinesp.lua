repeat task.wait() until game:IsLoaded()

local StarterGui = game:GetService("StarterGui")

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Loading Skin Changer...",
        Duration = 3
    })
end)

-- Remove old Hazeyware GUI if it exists
pcall(function()
    local pg = game.Players.LocalPlayer:FindFirstChild("PlayerGui")

    if pg and pg:FindFirstChild("Hazeyware") then
        pg.Hazeyware:Destroy()
    end

    if game.CoreGui:FindFirstChild("Hazeyware") then
        game.CoreGui.Hazeyware:Destroy()
    end
end)

-- Load skinchanger
local SCRIPT_URL = "https://pastebin.com/raw/4rVNKnw0"

pcall(function()
    loadstring(game:HttpGet(SCRIPT_URL))()
end)

task.wait(1)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Skin Changer Loaded ✓",
        Duration = 5
    })
end)
