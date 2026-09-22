-- Roblox Steal An Egg - Mobile GUI Hub
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ==================== الإعدادات ====================
local SAFE_ZONE = Vector3.new(526.7, 70.4, -366.8) -- إحداثيات منطقتك الآمنة
local FLY_SPEED = 180 -- سرعة الطيران

-- ==================== إنشاء الواجهة (GUI) ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealEggMobileUI"

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- النافذة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 230, 0, 160)
MainFrame.Position = UDim2.new(0.5, -115, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- تحريك الواجهة باللمس
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- عنوان الواجهة
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
Title.Text = "🥚 Steal Egg Hub | الجوال"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 12)

-- ==================== وظيفة الطيران للأمان ====================
local function flyToSafeZone()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- 1. الطيران للأعلى لتفادي الجدران
    local highPos = Vector3.new(hrp.Position.X, hrp.Position.Y + 70, hrp.Position.Z)
    local tweenUp = TweenService:Create(hrp, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(highPos)})
    tweenUp:Play()
    tweenUp.Completed:Wait()

    -- 2. الطيران السريع نحو منطقة الأمان
    local targetHighPos = Vector3.new(SAFE_ZONE.X, highPos.Y, SAFE_ZONE.Z)
    local distance = (highPos - targetHighPos).Magnitude
    local duration = distance / FLY_SPEED
    local tweenFly = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetHighPos)})
    tweenFly:Play()
    tweenFly.Completed:Wait()

    -- 3. الهبوط لمنطقة الأمان
    local tweenDown = TweenService:Create(hrp, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {CFrame = CFrame.new(SAFE_ZONE)})
    tweenDown:Play()
    tweenDown.Completed:Wait()
end

-- ==================== وظيفة التفاعل والسرقة ====================
local function doSteal(prompt)
    if prompt then
        if fireproximityprompt then
            fireproximityprompt(prompt)
        else
            prompt.HoldDuration = 0
            prompt:InputHoldBegin()
            task.wait(0.05)
            prompt:InputHoldEnd()
        end
    end
end

-- ==================== الأزرار ====================

-- زر 1: سرقة أقرب بيضة والطيران تلقائياً
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.9, 0, 0, 40)
StealBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
StealBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
StealBtn.Text = "⚡ سرقة أقرب بيضة + طيران"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 13
StealBtn.Font = Enum.Font.SourceSansBold
StealBtn.Parent = MainFrame
Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 8)

StealBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- البحث عن أقرب بيضة
    local closestPrompt = nil
    local minDist = math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.Enabled then
            local part = v.Parent
            if part and part:IsA("BasePart") then
                local dist = (hrp.Position - part.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closestPrompt = v
                end
            end
        end
    end

    if closestPrompt then
        -- الانتقال للبيضة، سرقتها، ثم الطيران فوراً
        hrp.CFrame = closestPrompt.Parent.CFrame * CFrame.new(0, 3, 0)
        task.wait(0.15)
        doSteal(closestPrompt)
        task.wait(0.1)
        flyToSafeZone()
    else
        flyToSafeZone()
    end
end)

-- زر 2: طيران يدوي مباشر للأمان
local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0.9, 0, 0, 40)
FlyBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
FlyBtn.Text = "🛡️ طيران مباشر للمنطقة الآمنة"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.TextSize = 13
FlyBtn.Font = Enum.Font.SourceSansBold
FlyBtn.Parent = MainFrame
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 8)

FlyBtn.MouseButton1Click:Connect(function()
    flyToSafeZone()
end)

-- ==================== تفعيل الطيران التلقائي عند الضغط اليدوي على E ====================
ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player == LocalPlayer then
        task.wait(0.1)
        flyToSafeZone()
    end
end)
