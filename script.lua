-- LUR HUB - Blox Fruits Edition
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")

-- إعدادات الواجهة
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "LUR HUB BF"
Title.BackgroundColor3 = Color3.fromRGB(0, 35, 102) -- Royal Blue
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- زر الأوتو فارم (Auto Attack)
local farming = false
FarmBtn.Parent = MainFrame
FarmBtn.Position = UDim2.new(0, 10, 0, 45)
FarmBtn.Size = UDim2.new(0, 140, 0, 40)
FarmBtn.Text = "أوتو فارم: مطفأ"
FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

FarmBtn.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        FarmBtn.Text = "أوتو فارم: يعمل"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        FarmBtn.Text = "أوتو فارم: مطفأ"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
    
    -- حلقة الضرب التلقائي
    spawn(function()
        while farming do
            pcall(function()
                local combat = game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
                if combat then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(combat)
                    -- البحث عن أقرب وحش وضربه
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 20 then
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                        end
                    end
                end
            end)
            wait(0.1)
        end
    end)
end)

-- زر السرعة (معدل لبلوكس فروت)
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0, 10, 0, 95)
SpeedBtn.Size = UDim2.new(0, 140, 0, 40)
SpeedBtn.Text = "سرعة خفيفة (أمنة)"
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 40 -- سرعة 40 أمنة من الطرد
end)
