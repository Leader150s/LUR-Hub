-- LUR HUB FIX
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local FarmBtn = Instance.new("TextButton")

-- إعدادات الظهور
ScreenGui.Name = "LUR_GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 35, 102) -- Royal Blue
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true

FarmBtn.Parent = MainFrame
FarmBtn.Size = UDim2.new(1, -20, 0, 60)
FarmBtn.Position = UDim2.new(0, 10, 0, 20)
FarmBtn.Text = "تشغيل الأوتو فارم"
FarmBtn.TextScaled = true
FarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local farming = false
FarmBtn.MouseButton1Click:Connect(function()
    farming = not farming
    FarmBtn.Text = farming and "يعمل الان..." or "تشغيل الأوتو فارم"
    FarmBtn.BackgroundColor3 = farming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 40)
    
    task.spawn(function()
        while farming do
            task.wait()
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        -- طيران خلف الوحش
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        -- ضرب تلقائي
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                    end
                end
            end)
        end
    end)
end)
