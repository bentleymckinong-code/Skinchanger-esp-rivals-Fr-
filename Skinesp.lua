--// Load Script
loadstring(game:HttpGet("https://rawscripts.net/raw/RIVALS-ESP-and-skin-chnager-OP-SKIN-CHNAGER-220733"))()

--// Wait for GUI
wait(1)

local UIS = game:GetService("UserInputService")

--// Make Frames Draggable
for _, frame in pairs(game.CoreGui:GetDescendants()) do
    if frame:IsA("Frame") then

        local dragging = false
        local dragInput
        local dragStart
        local startPos

        frame.Active = true

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart

                frame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end
end
