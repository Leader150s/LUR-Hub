-- سكربت 🪄┃˚₊ 𝑲𝒂𝒊𝒛𝒐 لسرقة البيض والسرعة الثابتة
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- إزالة الواجهة القديمة إذا كانت موجودة لمنع التكرار
if CoreGui:FindFirstChild("KaizoHubGUI") then
    CoreGui.KaizoHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaizoHubGUI"
ScreenGui.Parent = CoreGui

-- الإطار الرئيسي للواجهة
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 230)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- عنوان الواجهة مع الاسم الجديد
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Title.Text = "🪄┃˚₊ 𝑲𝒂𝒊𝒛𝒐"
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
SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
SpeedBtn.Text = "تثبيت السرعة (60) 🔥"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14
SpeedBtn.Font = Enum.Font.GothamSemibold
SpeedBtn.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedBtn

local speedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
        SpeedBtn.Text = "تم تشغيل السرعة بنجاح! ✅"
    else
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
        SpeedBtn.Text = "إيقاف السرعة ❌"
    end
end)

-- حلقة لتطبيق السرعة باستمرار لضمان عدم توقفها
task.spawn(function()
    while true do
        task.wait(0.5)
        if speedEnabled then
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = 60
                end
            end)
        end
    end
end)

-- زر سرقة البيض التلقائي
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.9, 0, 0, 45)
StealBtn.Position = UDim2.new(0.05, 0, 0, 110)
StealBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
StealBtn.Text = "سرقة البيض تلقائياً 🛒"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 14
StealBtn.Font = Enum.Font.GothamSemibold
StealBtn.Parent = MainFrame

local StealCorner = Instance.new("UICorner")
StealCorner.CornerRadius = UDim.new(0, 8)
StealCorner.Parent = StealBtn

StealBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = char.HumanoidRootPart
        local targetFound = false
        
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = string.lower(obj.Name)
            if (name:find("egg") or name:find("nest") or name:find("بيض") or name:find("عش")) then
                if obj:IsA("BasePart") then
                    rootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                    targetFound = true
                    break
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    rootPart.CFrame = obj.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
                    targetFound = true
                    break
                end
            end
        end
        
        if targetFound then
            StealBtn.Text = "تم النقل وسرقة البيضة! ✨"
        else
            StealBtn.Text = "ماكو بيض ظاهر حالياً ⚠️"
        end
        task.wait(2)
        StealBtn.Text = "سرقة البيض تلقائياً 🛒"
    end)
end)

-- زر إخفاء/إظهار الواجهة (Toggle) بدل الإغلاق النهائي
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 30)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 165)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
ToggleBtn.Text = "تصغير / إخفاء القائمة 📱"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- زر عائم صغير يظهر لما تخفي القائمة حتى ترجع تفتحها
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 10, 0.4, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
OpenButton.Text = "🪄"
OpenButton.TextSize = 20
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 22)
OpenCorner.Parent = OpenButton

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)
