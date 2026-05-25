--// Draggable + Minimize GUI Wrapper
--// Put your loadstring inside this

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Minimize = Instance.new("TextButton")
local Execute = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RivalsGUI"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
MainFrame.Position = UDim2.new(0.35,0,0.3,0)
MainFrame.Size = UDim2.new(0,300,0,180)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame

TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
TopBar.Size = UDim2.new(1,0,0,35)

UICorner2.Parent = TopBar

Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,-40,1,0)
Title.Text = "Rivals OP GUI"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

Minimize.Parent = TopBar
Minimize.Size = UDim2.new(0,35,0,35)
Minimize.Position = UDim2.new(1,-35,0,0)
Minimize.Text = "-"
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 22

Execute.Parent = MainFrame
Execute.Size = UDim2.new(0.8,0,0,45)
Execute.Position = UDim2.new(0.1,0,0.45,0)
Execute.BackgroundColor3 = Color3.fromRGB(55,55,55)
Execute.Text = "Execute Script"
Execute.TextColor3 = Color3.new(1,1,1)
Execute.Font = Enum.Font.GothamBold
Execute.TextSize = 20

UICorner3.Parent = Execute

local minimized = false

Minimize.MouseButton1Click:Connect(function()
	if minimized then
		MainFrame.Size = UDim2.new(0,300,0,180)
		Execute.Visible = true
		Minimize.Text = "-"
		minimized = false
	else
		MainFrame.Size = UDim2.new(0,300,0,35)
		Execute.Visible = false
		Minimize.Text = "+"
		minimized = true
	end
end)

Execute.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/RIVALS-ESP-and-skin-chnager-OP-SKIN-CHNAGER-220733"))()
end)
