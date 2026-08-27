-- Kaizo Hub - Ultimate Fixed Version
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

-- خلفية صورتك الخاصة في الواجهة
local BgImage = Instance.new("ImageLabel")
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "rbxassetid://10511856020"
BgImage.ImageTransparency = 0.4
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.Parent = MainFrame

-- عنوان الواجهة
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Title.BackgroundTransparency = 0.3
Title.Text = "🪄┃˚₊ 𝑲𝒂𝒊𝒛𝒐 Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = Title

-- زر تفعيل السرعة الفائقة (تبدأ مفعلة مباشرة أو بضغطة زر بقوة 600)
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 42)
SpeedBtn.Position = UDim2.new(0.05, 0, 0, 55)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
SpeedBtn.BackgroundTransparency = 0.2
SpeedBtn.Text = "تفعيل سرعة خارقة (600) 🔥"
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
        SpeedBtn.Text = "تم تفعيل السرعة بنجاح! ✅"
    else
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(41, 128, 185)
        SpeedBtn.Text = "تم إيقاف السرعة ❌"
    end
end)

-- حلقة لتثبيت السرعة الخارقة باستمرار
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

-- زر سرقة البيضة الفعلي (مع تفعيل اللمس وسحب البيضة صح) والطيران للأمان
local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0.9, 0, 0, 42)
StealBtn.Position = UDim2.new(0.05, 0, 0, 110)
StealBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
StealBtn.BackgroundTransparency = 0.2
StealBtn.Text = "سرقة البيضة والطيران للأمان 🛒"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 13
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
        
        -- البحث المتقدم عن البيض والاعشاش
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
                    -- الانتقال للبيضة
                    rootPart.CFrame = targetPart.CFrame + Vector3.new(0, 1.5, 0)
                    targetFound = true
                    
                    -- محاكاة اللمس الفعلي لجمع البيضة (TouchInterest)
                    task.wait(0.1)
                    for _, part in pairs(obj:GetDescendants()) do
                        if part:IsA("BasePart") then
                            firetouchinterest(rootPart, part, 0)
                            firetouchinterest(rootPart, part, 1)
                        end
                    end
                    
                    break
                end
            end
        end
        
        if targetFound then
            StealBtn.Text = "جاري الطيران لمنطقة الأمان.. 🕊️"
            task.wait(0.25)
            
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
            
            StealBtn.Text = "تمت السرقة والوصول للأمان! ✨"
        else
            StealBtn.Text = "ماكو بيض ظاهر حالياً ⚠️"
        end
        
        task.wait(2)
        StealBtn.Text = "سرقة البيضة والطيران للأمان 🛒"
    end)
end)

-- زر إخفاء القائمة مؤقتاً (موضوع تماماً تحت زر السرقة)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 165)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Text = "إخفاء القائمة مؤقتاً 📱"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- الأيقونة العائمة (صورتك الشخصية الدائرية التي تظهر على الشاشة عند إخفاء القائمة لإعادة فتحها)
local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.new(0, 55, 0, 55)
OpenButton.Position = UDim2.new(0, 15, 0.4, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
OpenButton.Image = "rbxassetid://10511856020"
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
