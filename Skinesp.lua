local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = script.Parent
local mainFrame = gui:WaitForChild("MainFrame")

-- =========================
-- CREATE MINIMIZED CIRCLE
-- =========================
local circle = Instance.new("TextButton")
circle.Name = "HazeyCircle"
circle.Parent = gui
circle.Size = UDim2.new(0, 60, 0, 60)
circle.Position = UDim2.new(0, 20, 0.5, -30)
circle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
circle.Text = "HAZEY"
circle.TextColor3 = Color3.fromRGB(255, 255, 255)
circle.Font = Enum.Font.GothamBlack
circle.TextScaled = true
circle.Visible = false
circle.AutoButtonColor = true
circle.ZIndex = 999

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = circle

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Parent = circle

-- =========================
-- STATE
-- =========================
local minimized = false
local dragging = false
local dragInput
local dragStart
local startPos

-- =========================
-- TWEEN FUNCTION
-- =========================
local function tween(obj, props, t)
	local info = TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tw = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

-- =========================
-- DRAG SYSTEM (MOBILE + PC)
-- =========================
circle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = circle.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

circle.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart

		circle.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- =========================
-- MINIMIZE / RESTORE
-- =========================
local function minimize()
	minimized = true

	tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
	task.wait(0.2)
	mainFrame.Visible = false

	circle.Visible = true
	circle.Size = UDim2.new(0, 0, 0, 0)
	tween(circle, {Size = UDim2.new(0, 60, 0, 60)}, 0.25)
end

local function restore()
	minimized = false

	tween(circle, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
	task.wait(0.2)
	circle.Visible = false

	mainFrame.Visible = true
	mainFrame.Size = UDim2.new(0, 0, 0, 0)
	tween(mainFrame, {Size = UDim2.new(0, 400, 0, 300)}, 0.25) -- change to your UI size
end

-- toggle click
circle.MouseButton1Click:Connect(function()
	if dragging then return end

	if minimized then
		restore()
	else
		minimize()
	end
end)
