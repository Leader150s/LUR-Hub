-- ===================================================
-- 👑 BEN HUB - Main Script (LUR.lua)
-- ===================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- إنشاء الواجهة الرسمية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BEN_HUB_GUI"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- الإطار الرئيسي بتصميم الصورة بالضبط
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 270)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 10, 12)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local FrameBorder = Instance.new("UIStroke", MainFrame)
FrameBorder.Color = Color3.fromRGB(200, 30, 40)
FrameBorder.Thickness = 1.5

-- 🔴 الشريط العلوي (TitleBar)
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundTransparency = 1

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(0.35, 0, 1, 0)
TitleText.Position = UDim2.new(0.03, 0, 0, 0)
TitleText.Text = "👑 BEN HUB"
TitleText.TextColor3 = Color3.fromRGB(220, 40, 50)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

-- عداد التجارب والأونلاين
local StatsText = Instance.new("TextLabel", TitleBar)
StatsText.Size = UDim2.new(0.4, 0, 1, 0)
StatsText.Position = UDim2.new(0.38, 0, 0, 0)
StatsText.Text = "👥 التجارب: 1845 | 🟢 أونلاين: 5"
StatsText.TextColor3 = Color3.fromRGB(220, 220, 220)
StatsText.Font = Enum.Font.SourceSans
StatsText.TextSize = 11
StatsText.BackgroundTransparency = 1

-- زر الإغلاق X
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 24, 0, 22)
CloseBtn.Position = UDim2.new(0.93, 0, 0.15, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- زر التصغير 🧺
local MinimizeBtn = Instance.new("TextButton", TitleBar)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 22)
MinimizeBtn.Position = UDim2.new(0.86, 0, 0.15, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 25)
MinimizeBtn.Text = "🧺"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.SourceSans
MinimizeBtn.TextSize = 11
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 4)

-- 📋 قائمة الأزرار اليسارية (Side Bar)
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0.28, 0, 0.85, 0)
SideBar.Position = UDim2.new(0.02, 0, 0.12, 0)
SideBar.BackgroundTransparency = 1

local SideLayout = Instance.new("UIListLayout", SideBar)
SideLayout.Padding = UDim.new(0, 6)

-- إطار المحتوى الأيمن (Pages Frame)
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(0.66, 0, 0.85, 0)
ContentFrame.Position = UDim2.new(0.32, 0, 0.12, 0)
ContentFrame.BackgroundTransparency = 1

local ActivePage = nil
local ActiveButton = nil

local function createTabButton(name, icon)
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 15, 20)
    Btn.Text = icon .. "  " .. name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 11
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("Frame", ContentFrame)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(ContentFrame:GetChildren()) do
            if p:IsA("Frame") then p.Visible = false end
        end
        for _, b in pairs(SideBar:GetChildren()) do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(35, 15, 20) end
        end
        Page.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end)

    if not ActivePage then
        Page.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
        ActivePage = Page
    end

    return Page
end

-- ===================================================
-- 🥚 1. سرقة البيض
-- ===================================================
local EggPage = createTabButton("سرقة البيض", "⚪")
local EggLabel = Instance.new("TextLabel", EggPage)
EggLabel.Size = UDim2.new(1, 0, 0.3, 0)
EggLabel.Text = "🥚 ميزة سرقة البيض مفعلة وقيد التطوير السريع..."
EggLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EggLabel.Font = Enum.Font.SourceSansBold
EggLabel.TextSize = 12
EggLabel.BackgroundTransparency = 1

-- ===================================================
-- 🐾 2. ركوب الحيوانات
-- ===================================================
local MountPage = createTabButton("ركوب الحيوانات", "🐾")
local MountLabel = Instance.new("TextLabel", MountPage)
MountLabel.Size = UDim2.new(1, 0, 0.3, 0)
MountLabel.Text = "🐾 قسم ركوب الحيوانات المطور جاهز لخدمتك!"
MountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MountLabel.Font = Enum.Font.SourceSansBold
MountLabel.TextSize = 12
MountLabel.BackgroundTransparency = 1

-- ===================================================
-- 📜 3. مشغل السكريبتات
-- ===================================================
local ExecPage = createTabButton("مشغل السكريبتات", "📜")
local ExecBox = Instance.new("TextBox", ExecPage)
ExecBox.Size = UDim2.new(1, 0, 0.72, 0)
ExecBox.BackgroundColor3 = Color3.fromRGB(22, 11, 15)
ExecBox.PlaceholderText = "-- اكتب أو الصق الكود هنا..."
ExecBox.Text = ""
ExecBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBox.Font = Enum.Font.Code
ExecBox.TextSize = 10
ExecBox.TextXAlignment = Enum.TextXAlignment.Left
ExecBox.TextYAlignment = Enum.TextYAlignment.Top
ExecBox.ClearTextOnFocus = false
Instance.new("UICorner", ExecBox).CornerRadius = UDim.new(0, 5)

local RunBtn = Instance.new("TextButton", ExecPage)
RunBtn.Size = UDim2.new(1, 0, 0, 25)
RunBtn.Position = UDim2.new(0, 0, 0.77, 0)
RunBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
RunBtn.Text = "▶ تشغيل الكود"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 11
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 5)

RunBtn.MouseButton1Click:Connect(function()
    if ExecBox.Text ~= "" then
        pcall(function() loadstring(ExecBox.Text)() end)
    end
end)

-- ===================================================
-- 📰 4. قسم الشروحات وقنوات BEN HUB
-- ===================================================
local InfoPage = createTabButton("شروحات", "📰")
local InfoScroll = Instance.new("ScrollingFrame", InfoPage)
InfoScroll.Size = UDim2.new(1, 0, 1, 0)
InfoScroll.BackgroundTransparency = 1
InfoScroll.ScrollBarThickness = 2
local InfoLayout = Instance.new("UIListLayout", InfoScroll)
InfoLayout.Padding = UDim.new(0, 5)

local InfoHeader = Instance.new("TextLabel", InfoScroll)
InfoHeader.Size = UDim2.new(0.98, 0, 0, 45)
InfoHeader.BackgroundTransparency = 1
InfoHeader.Text = "🔥 **BEN HUB - تطوير المطور BEN** 🔥\nأهلاً بكم في قنواتنا الرسمية لشرح السكربتات وهكر الألعاب وتحميلات حصرية!"
InfoHeader.TextColor3 = Color3.fromRGB(255, 215, 0)
InfoHeader.Font = Enum.Font.SourceSansBold
InfoHeader.TextSize = 11
InfoHeader.TextWrapped = true

local setClipboard = setclipboard or toclipboard or set_clipboard

local function createSocialButton(name, url, icon, color)
    local Btn = Instance.new("TextButton", InfoScroll)
    Btn.Size = UDim2.new(0.98, 0, 0, 26)
    Btn.BackgroundColor3 = color
    Btn.Text = icon .. " " .. name .. " (اضغط للنسخ 📋)"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 10
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)

    Btn.MouseButton1Click:Connect(function()
        if setClipboard then
            setClipboard(url)
            Btn.Text = "✅ تم نسخ الرابط بنجاح!"
            task.wait(1.5)
            Btn.Text = icon .. " " .. name .. " (اضغط للنسخ 📋)"
        end
    end)
end

createSocialButton("تيك توك (TikTok)", "https://www.tiktok.com/@bir.y5?_r=1&_t=ZS-99wM1BhqjlE", "🎵", Color3.fromRGB(30, 30, 35))
createSocialButton("يوتيوب (YouTube)", "https://youtube.com/@gqj2?si=g29jzyAPCwcTxrED", "▶", Color3.fromRGB(180, 25, 25))
createSocialButton("تليجرام (Telegram)", "https://t.me/Ben_5k", "✈", Color3.fromRGB(25, 120, 190))
createSocialButton("سيرفر الديسكورد (Discord)", "https://discord.gg/BedyzxgaG", "💬", Color3.fromRGB(80, 100, 220))

-- ===================================================
-- 💬 5. قسم الشات السحابي المتصل بـ Firebase
-- ===================================================
local ChatPage = createTabButton("الشات", "💬")

task.spawn(function()
    local chatUrl = "https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/ChatModule.lua"
    local success, loadChat = pcall(function()
        return loadstring(game:HttpGet(chatUrl))()
    end)
    
    if success and type(loadChat) == "function" then
        loadChat(ChatPage)
    end
end)
