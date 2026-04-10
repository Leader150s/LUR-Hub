-- LUR HUB Script
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")

-- إعداد الواجهة
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- خلفية رمادية غامقة
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- تقدر تحركها بيدك على الشاشة

-- العنوان (LUR HUB) باللون الأزرق الملكي
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "LUR HUB"
Title.BackgroundColor3 = Color3.fromRGB(0, 35, 102) -- Royal Blue
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- زر السرعة
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0, 10, 0, 45)
SpeedBtn.Size = UDim2.new(0, 140, 0, 40)
SpeedBtn.Text = "سرعة خارقة"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- زر القفز
JumpBtn.Parent = MainFrame
JumpBtn.Position = UDim2.new(0, 10, 0, 95)
JumpBtn.Size = UDim2.new(0, 140, 0, 40)
JumpBtn.Text = "قفزة عالية"
JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
end)
