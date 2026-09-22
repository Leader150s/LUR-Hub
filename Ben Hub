-- ===================================================
-- 👑 BEN HUB (LUR HUB) - الكود النهائي المعدل (خلفية سوداء وتحسين المظهر)
-- ===================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- روابط الفايربيس والويب هوك والصوت
local FIREBASE_BASE = "https://benhubchat-24010-default-rtdb.firebaseio.com/"
local CHAT_URL = FIREBASE_BASE .. "chat.json"
local ONLINE_URL = FIREBASE_BASE .. "stats/online/" .. tostring(LocalPlayer.UserId) .. ".json"
local ALL_ONLINE_URL = FIREBASE_BASE .. "stats/online.json"
local SUGGESTION_WEBHOOK = "https://discord.com/api/webhooks/1551892613815074937/DNm0s4PFO6uzMybJ353SgRcV0aW90VmRd1rf8TAF3pzag3zyp2cqq4YO8wFV9My4TJp_"
local INTRO_AUDIO_URL = "https://www.image2url.com/r2/default/audio/1790084303441-4ae1a589-e734-4af5-a5e1-78c3dd1b0e0a.mp3"

local request = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request) or (krnl and krnl.request)
local setclipboard = setclipboard or toclipboard or set_clipboard or (syn and syn.write_clipboard)
local gethui = gethui or function() return CoreGui end

-- ==================== 1. تحميل الصور والوسائط ====================
local function loadAsset(url, filename)
    if writefile and readfile and getcustomasset then
        pcall(function()
            if not pcall(function() readfile(filename) end) then
                writefile(filename, game:HttpGet(url))
            end
        end)
        local success, asset = pcall(function() return getcustomasset(filename) end)
        if success then return asset end
    end
    return url
end

local BG_IMAGE_ID = loadAsset("https://f.top4top.io/p_3917lvgp10.png", "LURHub_BG.png")
local TOGGLE_IMAGE_ID = loadAsset("https://g.top4top.io/p_3917nj3r41.png", "LURHub_Icon.png")

-- صور المنصات الاجتماعية
local TIKTOK_IMG = loadAsset("https://c.top4top.io/p_3917y7udu0.jpg", "TikTok_Icon.jpg")
local YOUTUBE_IMG = loadAsset("https://d.top4top.io/p_3917edrzh1.jpg", "YouTube_Icon.jpg")
local TELEGRAM_IMG = loadAsset("https://e.top4top.io/p_3917nmbx32.jpg", "Telegram_Icon.jpg")
local DISCORD_IMG = loadAsset("https://f.top4top.io/p_3917ieixk3.jpg", "Discord_Icon.jpg")

-- ==================== 2. نظام التشفير والفلترة ====================
local ForbiddenWords = {"سب", "كفر", "فشار", "امك", "أمك", "اختك", "أختك", "ابوك", "أبوك", "كس", "قحبة", "طيز", "زق", "شرموط", "خرية", "منيك", "قحب"}
local LinkPatterns = {"https?://%S+", "www%.%S+", "discord%.gg/%S+", "%.com", "%.net", "%.org", "%.gg"}

local function isCleanText(text)
    local lowerText = string.lower(text)
    for _, pattern in pairs(LinkPatterns) do
        if string.find(lowerText, pattern) then return false, "ممنوع نشر الروابط!" end
    end
    for _, word in ipairs(ForbiddenWords) do
        if string.find(lowerText, string.lower(word)) then return false, "كلمات محظورة ومسيئة!" end
    end
    return true
end

-- ==================== 3. إنشاء الشاشة الرئيسية ====================
local ParentGui = gethui() or CoreGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LURHub_v3UI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

pcall(function() ScreenGui.Parent = ParentGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- تشغيل صوت الترحيب بصوت عالٍ
task.spawn(function()
    local soundAsset = loadAsset(INTRO_AUDIO_URL, "BenHub_IntroSound.mp3")
    local introSound = Instance.new("Sound", ParentGui)
    introSound.SoundId = soundAsset
    introSound.Volume = 10
    introSound:Play()
end)

-- شاشة التحميل السوداء بالكامل مع تحسين المظهر والانيميشن
local SplashFrame = Instance.new("Frame", ScreenGui)
SplashFrame.Size = UDim2.new(1, 0, 1, 0)
SplashFrame.Position = UDim2.new(0, 0, 0, 0)
SplashFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SplashFrame.BorderSizePixel = 0
SplashFrame.ZIndex = 500
SplashFrame.ClipsDescendants = true

-- اللوجو في المنتصف مع تأثير ظهور احترافي
local CenterLogo = Instance.new("ImageLabel", SplashFrame)
CenterLogo.Size = UDim2.new(0, 0, 0, 0)
CenterLogo.Position = UDim2.new(0.5, 0, 0.38, 0)
CenterLogo.Image = TOGGLE_IMAGE_ID
CenterLogo.BackgroundTransparency = 1
CenterLogo.ZIndex = 503
Instance.new("UICorner", CenterLogo).CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", CenterLogo)
LogoStroke.Color = Color3.fromRGB(255, 40, 50)
LogoStroke.Thickness = 3

TweenService:Create(CenterLogo, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 130, 0, 130),
    Position = UDim2.new(0.5, -65, 0.38, -65)
}):Play()

-- النص المطلوب أسفل اللوجو بتصميم جذاب
local LoadingText = Instance.new("TextLabel", SplashFrame)
LoadingText.Size = UDim2.new(0.9, 0, 0, 60)
LoadingText.Position = UDim2.new(0.05, 0, 0.58, 0)
LoadingText.Text = "جاري تحميل سكربت من صنع Ben عربي بلكامل تسهيل جميع خدمات هاك روبلوكس"
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.TextSize = 19
LoadingText.TextWrapped = true
LoadingText.BackgroundTransparency = 1
LoadingText.TextTransparency = 1
LoadingText.ZIndex = 503

local TextStroke = Instance.new("UIStroke", LoadingText)
TextStroke.Color = Color3.fromRGB(220, 30, 40)
TextStroke.Thickness = 1.5

TweenService:Create(LoadingText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()

-- ==================== 4. الواجهة الرئيسية للهاب ====================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 290)
MainFrame.Position = UDim2.new(0.5, -230, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 1
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(220, 30, 40)
UIStroke.Thickness = 2

local BackgroundImg = Instance.new("ImageLabel", MainFrame)
BackgroundImg.Size = UDim2.new(1, 0, 1, 0)
BackgroundImg.Image = BG_IMAGE_ID
BackgroundImg.BackgroundTransparency = 1
BackgroundImg.ImageTransparency = 0.55
BackgroundImg.ScaleType = Enum.ScaleType.Crop
BackgroundImg.ZIndex = 1

local isChatDraggable = false

local function makeDraggable(guiObject, isChatWindow)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if isChatWindow and not isChatDraggable then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if isChatWindow and not isChatDraggable then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            if isChatWindow and not isChatDraggable then dragging = false return end
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(MainFrame, false)

-- إنهاء شاشة التحميل السوداء بسلاسة واحترافية
task.delay(3.2, function()
    TweenService:Create(SplashFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    TweenService:Create(CenterLogo, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    TweenService:Create(LoadingText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
    
    task.wait(0.7)
    SplashFrame:Destroy()
    MainFrame.Visible = true
end)

-- ==================== 5. زر فتح/إغلاق الهاب العائم ====================
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Name = "LURHubToggleBtn"
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.Image = TOGGLE_IMAGE_ID
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Visible = false
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(220, 30, 40)
ToggleStroke.Thickness = 2

makeDraggable(ToggleBtn, false)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== 6. الشريط العلوي والعداد ====================
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 10, 12)
TopBar.BackgroundTransparency = 0.2
TopBar.ZIndex = 10
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.35, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Text = "👑 Ben Hub"
Title.TextColor3 = Color3.fromRGB(255, 40, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local CounterFrame = Instance.new("Frame", TopBar)
CounterFrame.Size = UDim2.new(0.35, 0, 0.7, 0)
CounterFrame.Position = UDim2.new(0.50, 0, 0.15, 0)
CounterFrame.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
CounterFrame.BackgroundTransparency = 0.3
CounterFrame.ZIndex = 11
Instance.new("UICorner", CounterFrame).CornerRadius = UDim.new(0, 6)

local StatsLabel = Instance.new("TextLabel", CounterFrame)
StatsLabel.Size = UDim2.new(1, 0, 1, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(255, 220, 220)
StatsLabel.Font = Enum.Font.SourceSansBold
StatsLabel.TextSize = 12
StatsLabel.Text = "🟢 أونلاين: 1"
StatsLabel.ZIndex = 12

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(0.91, 0, 0.16, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
    ToggleBtn.Visible = true 
end)

local function updateOnlineStats()
    if request then
        pcall(function()
            request({
                Url = ONLINE_URL,
                Method = "PUT",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({lastSeen = os.time()})
            })
        end)
    end
    pcall(function()
        local resBody = game:HttpGet(ALL_ONLINE_URL)
        if resBody and resBody ~= "null" and resBody ~= "" then
            local data = HttpService:JSONDecode(resBody)
            if type(data) == "table" then
                local activeUsers = 0
                local now = os.time()
                for uid, userStat in pairs(data) do
                    if type(userStat) == "table" and userStat.lastSeen and (now - userStat.lastSeen < 35) then
                        activeUsers = activeUsers + 1
                    end
                end
                StatsLabel.Text = "🟢 أونلاين: " .. tostring(math.max(1, activeUsers))
            end
        end
    end)
end

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        updateOnlineStats()
        task.wait(6)
    end
end)

-- ==================== 7. القائمة والتبويبات ====================
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 115, 1, -48)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
Sidebar.BackgroundTransparency = 0.3
Sidebar.ZIndex = 10
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -130, 1, -48)
Container.Position = UDim2.new(0, 125, 0, 45)
Container.BackgroundTransparency = 1
Container.ZIndex = 10

local Tabs, Pages = {}, {}

local function switchToTab(targetIndex)
    for i, p in pairs(Pages) do p.Visible = (i == targetIndex) end
    for i, b in pairs(Tabs) do 
        b.BackgroundColor3 = (i == targetIndex) and Color3.fromRGB(190, 25, 35) or Color3.fromRGB(30, 15, 20)
    end
end

local function createTab(name, icon)
    local tabIndex = #Tabs + 1
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, (tabIndex - 1) * 31 + 4)
    btn.BackgroundColor3 = (tabIndex == 1) and Color3.fromRGB(190, 25, 35) or Color3.fromRGB(30, 15, 20)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.ZIndex = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("Frame", Container)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (tabIndex == 1)
    page.ZIndex = 10

    btn.MouseButton1Click:Connect(function() switchToTab(tabIndex) end)

    table.insert(Tabs, btn)
    table.insert(Pages, page)
    return page, tabIndex
end

local TutorialsPage, TutorialsIndex = createTab("الشروحات", "🎥")
local ExecutorPage, ExecutorIndex = createTab("مشغل السكربتات", "📜")
local SuggestionsPage, SuggestionsIndex = createTab("اقتراحات", "💡")
local KeysPage, KeysIndex = createTab("قسم المفاتيح", "🔑")
local StealEggPage, StealEggIndex = createTab("سرقة البيض", "🥚")
local RidePetPage, RidePetIndex = createTab("ركوب الحيوانات", "🐾")

-- ==================== 8. زر الشات العلوي والقفل ====================
local ChatExtBtn = Instance.new("TextButton", ScreenGui)
ChatExtBtn.Name = "RobloxTopChatBtn"
ChatExtBtn.Size = UDim2.new(0, 36, 0, 36)
ChatExtBtn.Position = UDim2.new(0, 235, 0, 4)
ChatExtBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ChatExtBtn.BackgroundTransparency = 0.5
ChatExtBtn.Text = "💬"
ChatExtBtn.TextSize = 18
ChatExtBtn.ZIndex = 100
Instance.new("UICorner", ChatExtBtn).CornerRadius = UDim.new(0, 8)

local ChatExtStroke = Instance.new("UIStroke", ChatExtBtn)
ChatExtStroke.Color = Color3.fromRGB(255, 40, 50)
ChatExtStroke.Thickness = 1.5

local ChatFrame = Instance.new("Frame", ScreenGui)
ChatFrame.Name = "RobloxStyleChatFrame"
ChatFrame.Size = UDim2.new(0, 270, 0, 210)
ChatFrame.Position = UDim2.new(0, 15, 0, 50)
ChatFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ChatFrame.BackgroundTransparency = 0.15
ChatFrame.Visible = false
ChatFrame.ZIndex = 90
Instance.new("UICorner", ChatFrame).CornerRadius = UDim.new(0, 10)

local ChatFrameStroke = Instance.new("UIStroke", ChatFrame)
ChatFrameStroke.Color = Color3.fromRGB(220, 30, 40)
ChatFrameStroke.Thickness = 1.5

makeDraggable(ChatFrame, true)

local ChatTitle = Instance.new("TextLabel", ChatFrame)
ChatTitle.Size = UDim2.new(1, -60, 0, 25)
ChatTitle.Position = UDim2.new(0, 8, 0, 2)
ChatTitle.Text = "💬 الشات العام (Ben Hub)"
ChatTitle.TextColor3 = Color3.fromRGB(255, 60, 70)
ChatTitle.Font = Enum.Font.SourceSansBold
ChatTitle.TextSize = 11
ChatTitle.TextXAlignment = Enum.TextXAlignment.Left
ChatTitle.BackgroundTransparency = 1
ChatTitle.ZIndex = 91

local LockChatBtn = Instance.new("TextButton", ChatFrame)
LockChatBtn.Size = UDim2.new(0, 22, 0, 20)
LockChatBtn.Position = UDim2.new(1, -50, 0, 4)
LockChatBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
LockChatBtn.Text = "🔒"
LockChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LockChatBtn.Font = Enum.Font.SourceSansBold
LockChatBtn.TextSize = 12
LockChatBtn.ZIndex = 91
Instance.new("UICorner", LockChatBtn).CornerRadius = UDim.new(0, 4)

LockChatBtn.MouseButton1Click:Connect(function()
    isChatDraggable = not isChatDraggable
    if isChatDraggable then
        LockChatBtn.Text = "🔓"
        LockChatBtn.BackgroundColor3 = Color3.fromRGB(30, 160, 40)
    else
        LockChatBtn.Text = "🔒"
        LockChatBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end
end)

local ChatCloseBtn = Instance.new("TextButton", ChatFrame)
ChatCloseBtn.Size = UDim2.new(0, 20, 0, 20)
ChatCloseBtn.Position = UDim2.new(1, -24, 0, 4)
ChatCloseBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
ChatCloseBtn.Text = "X"
ChatCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatCloseBtn.Font = Enum.Font.SourceSansBold
ChatCloseBtn.TextSize = 11
ChatCloseBtn.ZIndex = 91
Instance.new("UICorner", ChatCloseBtn).CornerRadius = UDim.new(0, 4)

ChatCloseBtn.MouseButton1Click:Connect(function() ChatFrame.Visible = false end)
ChatExtBtn.MouseButton1Click:Connect(function() ChatFrame.Visible = not ChatFrame.Visible end)

local GlobalChatScroll = Instance.new("ScrollingFrame", ChatFrame)
GlobalChatScroll.Size = UDim2.new(0.96, 0, 0.70, 0)
GlobalChatScroll.Position = UDim2.new(0.02, 0, 0.14, 0)
GlobalChatScroll.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GlobalChatScroll.BackgroundTransparency = 0.4
GlobalChatScroll.ScrollBarThickness = 2
GlobalChatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
GlobalChatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
GlobalChatScroll.ZIndex = 91
Instance.new("UICorner", GlobalChatScroll).CornerRadius = UDim.new(0, 6)

local GlobalLayout = Instance.new("UIListLayout", GlobalChatScroll)
GlobalLayout.Padding = UDim.new(0, 4)

local InputBox = Instance.new("TextBox", ChatFrame)
InputBox.Size = UDim2.new(0.70, 0, 0, 26)
InputBox.Position = UDim2.new(0.02, 0, 0.85, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
InputBox.PlaceholderText = "اكتب رسالتك..."
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 11
InputBox.ClearTextOnFocus = false
InputBox.ZIndex = 91
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)

local SendBtn = Instance.new("TextButton", ChatFrame)
SendBtn.Size = UDim2.new(0.24, 0, 0, 26)
SendBtn.Position = UDim2.new(0.74, 0, 0.85, 0)
SendBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
SendBtn.Text = "إرسال"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.Font = Enum.Font.SourceSansBold
SendBtn.TextSize = 11
SendBtn.ZIndex = 91
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 5)

local function AddChatMessage(username, userId, messageText)
    local MessageFrame = Instance.new("Frame", GlobalChatScroll)
    MessageFrame.Size = UDim2.new(0.98, 0, 0, 32)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MessageFrame.BackgroundTransparency = 0.3
    MessageFrame.ZIndex = 92
    Instance.new("UICorner", MessageFrame).CornerRadius = UDim.new(0, 4)

    local AvatarImage = Instance.new("ImageLabel", MessageFrame)
    AvatarImage.Size = UDim2.new(0, 24, 0, 24)
    AvatarImage.Position = UDim2.new(0.02, 0, 0.12, 0)
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
    AvatarImage.ZIndex = 93
    Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

    local UserLabel = Instance.new("TextLabel", MessageFrame)
    UserLabel.Size = UDim2.new(0.85, 0, 0, 12)
    UserLabel.Position = UDim2.new(0.14, 0, 0, 2)
    UserLabel.Text = "@" .. tostring(username)
    UserLabel.TextColor3 = Color3.fromRGB(255, 70, 80)
    UserLabel.Font = Enum.Font.SourceSansBold
    UserLabel.TextSize = 10
    UserLabel.TextXAlignment = Enum.TextXAlignment.Left
    UserLabel.BackgroundTransparency = 1
    UserLabel.ZIndex = 93

    local TextLabel = Instance.new("TextLabel", MessageFrame)
    TextLabel.Size = UDim2.new(0.85, 0, 0, 14)
    TextLabel.Position = UDim2.new(0.14, 0, 0, 14)
    TextLabel.Text = tostring(messageText)
    TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextSize = 10
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true
    TextLabel.BackgroundTransparency = 1
    TextLabel.ZIndex = 93
end

local function SendToFirebase(text)
    if not request then return end
    pcall(function()
        request({
            Url = CHAT_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                username = LocalPlayer.Name,
                userId = LocalPlayer.UserId,
                message = text,
                timestamp = os.time()
            })
        })
    end)
end

local processedKeys = {}
local function FetchMessages()
    local success, responseBody = pcall(function() return game:HttpGet(CHAT_URL) end)
    if success and responseBody and responseBody ~= "null" and responseBody ~= "" then
        local decodeSuccess, data = pcall(function() return HttpService:JSONDecode(responseBody) end)
        if decodeSuccess and type(data) == "table" then
            local sortedKeys = {}
            for key, _ in pairs(data) do table.insert(sortedKeys, key) end
            table.sort(sortedKeys)
            for _, key in ipairs(sortedKeys) do
                if not processedKeys[key] then
                    processedKeys[key] = true
                    local msgData = data[key]
                    if type(msgData) == "table" and msgData.username and msgData.userId and msgData.message then
                        AddChatMessage(msgData.username, msgData.userId, msgData.message)
                    end
                end
            end
        end
    end
end

local function OnSubmit()
    local text = InputBox.Text
    if text == "" or text:match("^%s*$") then return end
    local isClean, reason = isCleanText(text)
    if not isClean then
        InputBox.Text = ""
        InputBox.PlaceholderText = reason
        task.wait(1.5)
        InputBox.PlaceholderText = "اكتب رسالتك..."
        return
    end
    SendToFirebase(text)
    InputBox.Text = ""
    task.wait(0.3)
    FetchMessages()
end

SendBtn.MouseButton1Click:Connect(OnSubmit)
InputBox.FocusLost:Connect(function(enterPressed) if enterPressed then OnSubmit() end end)

task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        FetchMessages()
        task.wait(2)
    end
end)

-- ==================== 9. قسم الشروحات والروابط ====================
local TutScroll = Instance.new("ScrollingFrame", TutorialsPage)
TutScroll.Size = UDim2.new(1, 0, 1, 0)
TutScroll.BackgroundTransparency = 1
TutScroll.ScrollBarThickness = 3
TutScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TutScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TutScroll.ZIndex = 11

local TutLayout = Instance.new("UIListLayout", TutScroll)
TutLayout.Padding = UDim.new(0, 6)

local function addSocialCard(title, url, iconAsset)
    local Card = Instance.new("Frame", TutScroll)
    Card.Size = UDim2.new(0.98, 0, 0, 44)
    Card.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
    Card.ZIndex = 12
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)

    local IconImg = Instance.new("ImageLabel", Card)
    IconImg.Size = UDim2.new(0, 32, 0, 32)
    IconImg.Position = UDim2.new(0.02, 0, 0.14, 0)
    IconImg.Image = iconAsset
    IconImg.BackgroundTransparency = 1
    IconImg.ZIndex = 13
    Instance.new("UICorner", IconImg).CornerRadius = UDim.new(0, 6)

    local TxtLbl = Instance.new("TextLabel", Card)
    TxtLbl.Size = UDim2.new(0.55, 0, 1, 0)
    TxtLbl.Position = UDim2.new(0.14, 0, 0, 0)
    TxtLbl.Text = title
    TxtLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    TxtLbl.Font = Enum.Font.SourceSansBold
    TxtLbl.TextSize = 12
    TxtLbl.TextXAlignment = Enum.TextXAlignment.Left
    TxtLbl.BackgroundTransparency = 1
    TxtLbl.ZIndex = 13

    local ActionBtn = Instance.new("TextButton", Card)
    ActionBtn.Size = UDim2.new(0.28, 0, 0, 26)
    ActionBtn.Position = UDim2.new(0.69, 0, 0.18, 0)
    ActionBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    ActionBtn.Text = "🚀 دخول"
    ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActionBtn.Font = Enum.Font.SourceSansBold
    ActionBtn.TextSize = 11
    ActionBtn.ZIndex = 13
    Instance.new("UICorner", ActionBtn).CornerRadius = UDim.new(0, 5)

    ActionBtn.MouseButton1Click:Connect(function()
        pcall(function() GuiService:OpenBrowserWindow(url) end)
        if setclipboard then setclipboard(url) end
        ActionBtn.Text = "✔ جاري الفتح..."
        task.wait(1.5)
        ActionBtn.Text = "🚀 دخول"
    end)
end

addSocialCard("حساب التيك توك", "https://www.tiktok.com/@bir.y5?_r=1&_t=ZS-99wgX3YU9Bt", TIKTOK_IMG)
addSocialCard("قناة اليوتيوب", "https://youtube.com/@gqj2?si=h5HOuZFmy2oCpKl2", YOUTUBE_IMG)
addSocialCard("قناة التليجرام", "https://t.me/Ben_5k", TELEGRAM_IMG)
addSocialCard("سيرفر الديسكورد", "https://discord.gg/exB4EsCCA", DISCORD_IMG)

local FooterCard = Instance.new("Frame", TutScroll)
FooterCard.Size = UDim2.new(0.98, 0, 0, 36)
FooterCard.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
FooterCard.ZIndex = 12
Instance.new("UICorner", FooterCard).CornerRadius = UDim.new(0, 6)

local FooterText = Instance.new("TextLabel", FooterCard)
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.Text = "سكربت عربي من صنع Ben ذي حساباتنا رسميه مواقعنا"
FooterText.TextColor3 = Color3.fromRGB(255, 215, 0)
FooterText.Font = Enum.Font.SourceSansBold
FooterText.TextSize = 11
FooterText.BackgroundTransparency = 1
FooterText.ZIndex = 13

-- ==================== 10. باقي الأقسام والمفاتيح والسكربتات ====================
local KeysScroll = Instance.new("ScrollingFrame", KeysPage)
KeysScroll.Size = UDim2.new(1, 0, 1, 0)
KeysScroll.BackgroundTransparency = 1
KeysScroll.ScrollBarThickness = 3
KeysScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
KeysScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
KeysScroll.ZIndex = 11
Instance.new("UIListLayout", KeysScroll).Padding = UDim.new(0, 8)

local function createKeyCard(parent, mapTitle, keyTitle, keyText, descText)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(0.98, 0, 0, keyText ~= "" and 96 or 55)
    Card.BackgroundColor3 = Color3.fromRGB(25, 12, 15)
    Card.ZIndex = 12
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local MapLbl = Instance.new("TextLabel", Card)
    MapLbl.Size = UDim2.new(0.95, 0, 0, 18)
    MapLbl.Position = UDim2.new(0.03, 0, 0, 4)
    MapLbl.Text = "📌 " .. mapTitle
    MapLbl.TextColor3 = Color3.fromRGB(255, 70, 80)
    MapLbl.Font = Enum.Font.SourceSansBold
    MapLbl.TextSize = 12
    MapLbl.TextXAlignment = Enum.TextXAlignment.Left
    MapLbl.BackgroundTransparency = 1
    MapLbl.ZIndex = 13

    local KeyNameLbl = Instance.new("TextLabel", Card)
    KeyNameLbl.Size = UDim2.new(0.95, 0, 0, 16)
    KeyNameLbl.Position = UDim2.new(0.03, 0, 0, 22)
    KeyNameLbl.Text = keyTitle
    KeyNameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyNameLbl.Font = Enum.Font.SourceSansBold
    KeyNameLbl.TextSize = 11
    KeyNameLbl.TextXAlignment = Enum.TextXAlignment.Left
    KeyNameLbl.BackgroundTransparency = 1
    KeyNameLbl.ZIndex = 13

    if keyText ~= "" then
        local KeyDisplay = Instance.new("TextLabel", Card)
        KeyDisplay.Size = UDim2.new(0.64, 0, 0, 24)
        KeyDisplay.Position = UDim2.new(0.03, 0, 0, 42)
        KeyDisplay.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
        KeyDisplay.Text = keyText
        KeyDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
        KeyDisplay.Font = Enum.Font.Code
        KeyDisplay.TextSize = 10
        KeyDisplay.ZIndex = 13
        Instance.new("UICorner", KeyDisplay).CornerRadius = UDim.new(0, 4)

        local CopyBtn = Instance.new("TextButton", Card)
        CopyBtn.Size = UDim2.new(0.28, 0, 0, 24)
        CopyBtn.Position = UDim2.new(0.69, 0, 0, 42)
        CopyBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
        CopyBtn.Text = "📋 نسخ"
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyBtn.Font = Enum.Font.SourceSansBold
        CopyBtn.TextSize = 10
        CopyBtn.ZIndex = 13
        Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 4)

        CopyBtn.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(keyText) end
            CopyBtn.Text = "✔ تم النسخ!"
            task.wait(1.5)
            CopyBtn.Text = "📋 نسخ"
        end)
    end

    local DescLbl = Instance.new("TextLabel", Card)
    DescLbl.Size = UDim2.new(0.95, 0, 0, 18)
    DescLbl.Position = UDim2.new(0.03, 0, 0, keyText ~= "" and 72 or 36)
    DescLbl.Text = "ℹ️ " .. descText
    DescLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLbl.Font = Enum.Font.SourceSans
    DescLbl.TextSize = 10
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.BackgroundTransparency = 1
    DescLbl.ZIndex = 13
end

createKeyCard(KeysScroll, "ماب سرقة البيض", "مفتاح سكربت A الاحمر", "jOjjJVBSnckKQnMOotmsUdGxINjetHRH", "يتجدد كل 15 ساعة تلقائياً")
createKeyCard(KeysScroll, "ماب ركوب الحيوانات", "بدون مفتاح", "", "لا يحتاج إلى مفتاح حالياً")

local function createScriptCard(parentPage, cardTitle, cardDesc, executeCallback, keyTabTargetIndex)
    local Card = Instance.new("Frame", parentPage)
    Card.Size = UDim2.new(0.98, 0, 0, 75)
    Card.BackgroundColor3 = Color3.fromRGB(25, 12, 15)
    Card.ZIndex = 12
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local TitleLbl = Instance.new("TextLabel", Card)
    TitleLbl.Size = UDim2.new(0.60, 0, 0, 20)
    TitleLbl.Position = UDim2.new(0.03, 0, 0, 5)
    TitleLbl.Text = "⚪ " .. cardTitle
    TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLbl.Font = Enum.Font.SourceSansBold
    TitleLbl.TextSize = 13
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.ZIndex = 13

    local DescLbl = Instance.new("TextLabel", Card)
    DescLbl.Size = UDim2.new(0.60, 0, 0, 22)
    DescLbl.Position = UDim2.new(0.03, 0, 0, 25)
    DescLbl.Text = cardDesc
    DescLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLbl.Font = Enum.Font.SourceSans
    DescLbl.TextSize = 10
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.TextWrapped = true
    DescLbl.BackgroundTransparency = 1
    DescLbl.ZIndex = 13

    local RunCardBtn = Instance.new("TextButton", Card)
    RunCardBtn.Size = UDim2.new(0.32, 0, 0, 26)
    RunCardBtn.Position = UDim2.new(0.65, 0, 0, 8)
    RunCardBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    RunCardBtn.Text = "◀ تشغيل"
    RunCardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RunCardBtn.Font = Enum.Font.SourceSansBold
    RunCardBtn.TextSize = 11
    RunCardBtn.ZIndex = 13
    Instance.new("UICorner", RunCardBtn).CornerRadius = UDim.new(0, 6)

    RunCardBtn.MouseButton1Click:Connect(function()
        RunCardBtn.Text = "⏳ جاري..."
        executeCallback()
        task.wait(1)
        RunCardBtn.Text = "تم التشغيل"
        task.wait(1.5)
        RunCardBtn.Text = "◀ تشغيل"
    end)

    if keyTabTargetIndex then
        local KeyRedirectBtn = Instance.new("TextButton", Card)
        KeyRedirectBtn.Size = UDim2.new(0.32, 0, 0, 24)
        KeyRedirectBtn.Position = UDim2.new(0.65, 0, 0, 42)
        KeyRedirectBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 30)
        KeyRedirectBtn.Text = "🔑 المفتاح"
        KeyRedirectBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
        KeyRedirectBtn.Font = Enum.Font.SourceSansBold
        KeyRedirectBtn.TextSize = 10
        KeyRedirectBtn.ZIndex = 13
        Instance.new("UICorner", KeyRedirectBtn).CornerRadius = UDim.new(0, 5)

        KeyRedirectBtn.MouseButton1Click:Connect(function() switchToTab(keyTabTargetIndex) end)
    end
end

-- سرقة البيض
local StealEggScroll = Instance.new("ScrollingFrame", StealEggPage)
StealEggScroll.Size = UDim2.new(1, 0, 1, 0)
StealEggScroll.BackgroundTransparency = 1
StealEggScroll.ScrollBarThickness = 3
StealEggScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
StealEggScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
StealEggScroll.ZIndex = 11
Instance.new("UIListLayout", StealEggScroll).Padding = UDim.new(0, 6)

createScriptCard(StealEggScroll, "سكربت A الاحمر", "تجميع أحداث وتفريخ البيض تلقائياً", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/virtuososvisualedits-prog/Ww/refs/heads/main/final-obfuscated.lua"))() end)
end, KeysIndex)

createScriptCard(StealEggScroll, "سكربت فلفل", "سكربت ممتاز لحدث البيض", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))() end)
end)

-- ركوب الحيوانات
local RidePetScroll = Instance.new("ScrollingFrame", RidePetPage)
RidePetScroll.Size = UDim2.new(1, 0, 1, 0)
RidePetScroll.BackgroundTransparency = 1
RidePetScroll.ScrollBarThickness = 3
RidePetScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
RidePetScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
RidePetScroll.ZIndex = 11
Instance.new("UIListLayout", RidePetScroll).Padding = UDim.new(0, 6)

createScriptCard(RidePetScroll, "سكربت كامل المطور", "تجميع + سرعة فائقة وجميع الميزات", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/afkar-gg/sc/refs/heads/main/Linkhive/RideAPet.lua"))() end)
end)

-- مشغل السكربتات
local ExecBox = Instance.new("TextBox", ExecutorPage)
ExecBox.Size = UDim2.new(0.98, 0, 0.7, 0)
ExecBox.Position = UDim2.new(0, 0, 0, 5)
ExecBox.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
ExecBox.PlaceholderText = "-- اكتب كود السكربت هنا..."
ExecBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBox.Font = Enum.Font.Code
ExecBox.TextSize = 11
ExecBox.TextXAlignment = Enum.TextXAlignment.Left
ExecBox.TextYAlignment = Enum.TextYAlignment.Top
ExecBox.ClearTextOnFocus = false
ExecBox.ZIndex = 12
Instance.new("UICorner", ExecBox).CornerRadius = UDim.new(0, 6)

local RunBtn = Instance.new("TextButton", ExecutorPage)
RunBtn.Size = UDim2.new(0.48, 0, 0, 30)
RunBtn.Position = UDim2.new(0, 0, 0.82, 0)
RunBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
RunBtn.Text = "⚡ تشغيل السكربت"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 11
RunBtn.ZIndex = 12
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 5)

RunBtn.MouseButton1Click:Connect(function()
    if ExecBox.Text ~= "" then pcall(function() loadstring(ExecBox.Text)() end) end
end)

local ClearBtn = Instance.new("TextButton", ExecutorPage)
ClearBtn.Size = UDim2.new(0.48, 0, 0, 30)
ClearBtn.Position = UDim2.new(0.5, 0, 0.82, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 25)
ClearBtn.Text = "🗑️ مسح"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.SourceSansBold
ClearBtn.TextSize = 11
ClearBtn.ZIndex = 12
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 5)

ClearBtn.MouseButton1Click:Connect(function() ExecBox.Text = "" end)

-- قسم الاقتراحات
local SugBox = Instance.new("TextBox", SuggestionsPage)
SugBox.Size = UDim2.new(0.98, 0, 0, 140)
SugBox.Position = UDim2.new(0, 0, 0, 10)
SugBox.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
SugBox.PlaceholderText = "اكتب اقتراحك هنا ليتم إرساله للمطور..."
SugBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SugBox.Font = Enum.Font.SourceSans
SugBox.TextSize = 11
SugBox.TextXAlignment = Enum.TextXAlignment.Left
SugBox.TextYAlignment = Enum.TextYAlignment.Top
SugBox.ClearTextOnFocus = false
SugBox.MultiLine = true
SugBox.ZIndex = 12
Instance.new("UICorner", SugBox).CornerRadius = UDim.new(0, 6)

local SendSugBtn = Instance.new("TextButton", SuggestionsPage)
SendSugBtn.Size = UDim2.new(0.98, 0, 0, 30)
SendSugBtn.Position = UDim2.new(0, 0, 0, 160)
SendSugBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
SendSugBtn.Text = "🚀 إرسال الاقتراح"
SendSugBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendSugBtn.Font = Enum.Font.SourceSansBold
SendSugBtn.TextSize = 11
SendSugBtn.ZIndex = 12
Instance.new("UICorner", SendSugBtn).CornerRadius = UDim.new(0, 6)

SendSugBtn.MouseButton1Click:Connect(function()
    local text = SugBox.Text
    if text == "" or text:match("^%s*$") then return end
    local isClean, reason = isCleanText(text)
    if not isClean then
        SugBox.Text = ""
        SugBox.PlaceholderText = reason
        task.wait(1.5)
        SugBox.PlaceholderText = "اكتب اقتراحك هنا..."
        return
    end
    SendSugBtn.Text = "⏳ جاري الإرسال..."
    if request then
        pcall(function()
            request({
                Url = SUGGESTION_WEBHOOK,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({
                    username = "Ben Hub Suggestions",
                    embeds = {{
                        title = "💡 اقتراح جديد",
                        description = text,
                        color = 16711680,
                        fields = {{name = "اللاعب", value = LocalPlayer.Name, inline = true}}
                    }}
                })
            })
        end)
    end
    task.wait(1)
    SugBox.Text = ""
    SendSugBtn.Text = "✔ تم الإرسال بنجاح!"
    task.wait(2)
    SendSugBtn.Text = "🚀 إرسال الاقتراح"
end)

switchToTab(1)

