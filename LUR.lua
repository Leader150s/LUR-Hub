-- ===================================================
-- 👑 LUR HUB - All-In-One Official Edition (Final Fixed)
-- ===================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

-- روابط الفايربيس (الشات والعداد الحي)
local FIREBASE_BASE = "https://benhubchat-24010-default-rtdb.firebaseio.com/"
local CHAT_URL = FIREBASE_BASE .. "chat.json"
local EXEC_URL = FIREBASE_BASE .. "stats/executions.json"
local ONLINE_URL = FIREBASE_BASE .. "stats/online/" .. tostring(LocalPlayer.UserId) .. ".json"
local ALL_ONLINE_URL = FIREBASE_BASE .. "stats/online.json"

-- دالة طلبات HTTP
local request = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request) or (krnl and krnl.request)

-- ==================== 1. الصور والتصميم ====================
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

-- ==================== 2. نظام الفلترة والحماية ====================
local ForbiddenWords = {
    "سب", "كفر", "فشار", "امك", "أمك", "اختك", "أختك", "ابوك", "أبوك",
    "كس", "قحبة", "طيز", "زق", "شرموط", "خرية", "منيك", "قحب"
}
local LinkPatterns = {"https?://%S+", "www%.%S+", "discord%.gg/%S+", "%.com", "%.net", "%.org", "%.gg"}

local function isCleanText(text)
    local lowerText = string.lower(text)
    for _, pattern in ipairs(LinkPatterns) do
        if string.find(lowerText, pattern) then return false, "ممنوع نشر الروابط!" end
    end
    for _, word in ipairs(ForbiddenWords) do
        if string.find(lowerText, string.lower(word)) then return false, "كلمات محظورة ومسئية!" end
    end
    return true, nil
end

-- ==================== 3. الواجهة الرئيسية ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LURHub_OfficialUI"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 290)
MainFrame.Position = UDim2.new(0.5, -230, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
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

-- ==================== 4. دالة السحب والتحريك ====================
local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(MainFrame)

-- ==================== 5. زر الإظهار والإخفاء ====================
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Name = "LURHubToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.08, 0, 0.2, 0)
ToggleBtn.Image = TOGGLE_IMAGE_ID
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Visible = false
ToggleBtn.ZIndex = 10
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(220, 30, 40)
ToggleStroke.Thickness = 2

makeDraggable(ToggleBtn)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==================== 6. الشريط العلوي والعداد الحي ====================
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 10, 12)
TopBar.BackgroundTransparency = 0.2
TopBar.ZIndex = 5
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0.28, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Text = "👑 BEN HUB"
Title.TextColor3 = Color3.fromRGB(255, 40, 50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.ZIndex = 6

local CounterFrame = Instance.new("Frame", TopBar)
CounterFrame.Size = UDim2.new(0.52, 0, 0.7, 0)
CounterFrame.Position = UDim2.new(0.31, 0, 0.15, 0)
CounterFrame.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
CounterFrame.BackgroundTransparency = 0.3
CounterFrame.ZIndex = 6
Instance.new("UICorner", CounterFrame).CornerRadius = UDim.new(0, 6)

local StatsLabel = Instance.new("TextLabel", CounterFrame)
StatsLabel.Size = UDim2.new(1, 0, 1, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(255, 220, 220)
StatsLabel.Font = Enum.Font.SourceSansBold
StatsLabel.TextSize = 11
StatsLabel.Text = "👥 التجارب: ... | 🟢 أونلاين: 1"
StatsLabel.ZIndex = 7

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(0.91, 0, 0.16, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 6
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false ToggleBtn.Visible = true end)

-- نظام العداد الحقيقي لـ Firebase
local totalExecutions = 1843
local onlineCount = 1

local function incrementAndFetchExecutions()
    if not request then return end
    pcall(function()
        local res = request({Url = EXEC_URL, Method = "GET"})
        if res and res.StatusCode == 200 and res.Body and res.Body ~= "null" then
            local num = tonumber(res.Body)
            if num then totalExecutions = num end
        end
    end)
    totalExecutions = totalExecutions + 1
    pcall(function()
        request({
            Url = EXEC_URL,
            Method = "PUT",
            Headers = {["Content-Type"] = "application/json"},
            Body = tostring(totalExecutions)
        })
    end)
end

local function updateOnlineStats()
    if not request then return end
    pcall(function()
        request({
            Url = ONLINE_URL,
            Method = "PUT",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({lastSeen = os.time()})
        })
    end)

    pcall(function()
        local res = request({Url = ALL_ONLINE_URL, Method = "GET"})
        if res and res.StatusCode == 200 and res.Body and res.Body ~= "null" then
            local data = HttpService:JSONDecode(res.Body)
            if type(data) == "table" then
                local activeUsers = 0
                local now = os.time()
                for uid, userStat in pairs(data) do
                    if userStat and userStat.lastSeen and (now - userStat.lastSeen < 30) then
                        activeUsers = activeUsers + 1
                    end
                end
                onlineCount = math.max(1, activeUsers)
            end
        end
    end)

    StatsLabel.Text = "👥 التجارب: " .. tostring(totalExecutions) .. " | 🟢 أونلاين: " .. tostring(onlineCount)
end

task.spawn(function()
    incrementAndFetchExecutions()
    while ScreenGui and ScreenGui.Parent do
        updateOnlineStats()
        task.wait(8)
    end
end)

-- ==================== 7. القائمة والصفحات (بالترتيب المطلوب) ====================
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 115, 1, -48)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 8, 10)
Sidebar.BackgroundTransparency = 0.3
Sidebar.ZIndex = 3
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -130, 1, -48)
Container.Position = UDim2.new(0, 125, 0, 45)
Container.BackgroundTransparency = 1
Container.ZIndex = 3

local Tabs, Pages = {}, {}

local function createTab(name, icon)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, #Tabs * 34 + 5)
    btn.BackgroundColor3 = (#Tabs == 0) and Color3.fromRGB(190, 25, 35) or Color3.fromRGB(30, 15, 20)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.ZIndex = 4
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("Frame", Container)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (#Tabs == 0)
    page.ZIndex = 3

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Tabs) do b.BackgroundColor3 = Color3.fromRGB(30, 15, 20) end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end)

    table.insert(Tabs, btn)
    table.insert(Pages, page)
    return page
end

-- إنشاء الصفحات حسب الترتيب المباشر المطلوب
local ChatPage      = createTab("الشات العام", "💬")
local TutorialsPage = createTab("شروحات", "🎥")
local ExecutorPage  = createTab("مشغل السكربتات", "📜")
local StealEggPage  = createTab("سرقة البيض", "🥚")
local RidePetPage   = createTab("ركوب الحيوانات", "🐾")

-- ==================== 8. دالة إنتاج تصميم البطاقات (نفس الصورة) ====================
local function createScriptCard(parentPage, cardTitle, cardDesc, executeCallback)
    local Card = Instance.new("Frame", parentPage)
    Card.Size = UDim2.new(0.98, 0, 0, 62)
    Card.Position = UDim2.new(0, 0, 0, 10)
    Card.BackgroundColor3 = Color3.fromRGB(25, 12, 15)
    Card.BackgroundTransparency = 0.2
    Card.ZIndex = 4
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color = Color3.fromRGB(180, 30, 40)
    CardStroke.Thickness = 1
    CardStroke.Transparency = 0.5

    local TitleLbl = Instance.new("TextLabel", Card)
    TitleLbl.Size = UDim2.new(0.68, 0, 0, 22)
    TitleLbl.Position = UDim2.new(0.03, 0, 0, 8)
    TitleLbl.Text = "⚪ " .. cardTitle
    TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLbl.Font = Enum.Font.SourceSansBold
    TitleLbl.TextSize = 13
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.ZIndex = 5

    local DescLbl = Instance.new("TextLabel", Card)
    DescLbl.Size = UDim2.new(0.68, 0, 0, 20)
    DescLbl.Position = UDim2.new(0.03, 0, 0, 30)
    DescLbl.Text = cardDesc
    DescLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLbl.Font = Enum.Font.SourceSans
    DescLbl.TextSize = 10
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.BackgroundTransparency = 1
    DescLbl.ZIndex = 5

    local RunCardBtn = Instance.new("TextButton", Card)
    RunCardBtn.Size = UDim2.new(0.24, 0, 0, 34)
    RunCardBtn.Position = UDim2.new(0.73, 0, 0, 14)
    RunCardBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    RunCardBtn.Text = "▶ تشغيل"
    RunCardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RunCardBtn.Font = Enum.Font.SourceSansBold
    RunCardBtn.TextSize = 12
    RunCardBtn.ZIndex = 5
    Instance.new("UICorner", RunCardBtn).CornerRadius = UDim.new(0, 6)

    RunCardBtn.MouseButton1Click:Connect(function()
        RunCardBtn.Text = "⏳ جاري..."
        executeCallback()
        task.wait(1)
        RunCardBtn.Text = "✅ تم التشغيل"
        task.wait(1.5)
        RunCardBtn.Text = "▶ تشغيل"
    end)
end

-- تطبيق بطاقة قسم سرقة البيض
createScriptCard(
    StealEggPage,
    "سكربت سرقة البيض الأسطوري",
    "طيران سريع + قراءة 100B / 1T والتنقل تلقائياً",
    function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/afkar-gg/sc/refs/heads/main/Linkhive/RideAPet.lua"))()
        end)
    end
)

-- تطبيق بطاقة قسم ركوب الحيوانات
createScriptCard(
    RidePetPage,
    "سكربت ركوب الحيوانات المطور",
    "تجميع تلقائي + ركوب جميع الحيوانات وسرعة فائقة",
    function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/afkar-gg/sc/refs/heads/main/Linkhive/RideAPet.lua"))()
        end)
    end
)

-- ==================== 9. قسم مشغل السكربتات ====================
local ExecBox = Instance.new("TextBox", ExecutorPage)
ExecBox.Size = UDim2.new(0.98, 0, 0.7, 0)
ExecBox.Position = UDim2.new(0, 0, 0, 5)
ExecBox.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
ExecBox.BackgroundTransparency = 0.2
ExecBox.Text = ""
ExecBox.PlaceholderText = "-- اكتب السكربت الخاص بك هنا..."
ExecBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
ExecBox.Font = Enum.Font.Code
ExecBox.TextSize = 11
ExecBox.TextXAlignment = Enum.TextXAlignment.Left
ExecBox.TextYAlignment = Enum.TextYAlignment.Top
ExecBox.ClearTextOnFocus = false
ExecBox.ZIndex = 4
Instance.new("UICorner", ExecBox).CornerRadius = UDim.new(0, 6)

local RunBtn = Instance.new("TextButton", ExecutorPage)
RunBtn.Size = UDim2.new(0.48, 0, 0, 30)
RunBtn.Position = UDim2.new(0, 0, 0.82, 0)
RunBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
RunBtn.Text = "⚡ تشغيل السكربت"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 11
RunBtn.ZIndex = 4
Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 5)

RunBtn.MouseButton1Click:Connect(function()
    if ExecBox.Text ~= "" then
        pcall(function()
            loadstring(ExecBox.Text)()
        end)
    end
end)

local ClearBtn = Instance.new("TextButton", ExecutorPage)
ClearBtn.Size = UDim2.new(0.48, 0, 0, 30)
ClearBtn.Position = UDim2.new(0.5, 0, 0.82, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 25)
ClearBtn.Text = "🗑️ مسح الكود"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.SourceSansBold
ClearBtn.TextSize = 11
ClearBtn.ZIndex = 4
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 5)

ClearBtn.MouseButton1Click:Connect(function() ExecBox.Text = "" end)

-- ==================== 10. قسم الشروحات والروابط المباشرة ====================
local function addLinkButton(title, url, icon, posy)
    local linkBtn = Instance.new("TextButton", TutorialsPage)
    linkBtn.Size = UDim2.new(0.98, 0, 0, 35)
    linkBtn.Position = UDim2.new(0, 0, 0, posy)
    linkBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
    linkBtn.Text = icon .. " " .. title
    linkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    linkBtn.Font = Enum.Font.SourceSansBold
    linkBtn.TextSize = 12
    linkBtn.ZIndex = 4
    Instance.new("UICorner", linkBtn).CornerRadius = UDim.new(0, 6)

    linkBtn.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(url) end
        pcall(function()
            GuiService:OpenBrowserWindow(url)
        end)
        linkBtn.Text = "✅ جاري فتح الرابط..."
        task.wait(1.5)
        linkBtn.Text = icon .. " " .. title
    end)
end

addLinkButton("قناة اليوتيوب للشروحات", "https://youtube.com", "🎥", 5)
addLinkButton("سيرفر الديسكورد الرسمي", "https://discord.gg", "💬", 46)
addLinkButton("رابط موقع السكربتات", "https://google.com", "🌐", 87)

-- ==================== 11. قسم الشات العام المتصل بـ Firebase ====================
local GlobalChatScroll = Instance.new("ScrollingFrame", ChatPage)
GlobalChatScroll.Size = UDim2.new(1, 0, 0.8, 0)
GlobalChatScroll.Position = UDim2.new(0, 0, 0, 0)
GlobalChatScroll.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
GlobalChatScroll.BackgroundTransparency = 0.2
GlobalChatScroll.ScrollBarThickness = 3
GlobalChatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
GlobalChatScroll.ZIndex = 4
Instance.new("UICorner", GlobalChatScroll).CornerRadius = UDim.new(0, 6)

local GlobalLayout = Instance.new("UIListLayout", GlobalChatScroll)
GlobalLayout.Padding = UDim.new(0, 4)

GlobalLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    GlobalChatScroll.CanvasSize = UDim2.new(0, 0, 0, GlobalLayout.AbsoluteContentSize.Y + 8)
    GlobalChatScroll.CanvasPosition = Vector2.new(0, GlobalLayout.AbsoluteContentSize.Y)
end)

local InputBox = Instance.new("TextBox", ChatPage)
InputBox.Size = UDim2.new(0.72, 0, 0, 30)
InputBox.Position = UDim2.new(0, 0, 0.85, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
InputBox.PlaceholderText = "اكتب رسالتك هنا..."
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.Font = Enum.Font.SourceSans
InputBox.TextSize = 11
InputBox.ClearTextOnFocus = false
InputBox.ZIndex = 4
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)

local SendBtn = Instance.new("TextButton", ChatPage)
SendBtn.Size = UDim2.new(0.25, 0, 0, 30)
SendBtn.Position = UDim2.new(0.74, 0, 0.85, 0)
SendBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
SendBtn.Text = "إرسال 🚀"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.Font = Enum.Font.SourceSansBold
SendBtn.TextSize = 11
SendBtn.ZIndex = 4
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 5)

local function AddChatMessage(username, userId, messageText)
    local MessageFrame = Instance.new("Frame", GlobalChatScroll)
    MessageFrame.Size = UDim2.new(0.98, 0, 0, 36)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
    MessageFrame.BackgroundTransparency = 0.2
    MessageFrame.ZIndex = 5
    Instance.new("UICorner", MessageFrame).CornerRadius = UDim.new(0, 5)

    local AvatarImage = Instance.new("ImageLabel", MessageFrame)
    AvatarImage.Size = UDim2.new(0, 28, 0, 28)
    AvatarImage.Position = UDim2.new(0.02, 0, 0.1, 0)
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"
    AvatarImage.ZIndex = 6
    Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

    local UserLabel = Instance.new("TextLabel", MessageFrame)
    UserLabel.Size = UDim2.new(0.85, 0, 0, 14)
    UserLabel.Position = UDim2.new(0.13, 0, 0, 2)
    UserLabel.Text = "@" .. tostring(username)
    UserLabel.TextColor3 = Color3.fromRGB(255, 60, 70)
    UserLabel.Font = Enum.Font.SourceSansBold
    UserLabel.TextSize = 11
    UserLabel.TextXAlignment = Enum.TextXAlignment.Left
    UserLabel.BackgroundTransparency = 1
    UserLabel.ZIndex = 6

    local TextLabel = Instance.new("TextLabel", MessageFrame)
    TextLabel.Size = UDim2.new(0.85, 0, 0, 16)
    TextLabel.Position = UDim2.new(0.13, 0, 0, 16)
    TextLabel.Text = tostring(messageText)
    TextLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextSize = 11
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true
    TextLabel.BackgroundTransparency = 1
    TextLabel.ZIndex = 6
end

local function SendToFirebase(text)
    if not request then return end
    local payload = HttpService:JSONEncode({
        username = LocalPlayer.Name,
        userId = LocalPlayer.UserId,
        message = text,
        timestamp = os.time()
    })

    pcall(function()
        request({
            Url = CHAT_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })
    end)
end

local processedKeys = {}
local function FetchMessages()
    if not request then return end

    local success, response = pcall(function()
        return request({
            Url = CHAT_URL,
            Method = "GET"
        })
    end)

    if success and response and response.StatusCode == 200 and response.Body and response.Body ~= "null" then
        local successDecode, data = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)

        if successDecode and type(data) == "table" then
            local sortedKeys = {}
            for key, _ in pairs(data) do table.insert(sortedKeys, key) end
            table.sort(sortedKeys)

            for _, key in ipairs(sortedKeys) do
                if not processedKeys[key] then
                    processedKeys[key] = true
                    local msgData = data[key]
                    if msgData and msgData.username and msgData.userId and msgData.message then
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
        InputBox.PlaceholderText = "اكتب رسالتك هنا..."
        return
    end

    SendToFirebase(text)
    InputBox.Text = ""
    task.wait(0.2)
    FetchMessages()
end

SendBtn.MouseButton1Click:Connect(OnSubmit)
InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then OnSubmit() end
end)

-- تحديث الشات تلقائياً كل ثانية
task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        FetchMessages()
        task.wait(1)
    end
end)
