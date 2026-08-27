-- Kaizo Hub - Ultimate Edition for Roblox Delta
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- إزالة الواجهة القديمة لمنع التكرار
if CoreGui:FindFirstChild("KaizoHubGUI") then
    CoreGui.KaizoHubGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaizoHubGUI"
ScreenGui.Parent = CoreGui

-- الإطار الرئيسي للواجهة
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 270)
MainFrame.Position = UDim2.new(0.5, -150, 0.4, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- خلفية الواجهة (شفافة ومرتبة)
local BgImage = Instance.new("ImageLabel")
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "rbxassetid://6034845063"
BgImage.ImageTransparency = 0.85
BgImage.ScaleType = Enum.ScaleType.Slice
BgImage.Parent = MainFrame

-- عنوان الواجهة (باللغة الإنجليزية لمنع ظهور المربعات)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
Title.Text = "🪄 Kaizo Hub - Steal Egg"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = Title

-- زر تفعيل السرعة العالية (600)
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 42)
SpeedBtn.Position = UDim2.new(0.05, 0, 0, 55)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
SpeedBtn.Text = "Speed Hack (600) 🔥"
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
        SpeedBtn.Text = "Speed Enabled! ✅"
    else
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
        SpeedBtn.Text = "Speed Disabled ❌"
    end
end)

-- حلقة فرض السرعة الحقيقية (600) باستمرار لمنع الماب من إرجاعها
task.spawn(function()
    while true do
        task.wait(0.2)
        if speedEnabled then
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.WalkSpeed = 600
                end
            end)
        end
    end
end)

-- زر سرقة البيض الفعلي + الطيران السلس لمنطقة الأمان
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.9, 0, 0, 42)
StealBtn.Position = UDim2.new(0.05, 0, 0, 110)
StealBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
StealBtn.Text = "Auto Steal & Safe 🛒"
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
        local savedPos = rootPart.CFrame
        
        -- البحث عن البيض والاعشاش
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = string.lower(obj.Name)
            if (name:find("egg") or name:find("nest") or name:find("بيض") or name:find("عش")) then
                local targetPart = nil
                if obj:IsA("BasePart") then
                    targetPart = obj
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    targetPart = obj.PrimaryPart
                end
                
                if targetPart then
                    rootPart.CFrame = targetPart.CFrame + Vector3.new(0, 2, 0)
                    targetFound = true
                    
                    -- تفعيل البرومبت أو الضغط للسرقة الحقيقية
                    task.wait(0.1)
                    for _, child in pairs(obj:GetDescendants()) do
                        if child:IsA("ProximityPrompt") then
                            fireproximityprompt(child)
                        end
                    end
                    
                    break
                end
            end
        end
        
        if targetFound then
            StealBtn.Text = "Flying to Safezone... 🕊️"
            task.wait(0.2)
            
            local spawnLocation = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Spawn")
            local targetCFrame = savedPos + Vector3.new(0, 3, 0)
            if spawnLocation and spawnLocation:IsA("BasePart") then
                targetCFrame = spawnLocation.CFrame + Vector3.new(0, 3, 0)
            end
            
            -- طيران سلس سريع لمنطقة الأمان
            local distance = (rootPart.Position - targetCFrame.Position).Magnitude
            local travelTime = math.clamp(distance / 150, 0.2, 1.0)
            
            local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
            tween.Completed:Wait()
            
            StealBtn.Text = "Stolen & Safe! ✨"
        else
            StealBtn.Text = "No Eggs Found ⚠️"
        end
        
        task.wait(2)
        StealBtn.Text = "Auto Steal & Safe 🛒"
    end)
end)

-- زر إخفاء القائمة مؤقتاً (موضوع تحت الأزرار تماماً)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 165)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
ToggleBtn.Text = "Minimize Menu 📱"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- الأيقونة العائمة لإعادة فتح القائمة
local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.new(0, 55, 0, 55)
OpenButton.Position = UDim2.new(0, 15, 0.4, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
OpenButton.Image = "rbxassetid://6031097225"
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 28)
OpenCorner.Parent = OpenButton

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)
