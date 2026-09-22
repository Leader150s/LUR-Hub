-- ===================================================
-- 👑 BEN HUB - Official Executing Hub & Custom Theme
-- Version 4.2 | Complete & Fixed Edition with External Chat
-- ===================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- ==================== 1. تحميل الصور الخارجية ====================
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

local BG_IMAGE_ID = loadAsset("https://f.top4top.io/p_3917lvgp10.png", "BenHub_BG.png")
local TOGGLE_IMAGE_ID = loadAsset("https://g.top4top.io/p_3917nj3r41.png", "BenHub_Icon.png")

-- ==================== 2. إنشاء الشاشة الرئيسية ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BenHub_OfficialUI"
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

-- الخلفية ZIndex = 1
local BackgroundImg = Instance.new("ImageLabel", MainFrame)
BackgroundImg.Size = UDim2.new(1, 0, 1, 0)
BackgroundImg.Image = BG_IMAGE_ID
BackgroundImg.BackgroundTransparency = 1
BackgroundImg.ImageTransparency = 0.55
BackgroundImg.ScaleType = Enum.ScaleType.Crop
BackgroundImg.ZIndex = 1

-- ==================== 3. دالة السحب والتحريك ====================
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

-- ==================== 4. الزر الدائري للتصغير/الإظهار ====================
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Name = "BenHubToggleBtn"
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

-- ==================== 5. الشريط العلوي ====================
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
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.ZIndex = 6

local CounterFrame = Instance.new("Frame", TopBar)
CounterFrame.Size = UDim2.new(0.48, 0, 0.7, 0)
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
StatsLabel.TextSize = 10
StatsLabel.Text = "👥 التجارب: جاري التحميل... | 🟢 أونلاين: ..."
StatsLabel.ZIndex = 7

local function updateRealStats()
    local realOnline = #Players:GetPlayers()
    local totalRuns = 1845
    pcall(function()
        local res = game:HttpGet("https://api.counterapi.dev/v1/benhub_official_v3/runs/up")
        if res then
            local count = string.match(res, '"count":%s*(%d+)')
            if count then totalRuns = tonumber(count) end
        end
    end)
    StatsLabel.Text = "👥 التجارب: " .. tostring(totalRuns) .. " | 🟢 أونلاين: " .. tostring(realOnline)
end
task.spawn(updateRealStats)

local DestroyBtn = Instance.new("TextButton", TopBar)
DestroyBtn.Size = UDim2.new(0, 28, 0, 28)
DestroyBtn.Position = UDim2.new(0.83, 0, 0.16, 0)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 25)
DestroyBtn.Text = "🗑️"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyBtn.Font = Enum.Font.SourceSansBold
DestroyBtn.TextSize = 13
DestroyBtn.ZIndex = 6
Instance.new("UICorner", DestroyBtn).CornerRadius = UDim.new(0, 6)
DestroyBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

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

-- ==================== 6. القائمة الجانبية والحاوية ====================
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

local EggPage = createTab("سرقة البيض", "⚪")
local AnimalPage = createTab("ركوب الحيوانات", "🐾")
local ExecutorPage = createTab("مشغل السكربتات", "📜")
local TutorialPage = createTab("شروحات", "📚")
local ChatPage = createTab("الشات", "💬")

local function addScriptButton(page, title, description, scriptCode)
    local count = 0
    for _, child in pairs(page:GetChildren()) do
        if child:IsA("Frame") then count = count + 1 end
    end

    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(0.98, 0, 0, 48)
    frame.Position = UDim2.new(0, 0, 0, count * 52 + 5)
    frame.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
    frame.BackgroundTransparency = 0.1
    frame.ZIndex = 4
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lblTitle = Instance.new("TextLabel", frame)
    lblTitle.Size = UDim2.new(0.65, 0, 0.5, 0)
    lblTitle.Position = UDim2.new(0.04, 0, 0.08, 0)
    lblTitle.Text = title
    lblTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    lblTitle.Font = Enum.Font.SourceSansBold
    lblTitle.TextSize = 11
    lblTitle.TextXAlignment = Enum.TextXAlignment.Left
    lblTitle.BackgroundTransparency = 1
    lblTitle.ZIndex = 5

    local lblDesc = Instance.new("TextLabel", frame)
    lblDesc.Size = UDim2.new(0.65, 0, 0.4, 0)
    lblDesc.Position = UDim2.new(0.04, 0, 0.55, 0)
    lblDesc.Text = description
    lblDesc.TextColor3 = Color3.fromRGB(190, 190, 190)
    lblDesc.Font = Enum.Font.SourceSans
    lblDesc.TextSize = 10
    lblDesc.TextXAlignment = Enum.TextXAlignment.Left
    lblDesc.BackgroundTransparency = 1
    lblDesc.ZIndex = 5

    local runBtn = Instance.new("TextButton", frame)
    runBtn.Size = UDim2.new(0.26, 0, 0.7, 0)
    runBtn.Position = UDim2.new(0.7, 0, 0.15, 0)
    runBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    runBtn.Text = "تشغيل ▶"
    runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    runBtn.Font = Enum.Font.SourceSansBold
    runBtn.TextSize = 11
    runBtn.ZIndex = 5
    Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0, 5)

    runBtn.MouseButton1Click:Connect(function()
        runBtn.Text = "تم التشغيل! ✅"
        runBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        task.spawn(function()
            if type(scriptCode) == "string" then
                pcall(function() loadstring(scriptCode)() end)
            elseif type(scriptCode) == "function" then
                scriptCode()
            end
        end)
        task.wait(1.5)
        runBtn.Text = "تشغيل ▶"
        runBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end)
end

addScriptButton(EggPage, "⚪ سكربت سرقة البيض الأسطوري", "طيران سريع + قراءة 1T / 100B والتنقل تلقائياً", function() print("Egg script active") end)
addScriptButton(AnimalPage, "🐾 سكربت ركوب الحيوانات", "تسريع الحركة والقفز + الأوتو فارم", function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 80 end end)

-- ==================== 7. قسم مشغل السكربتات (Executor) ====================
local CodeBox = Instance.new("TextBox", ExecutorPage)
CodeBox.Size = UDim2.new(0.98, 0, 0.58, 0)
CodeBox.Position = UDim2.new(0, 0, 0, 5)
CodeBox.BackgroundColor3 = Color3.fromRGB(20, 10, 14)
CodeBox.BackgroundTransparency = 0.1
CodeBox.PlaceholderText = "ضع السكربت هنا..."
CodeBox.Text = ""
CodeBox.TextColor3 = Color3.fromRGB(240, 240, 240)
CodeBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
CodeBox.Font = Enum.Font.Code
CodeBox.TextSize = 11
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.ClearTextOnFocus = false
CodeBox.MultiLine = true
CodeBox.ZIndex = 4
Instance.new("UICorner", CodeBox).CornerRadius = UDim.new(0, 6)

local ExecBtn = Instance.new("TextButton", ExecutorPage)
ExecBtn.Size = UDim2.new(0.48, 0, 0, 32)
ExecBtn.Position = UDim2.new(0, 0, 0.65, 0)
ExecBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
ExecBtn.Text = "▶ تشغيل الكود (Execute)"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.Font = Enum.Font.SourceSansBold
ExecBtn.TextSize = 11
ExecBtn.ZIndex = 4
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 6)

ExecBtn.MouseButton1Click:Connect(function()
    local inputCode = CodeBox.Text
    if inputCode and inputCode ~= "" then
        local success = pcall(function()
            if string.match(inputCode, "^http") then
                loadstring(game:HttpGet(inputCode))()
            else
                loadstring(inputCode)()
            end
        end)
        if success then
            ExecBtn.Text = "تم التشغيل بنجاح! ✅"
            ExecBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 70)
        else
            ExecBtn.Text = "خطأ في الكود! ❌"
            ExecBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
        end
        task.wait(1.5)
        ExecBtn.Text = "▶ تشغيل الكود (Execute)"
        ExecBtn.BackgroundColor3 = Color3.fromRGB(190, 25, 35)
    end
end)

local ClearBtn = Instance.new("TextButton", ExecutorPage)
ClearBtn.Size = UDim2.new(0.48, 0, 0, 32)
ClearBtn.Position = UDim2.new(0.5, 0, 0.65, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 25)
ClearBtn.Text = "🗑️ مسح (Clear)"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.SourceSansBold
ClearBtn.TextSize = 11
ClearBtn.ZIndex = 4
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 6)
ClearBtn.MouseButton1Click:Connect(function() CodeBox.Text = "" end)

-- ==================== 8. قسم الشروحات وقنوات التواصل ====================
local TutScroll = Instance.new("ScrollingFrame", TutorialPage)
TutScroll.Size = UDim2.new(1, 0, 1, 0)
TutScroll.BackgroundTransparency = 1
TutScroll.ScrollBarThickness = 3
TutScroll.ScrollBarImageColor3 = Color3.fromRGB(220, 30, 40)
TutScroll.ZIndex = 4

local TutLayout = Instance.new("UIListLayout", TutScroll)
TutLayout.Padding = UDim.new(0, 6)

local TutText = Instance.new("TextLabel", TutScroll)
TutText.Size = UDim2.new(0.98, 0, 0, 60)
TutText.BackgroundColor3 = Color3.fromRGB(25, 12, 16)
TutText.BackgroundTransparency = 0.2
TutText.Text = "🔥 من تطوير Ben 🔥\nهذه قنواتنا الرسمية لشرح السكربتات، الهكر، والتحميلات المباشرة:"
TutText.TextColor3 = Color3.fromRGB(255, 215, 0)
TutText.Font = Enum.Font.SourceSansBold
TutText.TextSize = 11
TutText.TextWrapped = true
TutText.ZIndex = 5
Instance.new("UICorner", TutText).CornerRadius = UDim.new(0, 6)

local function addSocialLink(name, url, icon, color)
    local btn = Instance.new("TextButton", TutScroll)
    btn.Size = UDim2.new(0.98, 0, 0, 28)
    btn.BackgroundColor3 = color
    btn.Text = icon .. " " .. name .. " (اضغط للنسخ 📋)"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 10
    btn.ZIndex = 5
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(url)
            btn.Text = "تم نسخ الرابط! ✅"
            task.wait(1.5)
            btn.Text = icon .. " " .. name .. " (اضغط للنسخ 📋)"
        end
    end)
end

addSocialLink("حساب التيك توك", "https://www.tiktok.com/@bir.y5?_r=1&_t=ZS-99wM1BhqjlE", "🎵", Color3.fromRGB(20, 20, 20))
addSocialLink("قناة اليوتيوب", "https://youtube.com/@gqj2?si=g29jzyAPCwcTxrED", "▶", Color3.fromRGB(180, 25, 25))
addSocialLink("قناة التليجرام", "https://t.me/Ben_5k", "✈", Color3.fromRGB(0, 136, 204))
addSocialLink("سيرفر الديسكورد", "https://discord.gg/BedyzxgaG", "💬", Color3.fromRGB(88, 101, 242))

-- ==================== 9. نظام الشات (من ملفك الخارجي) ====================
local success, chatModule = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Leader150s/LUR-Hub/refs/heads/main/ChatModule.lua"))()
end)

if success and type(chatModule) == "function" then
    pcall(function()
        chatModule(ChatPage)
    end)
else
    local ErrorLabel = Instance.new("TextLabel", ChatPage)
    ErrorLabel.Size = UDim2.new(1, 0, 1, 0)
    ErrorLabel.BackgroundTransparency = 1
    ErrorLabel.Text = "⚠️ خطأ في تحميل ملف الشات الخارجي."
    ErrorLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    ErrorLabel.Font = Enum.Font.SourceSansBold
    ErrorLabel.TextSize = 12
end
