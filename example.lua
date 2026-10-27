local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ser1771/EvergreenLibrary/refs/heads/main/Evergreen.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

Library.SaveManager:SetFolder("EvergreenExample")
Library:SetNotifySide("Right")
Library:RegisterTheme("Sunset", {
    Accent = Color3.fromRGB(255, 110, 70),
    AccentText = Color3.fromRGB(45, 15, 5),
    SliderFill = Color3.fromRGB(255, 130, 90),
})

local Loader = Library:CreateLoading({
    Title = "Evergreen",
    Message = "Starting up...",
    Description = "Loading full example",
    TotalSteps = 4,
})
Loader:SetCurrentStep(1)

local Window = Library:CreateWindow({
    Title = "<Animated:glow>Evergreen</Animated>",
    Subtitle = "Full Example",
    Footer = "<Accent>v1.0",
    Size = UDim2.fromOffset(860, 560),
    MinSize = Vector2.new(640, 420),
    Center = true,
    AutoShow = true,
    Resizable = true,
    Theme = "Dark",
    CornerRadius = 12,
    SidebarWidth = 195,
    SearchStyle = 1,
    ToggleKeybind = Enum.KeyCode.RightControl,
    ShowTrafficLights = true,
    ShowUserChip = true,
    Dock = { Scale = 0.8, Position = "Top", Draggable = true },
    Glass = false,
    Blur = false,
    Transparency = 0,
    CloseUnloads = false,
    OnClose = function() Library:Notify({ Title = "Evergreen", Description = "Window hidden (RightControl to reopen)", Time = 3 }) end,
})

task.delay(0, function() Loader:SetCurrentStep(2) end)

Window:AddSection("General")

local MainTab = Window:AddTab({
    Name = "Main",
    Icon = "house",
    Description = "Core features",
    Tooltip = "The kitchen sink tab",
})

local Combat = MainTab:AddLeftGroupbox("Combat", "sword")

Combat:AddToggle("Fly", {
    Text = "Fly",
    Default = false,
    Callback = function(On) print("[example] fly =", On) end,
}):AddKeyPicker("Fly#key", {
    Default = "F",
    Mode = "Toggle",
    Text = "Fly",
    SyncToggleState = true,
    Callback = function(v) print("[example] fly key =", v) end,
})

Combat:AddToggle("Noclip", { Text = "Noclip", Changed = function(v) print("[example] noclip =", v) end })
Combat:AddCheckbox("AutoLock", { Text = "Auto-lock target (checkbox style)" })
Combat:AddToggle("RiskyOp", { Text = "Risky operation", Risky = true })

Combat:AddSlider("Speed", {
    Text = "Speed",
    Min = 16, Max = 200, Default = 16, Rounding = 0,
    Suffix = " sps",
    FormatDisplayValue = function(_, v) return tostring(v) .. " studs/s" end,
    Callback = function(v) print("[example] speed =", v) end,
})

Combat:AddSlider("WalkFov", {
    Text = "Field of view",
    Min = 0, Max = 180, Default = 70, Rounding = 0,
    Prefix = "deg ",
    Deferred = true,
})

Combat:AddRangeSlider("DistRange", {
    Text = "Target distance",
    Min = 0, Max = 500, Default = { 50, 250 }, Rounding = 0,
    Suffix = "m",
    Callback = function(Min, Max) print("[example] range =", Min, "-", Max) end,
})

Combat:AddDivider("Input")

Combat:AddInput("Nickname", {
    Text = "Nickname",
    Placeholder = "Enter a name...",
    AllowEmpty = false,
    EmptyReset = "---",
    Finished = true,
    Callback = function(v) print("[example] nickname =", v) end,
})

Combat:AddInput("FpsCap", {
    Text = "FPS cap (numeric)",
    Default = "60",
    Numeric = true,
    Placeholder = "60",
})

Combat:AddInput("SearchBox", {
    Text = "Animated placeholder",
    Placeholders = { "type to search...", "try 'fly'", "or press Enter" },
    AnimatePlaceholder = true,
    PlaceholderSpeed = 0.05,
    ClearTextOnFocus = false,
})

local RowA = Combat:AddRowBox({ Cols = 2 }, function(Row)
    Row:AddToggle("RowA1", { Text = "Quick swap", Default = true })
    Row:AddDropdown("RowA2", { Text = "Mode", Values = { "Aggressive", "Passive", "Legit" }, Default = "Legit" })
end)

local Adv = Combat:AddNestedGroupbox("Advanced", { Collapsed = false })
Adv:AddToggle("AutoStrafe", { Text = "Auto strafe", Default = false })
Adv:AddSlider("StrafePower", { Text = "Strafe power", Min = 0, Max = 100, Default = 40, Rounding = 0, Suffix = "%" })
Adv:AddDropdown("PriorityTarget", { Text = "Target priority", Values = { "Nearest", "Lowest HP", "Crosshair" }, Default = "Crosshair" })

local Loadout = MainTab:AddRightGroupbox("Loadout", "target")

local Weapon = Loadout:AddDropdown("Weapon", {
    Text = "Weapon",
    Values = { "Sword", "AK-47", "Sniper", "Pistol" },
    Default = "Sword",
    Callback = function(v) print("[example] weapon =", v) end,
})

local Friends
Friends = Loadout:AddDropdown("Friends", {
    Text = "Ignore players",
    Multi = true,
    Values = { "Alice", "Bob", "Carol", "Dave" },
    Default = { "Alice" },
    Callback = function()
        print("[example] friends =", table.concat(Friends:GetActiveValues(), ", "))
    end,
})

Loadout:AddDropdown("TargetPlayer", {
    Text = "Target player",
    SpecialType = "Player",
    ExcludeLocalPlayer = true,
    Callback = function(v) print("[example] target =", v and v.Name) end,
})

Loadout:AddDropdown("TeamColor", {
    Text = "Team",
    SpecialType = "Team",
    Callback = function(v) print("[example] team =", v and v.Name) end,
})

Loadout:AddPriorityDropdown("DrawOrder", {
    Text = "ESP draw order",
    Extended = true,
    Values = {
        { Name = "Head glow", Priority = 1 },
        { Name = "Bounding box", Priority = 2 },
        { Name = "Name tags", Priority = 3 },
        { Name = "Health bars", Priority = 4 },
        { Name = "Chams", Priority = 5 },
    },
    Callback = function(v) print("[example] top of draw order:", v) end,
})

Loadout:AddPriorityDropdown("HudLayers", {
    Text = "HUD layers (popup mode)",
    Values = {
        { Name = "Watermark", Priority = 1 },
        { Name = "Keybind list", Priority = 2 },
        { Name = "Notifications", Priority = 3 },
    },
    Callback = function(v) print("[example] hud top layer:", v) end,
})

local RowB = Loadout:AddRowBox({ Cols = 3 }, function(Row)
    Row:AddSlider("RowB1", { Text = "Delay", Min = 0, Max = 300, Default = 120, Rounding = 0, Suffix = "ms" })
    Row:AddButton("RowB2", { Text = "Apply", Func = function() Library:Notify("Row applied") end })
    Row:AddCircleButton("RowB3", { Icon = "sparkles", Func = function() Library:Notify("Circle in a row!") end })
end)

Loadout:AddList("Hotkeys", {
    Text = "Active macros",
    Values = { "Speedrun", "Flick", "Bunny hop" },
    Multi = true,
    Height = 110,
    Callback = function() print("[example] macros changed") end,
})

Loadout:AddDivider()

Loadout:AddLabel("Toggle color picks the ESP tint:"):AddColorPicker("EspTint#color", {
    Default = Color3.fromRGB(0, 200, 255),
    Title = "ESP tint",
    Transparency = 0,
    Callback = function(c) print("[example] tint =", c:ToHex()) end,
})

Loadout:AddButton("PrimaryAction", {
    Text = "Primary",
    Primary = true,
    Func = function() Library:Notify("Primary clicked") end,
})

Loadout:AddButton("SecondaryAction", {
    Text = "Secondary",
    Func = function() Library:Notify("Secondary clicked") end,
})

Loadout:AddCircleButton("CircleRefresh", {
    Icon = "refresh-cw",
    Text = "Refresh",
    Size = 34,
    Func = function() Library:Notify({ Title = "Loadout", Description = "Refreshed", Time = 2 }) end,
})

Loadout:AddCircleButton("CircleStar", {
    Icon = "star",
    Text = "Favorite",
    Primary = true,
    Size = 34,
    Func = function() Library:Notify({ Title = "Loadout", Description = "Favorited", Time = 2 }) end,
})

Loadout:AddCircleButton("CircleTrash", {
    Icon = "trash-2",
    Text = "Delete",
    Risky = true,
    Size = 34,
    Func = function() Library:Notify({ Title = "Loadout", Description = "Deleted", Time = 2 }) end,
})

task.delay(0, function() Loader:SetCurrentStep(3) end)

Window:AddSection("Render")

local VisualTab = Window:AddTab({
    Name = "Visuals",
    Icon = "eye",
    Description = "ESP / world renderers",
})

local Modes = VisualTab:AddLeftTabbox("ESP Mode")
local Aggressive = Modes:AddTab("Aggressive", "zap")
local Subtle = Modes:AddTab("Subtle", "feather")

Aggressive:AddToggle("EspBoxes", { Text = "Bounding boxes", Default = true })
Aggressive:AddToggle("EspNames", { Text = "Name tags", Default = true })
Aggressive:AddToggle("EspHealth", { Text = "Health bars" })

Subtle:AddToggle("EspChams", { Text = "Chams only" })
Subtle:AddSlider("EspOpacity", { Text = "Opacity", Min = 0, Max = 100, Default = 65, Rounding = 0, Suffix = "%" })

local Master = VisualTab:AddRightGroupbox("Master", "power")
local EnableAdvanced = Master:AddToggle("AdvancedEsp", { Text = "Advanced ESP", Default = true })

local DB = Master:AddDependencyBox()
DB:AddSlider("AdvDistance", { Text = "Render distance", Min = 50, Max = 2000, Default = 500, Rounding = 0, Suffix = "m" })
DB:AddDropdown("AdvSort", { Text = "Sort by", Values = { "Distance", "Health", "Threat" }, Default = "Distance" })
DB:AddToggle("AdvOutline", { Text = "Outline glow" })
DB:SetupDependencies({ { EnableAdvanced, true } })

local Info = VisualTab:AddRightGroupbox("Info", "info")
Info:AddTitle("Rich content demo")
Info:AddParagraph("Paragraphs", "Supports titles and bodies. Use <b>bold</b>, <Accent>accent</Accent>, <Red>red</Red> and <Copyable>click-to-copy</Copyable> tags inside labels.")
Info:AddLabel("<Rainbow>Rainbow</Rainbow>, <Pulse>pulse</Pulse> and <Typewriter>typewriter</Typewriter> animations work inline.")
Info:AddLabel({
    Text = "<Animated:neon>neon</Animated> <Animated:glow>glow</Animated> <Animated:pendulum>pendulum</Animated> <Animated:shimmer>shimmer</Animated> <Animated:swing>swing</Animated> <Animated:bounce>bounce</Animated> <Animated:sway>sway</Animated> <Animated:breathe>breathe</Animated> <Animated:spark>spark</Animated> <Animated:flame>flame</Animated> <Animated:heartbeat>heartbeat</Animated> <Animated:clock>clock</Animated> <Animated:cascade>cascade</Animated> <Animated:prism>prism</Animated> <Animated:zoom>zoom</Animated> <Animated:ripple>ripple</Animated> <Animated:electric>electric</Animated> <Animated:quantum>quantum</Animated> <Animated:caret>caret</Animated>",
    DoesWrap = true,
})

local RowC = Info:AddRowBox(2, function(Row)
    Row:AddCheckbox("RowC1", { Text = "Streamer mode", Default = false })
    Row:AddSlider("RowC2", { Text = "Scale", Min = 50, Max = 150, Default = 100, Rounding = 0, Suffix = "%" })
end)
Info:AddCallout({ Type = "warning", Title = "Heads up", Text = "Dependency boxes hide their children until the parent matches." })
Info:AddCallout({ Type = "success", Title = "Saved", Text = "Config auto-applies on load." })
Info:AddDivider("Middle")
Info:AddSkeleton({ Rows = 3, Height = 14, Gap = 8 })
Info:AddImage("Avatar", {
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420",
    Height = 120,
    ScaleType = Enum.ScaleType.Fit,
})

local External = Instance.new("TextLabel")
External.BackgroundTransparency = 0.6
External.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
External.Text = "External GUI hosted with UIPassthrough"
External.TextSize = 12
Info:AddUIPassthrough("ExternalUI", { Instance = External, Height = 34 })

local PlayerTab = Window:AddTab({ Name = "Players", Icon = "user", Description = "Player-centric tools" })

local Legit = PlayerTab:AddPage("Legit", "crosshair")
local LegitBox = Legit:AddLeftGroupbox("Movement", "footprints")
LegitBox:AddToggle("WalkSpeed", { Text = "Speed boost" }):AddKeyPicker("WalkSpeed#key", { Default = "LeftShift", Mode = "Hold" })
LegitBox:AddSlider("BoostAmount", { Text = "Boost", Min = 16, Max = 80, Default = 24, Rounding = 0 })

local Exploit = PlayerTab:AddPage("Exploit", "skull")
local ExpBox = Exploit:AddLeftGroupbox("Teleport", "map-pin")
ExpBox:AddDropdown("TpLocation", { Text = "Location", Values = { "Spawn", "Base", "Tower" }, Default = "Spawn" })
ExpBox:AddButton("TeleportBtn", { Text = "Teleport", Func = function() Library:Notify({ Title = "Players", Description = "Teleport placeholder", Time = 2.5 }) end })

local DataTab = Window:AddTab({ Name = "Data", Icon = "database", Description = "Tables & actions" })

local ServerBox = DataTab:AddSingleGroupbox("Server browser", "server")

local Table = ServerBox:AddTable("Servers", {
    Columns = {
        { Name = "Server", Key = "Name", Width = 3 },
        { Name = "Region", Key = "Region", Width = 1 },
        { Name = "Ping", Key = "Ping", Width = 1, Align = "Right" },
        { Name = "Status", Key = "Status", Width = 2, Align = "Center" },
    },
    Rows = {
        { Name = "US-East #142", Region = "us", Ping = 42, Status = { Color = Color3.fromRGB(80, 220, 120), Text = "Good" } },
        { Name = "EU-West #88", Region = "eu", Ping = 118, Status = { Color = Color3.fromRGB(255, 190, 60), Text = "Fair" } },
        { Name = "ASIA #12", Region = "as", Ping = 210, Status = { Color = Color3.fromRGB(255, 90, 90), Text = "Poor" } },
    },
    Height = 240,
    Searchable = true,
    Striped = true,
    Callback = function(Row, Index) print("[example] selected", Row.Name, Index) end,
    DoubleClick = function(Row) Library:Notify({ Title = "Join", Description = "Joining " .. Row.Name, Time = 2.5 }) end,
    RightClick = function(Row) Library:Notify({ Title = "Row menu", Description = Row.Name, Time = 2 }) end,
})

ServerBox:AddButton("AddRowBtn", { Text = "Add row", Icon = "plus", Func = function()
    Table:SetRows({
        { Name = "Dynamic #" .. math.random(100, 999), Region = "auto", Ping = math.random(20, 300), Status = { Color = Color3.fromRGB(80, 220, 120), Text = "New" } },
    })
end })
ServerBox:AddButton("ClearRowsBtn", { Text = "Clear", Func = function() Table:SetRows({}) end })
ServerBox:AddButton("RestoreRowsBtn", { Text = "Restore", Func = function()
    Table:SetRows({
        { Name = "US-East #142", Region = "us", Ping = 42, Status = { Color = Color3.fromRGB(80, 220, 120), Text = "Good" } },
        { Name = "EU-West #88", Region = "eu", Ping = 118, Status = { Color = Color3.fromRGB(255, 190, 60), Text = "Fair" } },
    })
end })

local Actions = DataTab:AddSingleGroupbox("Actions", "zap")

local ConfirmDialog = Window:AddDialog("confirmWipe", {
    Title = "Wipe settings?",
    Description = "This clears the saved config for EvergreenExample. You can't undo this.",
    Icon = "triangle-alert",
    OutsideClickDismiss = true,
    Hidden = true,
    FooterButtons = {
        { Title = "Wipe", Variant = "Destructive", Callback = function()
            Library:Notify({ Title = "Wiped", Description = "Config cleared (demo)", Time = 3 })
        end },
        { Title = "Cancel", Variant = "Secondary" },
    },
})
ConfirmDialog:AddToggle("ConfirmToggle", { Text = "I understand the consequences", Default = false })

Actions:AddButton("OpenDialogBtn", { Text = "Open dialog", Func = function() ConfirmDialog:Show() end })

Actions:AddButton("HoldWipe", {
    Text = "Hold to wipe",
    Hold = 3,
    Risky = true,
    Func = function()
        Library:Notify({ Title = "Data", Description = "Hold completed", Time = 3 })
    end,
})

Actions:AddButton("NotifyBtn", {
    Text = "Notification (tap to stack)",
    Func = function()
        Library:Notify({
            Title = "Evergreen",
            Description = "Same notify stacks with a counter.",
            Time = 5,
            Icon = "bell",
            OnClick = function() print("[example] notify clicked") end,
            OnDismiss = function(Reason) print("[example] notify dismissed:", Reason) end,
        })
    end,
})

local TitleFlip = false
local RadFlip = false
local Widths = { 120, 195, 240 }
local WidthIdx = 2

Actions:AddButton("TitleApiBtn", {
    Text = "Cycle window text",
    Func = function()
        TitleFlip = not TitleFlip
        Window:ChangeTitle(TitleFlip and "<Animated:wave>Evergreen</Animated>" or "<Animated:glow>Evergreen</Animated>")
        Window:SetSubtitle("Edited at " .. os.date("%H:%M:%S"))
        Window:SetFooter("<Accent>v1.0 <Sub>edited</Sub>")
    end,
})

Actions:AddButton("WinLookBtn", {
    Text = "Cycle corner radius",
    Func = function()
        RadFlip = not RadFlip
        Window:SetCornerRadius(RadFlip and 8 or 14)
    end,
})

Actions:AddButton("SideWBtn", {
    Text = "Cycle sidebar width",
    Func = function()
        WidthIdx = WidthIdx % #Widths + 1
        Window:SetSidebarWidth(Widths[WidthIdx])
    end,
})

Actions:AddButton("JumpBtn", {
    Text = "Jump to search result",
    Func = function()
        local Res = Library:SearchEntries("aim", 1)
        if Res[1] then Library:JumpTo(Res[1]) end
    end,
})

Actions:AddButton("PinBtn", {
    Text = "Pin Combat groupbox",
    Func = function() Combat:TogglePin() end,
})

Actions:AddButton("SidebarBtn", {
    Text = "Toggle sidebar",
    Func = function() Window:SetSidebarVisible(Window.SidebarVisible == false) end,
})

Actions:AddButton("TabTitleBtn", {
    Text = "Toggle tab title",
    Func = function() Window:SetTabTitleVisible(Window.TabTitleVisible == false) end,
})

Actions:AddButton("KeybindHudBtn", {
    Text = "Toggle keybind HUD",
    Func = function() Library:SetKeybindListVisible(not Library.KeybindListEnabled) end,
})

Actions:AddButton("UnloadBtn", {
    Text = "Unload library",
    Risky = true,
    Func = function() Library:Unload() end,
})

local KeyTab = Window:AddKeyTab({ Name = "Keys", Icon = "keyboard", Description = "Key capture page" })

KeyTab:AddKeyBox(function(Key)
    Library:Notify({ Title = "Key captured", Description = tostring(Key), Time = 2 })
end)

KeyTab:AddLabel("<Animated:pulse>Type a key, then Submit.</Animated>")
KeyTab:AddToggle("CaptureMode", { Text = "Keep capturing", Default = true })

Window:AddSection("System")
Library:BuildSettingsTab(Window, { Name = "Settings", Config = true })

local Dock = Library.Dock
if Dock then
    Dock:AddTab(MainTab)
    Dock:AddSeparator()
    Dock:AddButton({
        Name = "Notify",
        Icon = "bell",
        Tooltip = "Fire a test notification",
        Callback = function() Library:Notify({ Title = "Dock", Description = "From the dock!", Time = 2.5 }) end,
    })
    local MsgButton = Dock:AddButton({
        Name = "Messages",
        Icon = "message-square",
        Toggle = true,
        Default = false,
        Callback = function(State)
            print("[example] dock toggle =", State)
            MsgButton:SetBadge(State and "3" or nil)
            Dock:SetButtonIcon("Messages", State and "mail-open" or "mail")
        end,
    })
    Dock:AddButton({
        Name = "Junk",
        Icon = "circle-dashed",
        Tooltip = "Removes itself (RemoveButton)",
        Callback = function(_, Btn) Dock:RemoveButton(Btn) end,
    })
    Dock:AddButton({
        Name = "Theme",
        Icon = "palette",
        Tooltip = "Cycle themes",
        Callback = function()
            local Names = { "Dark", "Mocha", "Nord", "Catppuccin", "Midnight", "Light" }
            local Idx = (table.find(Names, Library.ThemeName) or 0) % #Names + 1
            Library:SetTheme(Names[Idx])
            Library:Notify({ Title = "Theme", Description = Names[Idx], Time = 2 })
        end,
    })
    Dock.OnCollapseChanged = function(Collapsed) print("[example] dock collapsed =", Collapsed) end
end

local Pill = Library:AddDraggableLabel("Evergreen")
local Frames, ClockStart = 0, os.clock()
RunService.Heartbeat:Connect(function()
    Frames += 1
    local Now = os.clock()
    if Now - ClockStart >= 0.5 then
        Pill:SetText(string.format("Evergreen  |  %d FPS  |  %s", math.floor(Frames / (Now - ClockStart)), LocalPlayer.Name))
        Frames, ClockStart = 0, Now
    end
end)

Library.SaveManager:LoadAutoload()
Library:SetKeybindListVisible(true)

Library:OnUnload(function()
    print("[example] Evergreen unloaded")
end)

Library:Notify({
    Title = "Evergreen",
    Description = "Full example loaded — press RightControl to toggle, use the magnifier to search.",
    Time = 6,
    Icon = "leaf",
})

pcall(function() Loader:Destroy() end)
