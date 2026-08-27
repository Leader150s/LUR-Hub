-- واجهة سكربت دلتا لسرقة البيض والسرعة
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- إزالة الواجهة القديمة إذا كانت موجودة لمنع التكرار
if CoreGui:FindFirstChild("StealEggGUI") then
    CoreGui.StealEggGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealEggGUI"
ScreenGui.Parent = CoreGui

-- الإطار الرئيسي للواجهة
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 220)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- يقدر يحركها بالجوال بكل سهولة
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- عنوان الواجهة
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Title.Text = "🥚 Steal An Egg Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- زر تفعيل السرعة
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 45)
SpeedBtn.Position = UDim2.new(0.05, 0, 0, 55)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
SpeedBtn.Text = "تفعيل السرعة العالية (50)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14
SpeedBtn.Font = Enum.Font.GothamSemibold
SpeedBtn.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedBtn

SpeedBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 50
        SpeedBtn.Text = "تم تفعيل السرعة! 🔥"
        task.wait(1.5)
        SpeedBtn.Text = "تفعيل السرعة العالية (50)"
    end
end)

-- زر سرقة البيض التلقائي (البحث عن البيض أو الحيوانات وقريب منها)
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.9, 0, 0, 45)
StealBtn.Position = UDim2.new(0.05, 0, 0, 110)
StealBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
StealBtn.Text = "سرقة البيض القريب 🥚"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 14
StealBtn.Font = Enum.Font.GothamSemibold
StealBtn.Parent = MainFrame

local StealCorner = Instance.new("UICorner")
StealCorner.CornerRadius = UDim.new(0, 8)
StealCorner.Parent = StealBtn

StealBtn.MouseButton1Click:Connect(function()
    -- فكرة بسيطة لجمع أو سحب البيض الموجود بالماب (حسب مسميات الكائنات)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local foundEgg = false
    for _, obj in pairs(workspace:GetDescendants()) do
        -- ابحث عن أي مجلد أو جزء يحتوي على اسم Egg أو بيضة
        if obj:IsA("BasePart") and (string.lower(obj.Name):find("egg") or string.lower(obj.Name):find("بيض")) then
            -- نقل اللاعب نحو البيضة مباشرة لسرقتها
            char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
            foundEgg = true
            break
        end
    end
    
    if foundEgg then
        StealBtn.Text = "تم الانتقال وسرقة البيضة! ✨"
    else
        StealBtn.Text = "ماكو بيض قريب حالياً ❌"
    end
    task.wait(2)
    StealBtn.Text = "سرقة البيض القريب 🥚"
end)

-- زر إغلاق الواجهة
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0.9, 0, 0, 30)
CloseBtn.Position = UDim2.new(0.05, 0, 0, 165)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.Text = "إغلاق القائمة"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize, CloseBtn.Font = 12, Enum.Font.Gotham
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
