
-- LUR HUB FINAL TEST
local sg = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(0, 35, 102)
frame.Active = true
frame.Draggable = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, -20, 1, -20)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.Text = "START FARM"
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)

local f = false
btn.MouseButton1Click:Connect(function()
    f = not f
    btn.Text = f and "WORKING..." or "START FARM"
    spawn(function()
        while f do
            task.wait()
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                    end
                end
            end)
        end
    end)
end)
