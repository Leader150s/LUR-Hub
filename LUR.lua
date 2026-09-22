-- Roblox Steal An Egg - Auto Glitch & Fast Fly Script
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- ==================== إعدادات السكربت ====================
local FLY_SPEED = 150 -- سرعة الطيران لمنطقة الأمان
local SAFE_ZONE_POS = Vector3.new(526.7, 70.4, -366.8) -- إحداثيات منطقة الأمان الخاصة بك

-- وظيفة لتجاوز الضغط المطول (E) وسرقة البيضة فوراً
local function stealEgg(prompt)
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

-- وظيفة الطيران السريع للارتفاع ثم الانتقال لمنطقة الأمان
local function flyToSafeZone(targetPos)
    local hrp = Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    -- 1. الطيران المباشر للأعلى لتفادي العوائق
    local highPos = Vector3.new(hrp.Position.X, hrp.Position.Y + 60, hrp.Position.Z)
    local tweenUpInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenUp = TweenService:Create(hrp, tweenUpInfo, {CFrame = CFrame.new(highPos)})
    tweenUp:Play()
    tweenUp.Completed:Wait()

    -- 2. الطيران السريع أفقياً فوق منطقة الأمان
    local highTargetPos = Vector3.new(targetPos.X, highPos.Y, targetPos.Z)
    local distance = (highPos - highTargetPos).Magnitude
    local flyDuration = distance / FLY_SPEED
    
    local tweenFlyInfo = TweenInfo.new(flyDuration, Enum.EasingStyle.Linear)
    local tweenFly = TweenService:Create(hrp, tweenFlyInfo, {CFrame = CFrame.new(highTargetPos)})
    tweenFly:Play()
    tweenFly.Completed:Wait()

    -- 3. الهبوط إلى منطقة الأمان
    local tweenDown = TweenService:Create(hrp, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {CFrame = CFrame.new(targetPos)})
    tweenDown:Play()
    tweenDown.Completed:Wait()
end

-- ==================== تنفيذ القلتش ====================
local function runEggGlitch()
    -- البحث عن عناصر البيض في الماب
    local startEggPrompt = workspace:FindFirstChild("StartEgg", true) or workspace:FindFirstChildOfClass("ProximityPrompt")
    local strongEggPrompt = workspace:FindFirstChild("StrongEgg", true)

    -- الخطوة 1: الذهاب لبيضة الدجاجة الأولى وسرقتها
    if startEggPrompt and startEggPrompt.Parent then
        HumanoidRootPart.CFrame = startEggPrompt.Parent.CFrame * CFrame.new(0, 2, 0)
        task.wait(0.2)
        stealEgg(startEggPrompt)
    end

    -- الخطوة 2: انتظار ضربة الدجاجة (تفعيل القلتش)
    local startHealth = Humanoid.Health
    local healthConnection
    healthConnection = Humanoid.HealthChanged:Connect(function(newHealth)
        if newHealth < startHealth then
            healthConnection:Disconnect()
        end
    end)

    task.wait(2)
    if healthConnection then healthConnection:Disconnect() end

    -- الخطوة 3: الانتقال للبيضة الأقوى وسرقتها فوراً
    if strongEggPrompt and strongEggPrompt.Parent then
        HumanoidRootPart.CFrame = strongEggPrompt.Parent.CFrame * CFrame.new(0, 2, 0)
        task.wait(0.2)
        stealEgg(strongEggPrompt)
    end

    -- الخطوة 4: الطيران السريع للأعلى والذهاب لمنطقة الأمان
    flyToSafeZone(SAFE_ZONE_POS)
end

-- تشغيل السكربت
runEggGlitch()
