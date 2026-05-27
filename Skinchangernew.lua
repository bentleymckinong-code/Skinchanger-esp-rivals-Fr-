local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local ViewModels = LocalPlayer.PlayerScripts:WaitForChild("Assets"):WaitForChild("ViewModels")

local SkinChanger = {}
local ActiveSkins = {}

-- Weapon -> Available skins
SkinChanger.Skins = {
    ["Bow"] = {"Compound Bow", "Raven Bow"},
    ["Assault Rifle"] = {"AK-47", "AUG"},
    ["Chainsaw"] = {"Blobsaw", "Handsaws"},
    ["RPG"] = {"Nuke Launcher", "RPKEY", "Spaceship Launcher"},
    ["Burst Rifle"] = {"Aqua Burst", "Electro Rifle"},
    ["Exogun"] = {"Singularity", "Wondergun"},
    ["Fists"] = {"Boxing Gloves", "Brass Knuckles"},
    ["Flamethrower"] = {"Lamethrower", "Pixel Flamethrower"},
    ["Flare Gun"] = {"Dynamite Gun", "Firework Gun"},
    ["Freeze Ray"] = {"Bubble Ray", "Temporal Ray"},
    ["Grenade"] = {"Water Balloon", "Whoopee Cushion"},
    ["Grenade Launcher"] = {"Swashbuckler", "Uranium Launcher"},
    ["Handgun"] = {"Blaster"},
    ["Katana"] = {"Lightning Bolt", "Saber"},
    ["Minigun"] = {"Lasergun 3000", "Pixel Minigun"},
    ["Paintball Gun"] = {"Boba Gun", "Slime Gun"},
    ["Revolver"] = {"Sheriff"},
    ["Slingshot"] = {"Goalpost", "Stick"},
    ["Subspace Tripmine"] = {"Don't Press", "Spring"},
    ["Uzi"] = {"Electro Uzi", "Water Uzi"},
    ["Sniper"] = {"Pixel Sniper", "Hyper Sniper"},
    ["Knife"] = {"Karambit", "Chancla"},
}

function SkinChanger:ApplySkin(weaponName, skinName)
    local weaponModel = ViewModels:FindFirstChild(weaponName)
    local skinModel = ViewModels:FindFirstChild(skinName)

    if not weaponModel then
        warn("Weapon not found:", weaponName)
        return false
    end

    if not skinModel then
        warn("Skin not found:", skinName)
        return false
    end

    weaponModel:ClearAllChildren()

    for _, obj in ipairs(skinModel:GetChildren()) do
        obj:Clone().Parent = weaponModel
    end

    ActiveSkins[weaponName] = skinName

    print("Applied skin:", skinName, "->", weaponName)

    return true
end

function SkinChanger:RemoveSkin(weaponName)
    ActiveSkins[weaponName] = nil
end

-- Examples
SkinChanger:ApplySkin("Assault Rifle", "AK-47")
SkinChanger:ApplySkin("Chainsaw", "Handsaws")

return SkinChanger
