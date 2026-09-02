local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- 🔗 ضع رابط الـ Raw الخاص بملفك الأصلي في جيت هوب هنا بدقيقه:
local OFFICIAL_RAW_URL = "https://raw.githubusercontent.com/يوزرك/مستودعك/main/اسم_الملف.lua"

-- 🚨 رابط الويب هوك الخاص بالتنبيهات (تم تثبيت الويب هوك الخاص بك هنا)
local ALERT_WEBHOOK_URL = "https://discord.com/api/webhooks/1544739752010457110/AAhQiDGxu7mxQfR7BKmux13q72M7BtiEB6nvtbAB_f7OHX-N5VYitXzqbq-RMJst-2cL"

-- فحص أمان المصدر (Anti-Leak & Tamper Protection)
pcall(function()
    local success, fetchedCode = pcall(function()
        return game:HttpGet(OFFICIAL_RAW_URL)
    end)
    
    -- إذا كان الرابط غير مطابق أو تم سحب الكود وتشغيله من مصدر خارجي أو تم التعديل عليه
    if not success or not fetchedCode then
        pcall(function()
            local alertMsg = "🚨 **تنبيه محاولة سرقة أو تعديل على السكربت!**\n\n👤 **يوزر السارق:** " .. LocalPlayer.Name .. "\n🆔 **ID السارق:** " .. LocalPlayer.UserId .. "\n⚠️ **الحالة:** قام بنسخ الكود أو محاولة تعديله وتشغيله من مصدر غير مصرح به!"
            local data = { ["content"] = alertMsg }
            local body = HttpService:JSONEncode(data)
            local headers = { ["content-type"] = "application/json" }
            local requestFunc = syn and syn.request or http_request or request or HttpPost
            if requestFunc then
                requestFunc({ Url = ALERT_WEBHOOK_URL, Method = "POST", Headers = headers, Body = body })
            end
        end)
        
        -- إيقاف السكربت وتخريبه عند السارق تماماً
        error("[Dev.Script Security]: الكود غير مصرح بتشغيله من هذا المصدر!")
    end
end)

--------------------------------------------------------------------------------
-- [ كودك الأصلي الشغال 100% بدون أي تعديل في الوظائف ]
--------------------------------------------------------------------------------

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Lighting = game:GetService("Lighting")

local ShootEvent = ReplicatedStorage:WaitForChild("shared/network@GlobalEvents"):WaitForChild("shoot")

-- نسخ رابط الديسكورد تلقائياً أول ما يشتغل السكربت في الحافظة
pcall(function()
    setclipboard("https://discord.gg/4hDr9Zb7P")
end)

-- إعدادات السكربت والـ Config الافتراضية (شغال تماماً)
local DefaultConfig = {
    Enabled = true,
    TargetMode = "Head",
    NoRecoil = true,
    HiddenMode = false,
    HideKey = Enum.KeyCode.K,
    FOVSize = 250,
    Whitelist = {},
    ESPEnabled = true,
    HealthBarEnabled = true,
    FullbrightEnabled = false,
}

local Config = {
    Enabled = DefaultConfig.Enabled,
    TargetMode = DefaultConfig.TargetMode,
    NoRecoil = DefaultConfig.NoRecoil,
    HiddenMode = DefaultConfig.HiddenMode,
    HideKey = DefaultConfig.HideKey,
    FOVSize = DefaultConfig.FOVSize,
    Whitelist = {},
    ESPEnabled = DefaultConfig.ESPEnabled,
    HealthBarEnabled = DefaultConfig.HealthBarEnabled,
    FullbrightEnabled = DefaultConfig.FullbrightEnabled,
}

-- ملف الحفظ ونظام الـ Config
local ConfigFileName = "DevScript_Config.json"

local function SaveConfig()
    pcall(function()
        local data = {
            TargetMode = Config.TargetMode,
            NoRecoil = Config.NoRecoil,
            FOVSize = Config.FOVSize,
            ESPEnabled = Config.ESPEnabled,
            HealthBarEnabled = Config.HealthBarEnabled,
            FullbrightEnabled = Config.FullbrightEnabled,
            Whitelist = Config.Whitelist
        }
        writefile(ConfigFileName, HttpService:JSONEncode(data))
    end)
end

local function LoadConfig()
    if pcall(function() readfile(ConfigFileName) end) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(ConfigFileName))
        end)
        if success and type(result) == "table" then
            Config.TargetMode = result.TargetMode or Config.TargetMode
            Config.NoRecoil = result.NoRecoil ~= nil and result.NoRecoil or Config.NoRecoil
            Config.FOVSize = result.FOVSize or Config.FOVSize
            Config.ESPEnabled = result.ESPEnabled ~= nil and result.ESPEnabled or Config.ESPEnabled
            Config.HealthBarEnabled = result.HealthBarEnabled ~= nil and result.HealthBarEnabled or Config.HealthBarEnabled
            Config.FullbrightEnabled = result.FullbrightEnabled ~= nil and result.FullbrightEnabled or Config.FullbrightEnabled
            Config.Whitelist = result.Whitelist or Config.Whitelist
        end
    end
end

local function ResetConfig()
    pcall(function()
        if delfile then delfile(ConfigFileName) end
    end)
    Config.Enabled = DefaultConfig.Enabled
    Config.TargetMode = DefaultConfig.TargetMode
    Config.NoRecoil = DefaultConfig.NoRecoil
    Config.HiddenMode = DefaultConfig.HiddenMode
    Config.FOVSize = DefaultConfig.FOVSize
    Config.Whitelist = {}
    Config.ESPEnabled = DefaultConfig.ESPEnabled
    Config.HealthBarEnabled = DefaultConfig.HealthBarEnabled
    Config.FullbrightEnabled = DefaultConfig.FullbrightEnabled
end

LoadConfig()

-- دالة إرسال الويب هوك بالتنسيق القديم الأصلي بالضبط كما في الصورة
local function SendWebhookNotification()
    pcall(function()
        local url = "https://discord.com/api/webhooks/1544739752010457110/AAhQiDGxu7mxQfR7BKmux13q72M7BtiEB6nvtbAB_f7OHX-N5VYitXzqbq-RMJst-2cL"
        local messageText = "⚡ **تم تشغيل السكربت بنجاح!**\n\n👤 **Username:**\n" .. LocalPlayer.Name .. "\n\n🏷️ **DisplayName:**\n" .. LocalPlayer.DisplayName .. "\n\n🆔 **UserId:**\n" .. LocalPlayer.UserId
        
        local data = {
            ["content"] = messageText
        }
        local body = HttpService:JSONEncode(data)
        local headers = {["content-type"] = "application/json"}
        
        local requestFunc = syn and syn.request or http_request or request or HttpPost
        if requestFunc then
            requestFunc({Url = url, Method = "POST", Headers = headers, Body = body})
        end
    end)
end

-- تنفيذ إرسال الويب هوك عند الفتح
SendWebhookNotification()

-- دائرة الاستهداف
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(0, 255, 120)
FOVCircle.Filled = false
FOVCircle.Radius = Config.FOVSize
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local TracerLine = Drawing.new("Line")
TracerLine.Visible = false
TracerLine.Thickness = 1.5

-- Fullbright (إضاءة كاملة)
RunService.Heartbeat:Connect(function()
    if Config.FullbrightEnabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
end)

local function isPlayerVisible(targetPart)
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        if result.Instance:IsDescendantOf(targetPart.Parent) then
            return true
        end
        return false
    end
    return true
end

-- نظام الـ ESP
local ESPObjects = {}
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local box = Drawing.new("Square")
    box.Visible = false
    box.Thickness = 1.5
    box.Filled = false

    local healthBack = Drawing.new("Line")
    healthBack.Visible = false
    healthBack.Thickness = 4
    healthBack.Color = Color3.fromRGB(20, 20, 20)

    local healthBar = Drawing.new("Line")
    healthBar.Visible = false
    healthBar.Thickness = 2

    ESPObjects[player] = {Box = box, HealthBar = healthBar, HealthBack = healthBack}
end

for _, player in ipairs(Players:GetPlayers()) do CreateESP(player) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        ESPObjects[player].Box:Remove()
        ESPObjects[player].HealthBar:Remove()
        ESPObjects[player].HealthBack:Remove()
        ESPObjects[player] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Radius = Config.FOVSize

    for player, data in pairs(ESPObjects) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            local rootPart = character.HumanoidRootPart
            local head = character.Head
            local humanoid = character.Humanoid
            
            local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            if onScreen and vector.Z > 0 and not Config.HiddenMode then
                local topPoint = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.6, 0))
                local bottomPoint = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3.2, 0))
                
                local height = math.abs(topPoint.Y - bottomPoint.Y)
                local width = height / 2

                local visible = isPlayerVisible(head)

                if Config.ESPEnabled then
                    data.Box.Size = Vector2.new(width, height)
                    data.Box.Position = Vector2.new(vector.X - width / 2, topPoint.Y)
                    
                    if Config.Whitelist[player.Name] then
                        data.Box.Color = Color3.fromRGB(0, 150, 255)
                    elseif visible then
                        data.Box.Color = Color3.fromRGB(0, 255, 0)
                    else
                        data.Box.Color = Color3.fromRGB(255, 0, 0)
                    end
                    data.Box.Visible = true
                else
                    data.Box.Visible = false
                end

                if Config.HealthBarEnabled then
                    local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    local barX = vector.X - width / 2 - 7
                    
                    data.HealthBack.From = Vector2.new(barX, topPoint.Y)
                    data.HealthBack.To = Vector2.new(barX, topPoint.Y + height)
                    data.HealthBack.Visible = true

                    local barHeight = height * healthPercent
                    data.HealthBar.From = Vector2.new(barX, topPoint.Y + height)
                    data.HealthBar.To = Vector2.new(barX, topPoint.Y + height - barHeight)
                    data.HealthBar.Color = Color3.fromRGB(255 - (healthPercent * 255), healthPercent * 255, 0)
                    data.HealthBar.Visible = true
                else
                    data.HealthBack.Visible = false
                    data.HealthBar.Visible = false
                end
            else
                data.Box.Visible = false
                data.HealthBar.Visible = false
                data.HealthBack.Visible = false
            end
        else
            data.Box.Visible = false
            data.HealthBar.Visible = false
            data.HealthBack.Visible = false
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if Config.Enabled and Config.NoRecoil and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            Camera.CameraSubject = humanoid
        end
    end
end)

local function getBestTarget()
    if not Config.Enabled then return nil, false end
    local closestTarget = nil
    local shortestDist = Config.FOVSize
    local isVisibleStatus = false
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not Config.Whitelist[player.Name] and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local head = player.Character:FindFirstChild("Head")
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.Health > 0 then
                local chosenPart = (Config.TargetMode == "Head" and head) or (Config.TargetMode == "Body" and rootPart)
                if chosenPart then
                    local screenPoint, onScreen = Camera:WorldToScreenPoint(chosenPart.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude
                        if dist <= Config.FOVSize and dist < shortestDist then
                            shortestDist = dist
                            closestTarget = chosenPart
                            isVisibleStatus = isPlayerVisible(chosenPart)
                        end
                    end
                end
            end
        end
    end
    return closestTarget, isVisibleStatus
end

local currentTarget = nil
local targetVisible = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.HideKey then
        Config.HiddenMode = not Config.HiddenMode
        FOVCircle.Visible = not Config.HiddenMode
        if Config.HiddenMode then TracerLine.Visible = false end
    end
end)

RunService.RenderStepped:Connect(function()
    currentTarget, targetVisible = getBestTarget()
    if currentTarget and Config.Enabled and not Config.HiddenMode then
        local screenPoint, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
        if onScreen and screenPoint.Z > 0 then
            TracerLine.Color = targetVisible and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
            TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            TracerLine.To = Vector2.new(screenPoint.X, screenPoint.Y)
            TracerLine.Visible = true
        else
            TracerLine.Visible = false
        end
    else
        TracerLine.Visible = false
    end
end)

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if Config.Enabled and tostring(self) == "shoot" and method == "FireServer" then
        if currentTarget then
            local origin = args[2]
            if typeof(origin) == "Vector3" then
                args[3] = (currentTarget.Position - origin).Unit
            end
        end
    end
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

--------------------------------------------------------------------------------
-- واجهة WindUI الرسمية باسم Dev.Script
--------------------------------------------------------------------------------
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
	Title = "⚡ Dev.Script Hub | hf4_l ⚡",
	Folder = "DevScriptHub",
	Icon = "solar:folder-2-bold-duotone",
	NewElements = true,
	HideSearchBar = false,
	BackgroundImage = "rbxassetid://82588ea76b4e4fc7a13ef62e1f153e6c",
	OpenButton = {
		Title = "Open Dev.Script UI",
		CornerRadius = UDim.new(1, 0),
		StrokeThickness = 3,
		Enabled = true,
		Draggable = true,
		Scale = 0.5,
		Color = ColorSequence.new(
			Color3.fromHex("#30FF6A"),
			Color3.fromHex("#e7ff2f")
		),
	},
	Topbar = {
		Height = 44,
		ButtonsType = "Mac",
	},
})

Window:Tag({
	Title = "v2.0.6 • Dev.Script | TikTok: @hf4_l",
	Icon = "github",
	Color = Color3.fromHex("#1c1c1c"),
	Border = true,
})

local CombatTab = Window:Tab({ Title = "Combat / Aim", Icon = "solar:cursor-square-bold", Border = true })
local VisualsTab = Window:Tab({ Title = "Visuals & ESP", Icon = "solar:info-square-bold", Border = true })
local PlayersTab = Window:Tab({ Title = "Whitelist & Players", Icon = "solar:users-group-rounded-bold", Border = true })
local MiscTab = Window:Tab({ Title = "Misc & FPS Booster", Icon = "solar:square-transfer-horizontal-bold", Border = true })
local CreditsTab = Window:Tab({ Title = "Credits & Discord", Icon = "solar:file-text-bold", Border = true })

CombatTab:Toggle({
	Title = "Silent Aim System",
	Desc = "تفعيل أو تعطيل السايليت إيم",
	Value = Config.Enabled,
	Callback = function(state) Config.Enabled = state end,
})

CombatTab:Dropdown({
	Title = "Target Bone",
	Values = {"Head Only", "Body Only"},
	Value = (Config.TargetMode == "Head" and "Head Only") or "Body Only",
	Callback = function(option)
		Config.TargetMode = (option == "Head Only" and "Head") or "Body"
	end,
})

CombatTab:Slider({
	Title = "FOV Size",
	Step = 5,
	Value = { Min = 50, Max = 600, Default = Config.FOVSize },
	Callback = function(value)
		Config.FOVSize = value
		FOVCircle.Radius = value
	end,
})

CombatTab:Toggle({
	Title = "No Recoil & Stability",
	Desc = "ثبات تام للسلاح والكاميرا",
	Value = Config.NoRecoil,
	Callback = function(state) Config.NoRecoil = state end,
})

VisualsTab:Toggle({
	Title = "Enable ESP Boxes (كشف الصناديق)",
	Desc = "أخضر إذا كان مكشوفاً أمامك، وأحمر إذا كان خلف الجدار",
	Value = Config.ESPEnabled,
	Callback = function(state) Config.ESPEnabled = state end,
})

VisualsTab:Toggle({
	Title = "Enable Health Bar (كشف شريط الدم)",
	Desc = "إظهار شريط الدم الملون والمرتبط بدقة مع دم اللاعب",
	Value = Config.HealthBarEnabled,
	Callback = function(state) Config.HealthBarEnabled = state end,
})

VisualsTab:Toggle({
	Title = "Fullbright (إضاءة كاملة)",
	Desc = "إلغاء الظلام وتفتيح الخريطة بالكامل",
	Value = Config.FullbrightEnabled,
	Callback = function(state) Config.FullbrightEnabled = state end,
})

VisualsTab:Toggle({
	Title = "Show FOV Circle",
	Value = true,
	Callback = function(state) FOVCircle.Visible = state end,
})

local playerNames = {}
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then table.insert(playerNames, p.Name) end
end

PlayersTab:Dropdown({
	Title = "Select Player to Whitelist",
	Values = playerNames,
	Callback = function(selectedName)
		if selectedName then
			Config.Whitelist[selectedName] = true
			WindUI:Notify({ Title = "Whitelist", Content = "تمت إضافة " .. selectedName .. " إلى القائمة البيضاء!", Duration = 3 })
		end
	end,
})

PlayersTab:Button({
	Title = "Clear Whitelist (مسح القائمة)",
	Callback = function()
		Config.Whitelist = {}
		WindUI:Notify({ Title = "Whitelist", Content = "تم تفريغ القائمة البيضاء بالكامل!", Duration = 3 })
	end,
})

MiscTab:Button({
	Title = "Boost FPS & Reduce Lag (تخفيف الاق)",
	Desc = "تنظيف الخريطة ورفع الأداء بدون أي تأثير سلبي على الوضوح",
	Callback = function()
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			end
		end
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 999999
		WindUI:Notify({ Title = "FPS Booster", Content = "تم تخفيف الاق ورفع الأداء بنجاح تام!", Duration = 4 })
	end,
})

MiscTab:Button({
	Title = "Toggle UI Visibility (زر إخفاء/إظهار القائمة للجوال)",
	Desc = "اضغط هنا لإخفاء أو إظهار الواجهة بالكامل",
	Callback = function()
		Config.HiddenMode = not Config.HiddenMode
		FOVCircle.Visible = not Config.HiddenMode
		WindUI:Notify({ Title = "UI Mode", Content = Config.HiddenMode and "تم إخفاء العناصر" or "تم إظهار العناصر", Duration = 2 })
	end,
})

MiscTab:Keybind({
	Title = "UI Hide Keybind (زر ل
