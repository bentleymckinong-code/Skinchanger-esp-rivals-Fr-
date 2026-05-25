local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ==================== SETTINGS ====================
local EspSettings = {
	Enabled = true,
	Box = true,
	Health = true,
	Names = true,
	AccentColor = Color3.fromRGB(0, 170, 255)
}

local SkinChangerLoaded = false
local SCRIPT_URL = "https://pastebin.com/raw/4rVNKnw0"

-- ==================== GUI ====================
local Gui = Instance.new("ScreenGui")
Gui.Name = "Hazeyware"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MenuFrame = Instance.new("Frame")
MenuFrame.Size = UDim2.new(0, 200, 0, 290)
MenuFrame.Position = UDim2.new(0.5, -100, 0.5, -145)
MenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MenuFrame.BorderSizePixel = 0
MenuFrame.Active = true
MenuFrame.Parent = Gui

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1
Stroke.Color = Color3.fromRGB(60, 60, 60)
Stroke.Parent = MenuFrame

-- ==================== TOP BAR ====================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MenuFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = " HAZEYWARE "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.RobotoMono
Title.TextSize = 14
Title.Parent = TopBar

-- ==================== DRAG SYSTEM (FIXED PC + MOBILE) ====================
local dragging = false
local dragStart
local startPos
local dragInput

local function update(input)
	local delta = input.Position - dragStart

	MenuFrame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = MenuFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and dragInput and input == dragInput then
		update(input)
	end
end)

-- ==================== TOGGLES ====================
local function createToggle(name, key, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.BorderSizePixel = 0
	btn.Text = name .. ": " .. (EspSettings[key] and "ON" or "OFF")
	btn.TextColor3 = EspSettings[key] and EspSettings.AccentColor or Color3.fromRGB(200,200,200)
	btn.Font = Enum.Font.RobotoMono
	btn.TextSize = 13
	btn.Parent = MenuFrame

	btn.MouseButton1Click:Connect(function()
		EspSettings[key] = not EspSettings[key]
		btn.Text = name .. ": " .. (EspSettings[key] and "ON" or "OFF")
		btn.TextColor3 = EspSettings[key] and EspSettings.AccentColor or Color3.fromRGB(200,200,200)
	end)
end

createToggle("Master", "Enabled", 40)
createToggle("Boxes", "Box", 80)
createToggle("Health", "Health", 120)
createToggle("Names", "Names", 160)

-- ==================== SKIN CHANGER ====================
local SkinButton = Instance.new("TextButton")
SkinButton.Size = UDim2.new(1, -20, 0, 35)
SkinButton.Position = UDim2.new(0, 10, 0, 200)
SkinButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SkinButton.Text = "Load Skin Changer"
SkinButton.TextColor3 = Color3.fromRGB(0, 170, 255)
SkinButton.Font = Enum.Font.RobotoMono
SkinButton.TextSize = 13
SkinButton.Parent = MenuFrame

SkinButton.MouseButton1Click:Connect(function()
	if SkinChangerLoaded then
		SkinButton.Text = "Already Loaded ✓"
		return
	end

	SkinChangerLoaded = true
	SkinButton.Text = "Loading..."
	SkinButton.BackgroundColor3 = Color3.fromRGB(100,100,100)

	pcall(function()
		loadstring(game:HttpGet(SCRIPT_URL))()
	end)

	task.wait(0.5)
	SkinButton.Text = "Skin Changer Loaded ✓"
	SkinButton.BackgroundColor3 = Color3.fromRGB(46,160,113)
end)

-- ==================== MENU TOGGLE ====================
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.Insert then
		MenuFrame.Visible = not MenuFrame.Visible
	end
end)

-- ==================== ESP ====================
local ActiveEsp = {}

local function createEsp(player)
	if player == LocalPlayer then return end

	local container = Instance.new("Frame")
	container.BackgroundTransparency = 1
	container.Visible = false
	container.Parent = Gui

	local box = Instance.new("Frame", container)
	box.BackgroundTransparency = 1

	local stroke = Instance.new("UIStroke", box)
	stroke.Thickness = 1
	stroke.Color = EspSettings.AccentColor

	local name = Instance.new("TextLabel", container)
	name.BackgroundTransparency = 1
	name.TextSize = 12
	name.Font = Enum.Font.RobotoMono
	name.TextColor3 = Color3.fromRGB(255,255,255)

	local hpBg = Instance.new("Frame", container)
	hpBg.Size = UDim2.new(0, 3, 1, 0)
	hpBg.BackgroundColor3 = Color3.fromRGB(0,0,0)

	local hpFill = Instance.new("Frame", hpBg)
	hpFill.Size = UDim2.new(1,0,1,0)

	ActiveEsp[player] = {
		Container = container,
		Box = box,
		Name = name,
		HPFill = hpFill,
		HPBg = hpBg
	}
end

local function removeEsp(player)
	if ActiveEsp[player] then
		ActiveEsp[player].Container:Destroy()
		ActiveEsp[player] = nil
	end
end

RunService.RenderStepped:Connect(function()
	for player, esp in pairs(ActiveEsp) do
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		if EspSettings.Enabled and hrp and hum and hum.Health > 0 then
			local pos, vis = Camera:WorldToViewportPoint(hrp.Position)

			if vis then
				local size = char:GetExtentsSize()
				local h = math.abs(size.Y * 40)
				local w = h * 0.6

				esp.Container.Visible = true
				esp.Container.Size = UDim2.new(0,w,0,h)
				esp.Container.Position = UDim2.new(0,pos.X-w/2,0,pos.Y-h/2)

				esp.Name.Text = player.Name

				local hp = hum.Health / hum.MaxHealth
				esp.HPFill.Size = UDim2.new(1,0,hp,0)
				esp.HPFill.Position = UDim2.new(0,0,1-hp,0)
			else
				esp.Container.Visible = false
			end
		else
			esp.Container.Visible = false
		end
	end
end)

Players.PlayerAdded:Connect(createEsp)
Players.PlayerRemoving:Connect(removeEsp)

for _,p in pairs(Players:GetPlayers()) do
	createEsp(p)
end
