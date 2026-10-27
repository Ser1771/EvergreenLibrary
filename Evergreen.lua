--// Services \\--
local cloneref = cloneref or function(Instance_) return Instance_ end
local function GetService(Name) return cloneref(game:GetService(Name)) end

local CoreGui = GetService("CoreGui")
local Players = GetService("Players")
local RunService = GetService("RunService")
local UserInputService = GetService("UserInputService")
local TweenService = GetService("TweenService")
local Teams = GetService("Teams")

local getgenv = getgenv or function() return shared end
do
    local Prev = getgenv().Library
    if type(Prev) == "table" and Prev.Unload and not Prev.Unloaded then pcall(Prev.Unload, Prev) end
end
local protectgui = protectgui or (syn and syn.protect_gui) or function() end
local gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Mouse = LocalPlayer:GetMouse()

--// Themes \\--
local Themes = {
    Dark = {
        Window = Color3.fromRGB(30, 30, 32),
        Sidebar = Color3.fromRGB(37, 37, 40),
        Titlebar = Color3.fromRGB(44, 44, 47),
        Card = Color3.fromRGB(44, 44, 47),
        Control = Color3.fromRGB(62, 62, 66),
        ControlHover = Color3.fromRGB(74, 74, 79),
        Popup = Color3.fromRGB(50, 50, 54),
        Segment = Color3.fromRGB(96, 96, 102),
        Track = Color3.fromRGB(84, 84, 88),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(70, 70, 75),
        Text = Color3.fromRGB(245, 245, 247),
        SubText = Color3.fromRGB(152, 152, 160),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58),
        IsLight = false,
    },
    Graphite = {
        Window = Color3.fromRGB(22, 22, 24),
        Sidebar = Color3.fromRGB(28, 28, 30),
        Titlebar = Color3.fromRGB(34, 34, 36),
        Card = Color3.fromRGB(34, 34, 37),
        Control = Color3.fromRGB(52, 52, 56),
        ControlHover = Color3.fromRGB(64, 64, 69),
        Popup = Color3.fromRGB(40, 40, 44),
        Segment = Color3.fromRGB(84, 84, 90),
        Track = Color3.fromRGB(70, 70, 75),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(56, 56, 61),
        Text = Color3.fromRGB(240, 240, 244),
        SubText = Color3.fromRGB(140, 140, 150),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58),
        IsLight = false,
    },
    Midnight = {
        Window = Color3.fromRGB(13, 17, 30), Sidebar = Color3.fromRGB(17, 22, 40), Titlebar = Color3.fromRGB(24, 30, 54),
        Card = Color3.fromRGB(22, 28, 50), Control = Color3.fromRGB(38, 47, 78), ControlHover = Color3.fromRGB(50, 61, 98),
        Popup = Color3.fromRGB(28, 35, 62), Segment = Color3.fromRGB(70, 84, 130), Track = Color3.fromRGB(58, 68, 104),
        SliderFill = Color3.fromRGB(235, 240, 255), Outline = Color3.fromRGB(46, 56, 92), Text = Color3.fromRGB(236, 240, 255),
        SubText = Color3.fromRGB(135, 146, 184), Accent = Color3.fromRGB(10, 132, 255), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58), IsLight = false,
    },
    Mocha = {
        Window = Color3.fromRGB(30, 26, 24), Sidebar = Color3.fromRGB(38, 33, 30), Titlebar = Color3.fromRGB(46, 40, 36),
        Card = Color3.fromRGB(45, 39, 35), Control = Color3.fromRGB(66, 58, 52), ControlHover = Color3.fromRGB(80, 70, 63),
        Popup = Color3.fromRGB(52, 45, 40), Segment = Color3.fromRGB(104, 92, 82), Track = Color3.fromRGB(88, 78, 70),
        SliderFill = Color3.fromRGB(250, 244, 236), Outline = Color3.fromRGB(74, 65, 58), Text = Color3.fromRGB(248, 242, 235),
        SubText = Color3.fromRGB(165, 152, 140), Accent = Color3.fromRGB(255, 159, 10), AccentText = Color3.fromRGB(30, 20, 10),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Rose = {
        Window = Color3.fromRGB(28, 22, 26), Sidebar = Color3.fromRGB(36, 28, 33), Titlebar = Color3.fromRGB(44, 34, 40),
        Card = Color3.fromRGB(43, 33, 39), Control = Color3.fromRGB(64, 50, 58), ControlHover = Color3.fromRGB(78, 62, 71),
        Popup = Color3.fromRGB(50, 39, 46), Segment = Color3.fromRGB(102, 82, 94), Track = Color3.fromRGB(86, 69, 79),
        SliderFill = Color3.fromRGB(255, 240, 246), Outline = Color3.fromRGB(72, 56, 65), Text = Color3.fromRGB(250, 240, 245),
        SubText = Color3.fromRGB(168, 146, 158), Accent = Color3.fromRGB(255, 55, 95), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 120, 100), IsLight = false,
    },
    Light = {
        Window = Color3.fromRGB(246, 246, 247),
        Sidebar = Color3.fromRGB(236, 236, 239),
        Titlebar = Color3.fromRGB(232, 232, 235),
        Card = Color3.fromRGB(255, 255, 255),
        Control = Color3.fromRGB(235, 235, 238),
        ControlHover = Color3.fromRGB(224, 224, 228),
        Popup = Color3.fromRGB(255, 255, 255),
        Segment = Color3.fromRGB(255, 255, 255),
        Track = Color3.fromRGB(205, 205, 210),
        SliderFill = Color3.fromRGB(40, 184, 78),
        Outline = Color3.fromRGB(210, 210, 215),
        Text = Color3.fromRGB(28, 28, 30),
        SubText = Color3.fromRGB(112, 112, 120),
        Accent = Color3.fromRGB(40, 184, 78),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 59, 48),
        IsLight = true,
    },
    Ocean = {
        Window = Color3.fromRGB(12, 28, 36), Sidebar = Color3.fromRGB(16, 36, 46), Titlebar = Color3.fromRGB(20, 44, 56),
        Card = Color3.fromRGB(22, 46, 58), Control = Color3.fromRGB(32, 64, 80), ControlHover = Color3.fromRGB(42, 80, 98),
        Popup = Color3.fromRGB(26, 52, 66), Segment = Color3.fromRGB(48, 96, 118), Track = Color3.fromRGB(40, 78, 96),
        SliderFill = Color3.fromRGB(220, 245, 255), Outline = Color3.fromRGB(40, 72, 88), Text = Color3.fromRGB(230, 246, 255),
        SubText = Color3.fromRGB(130, 170, 190), Accent = Color3.fromRGB(0, 199, 190), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Forest = {
        Window = Color3.fromRGB(18, 26, 20), Sidebar = Color3.fromRGB(24, 34, 26), Titlebar = Color3.fromRGB(30, 42, 32),
        Card = Color3.fromRGB(28, 40, 30), Control = Color3.fromRGB(42, 58, 44), ControlHover = Color3.fromRGB(54, 72, 56),
        Popup = Color3.fromRGB(34, 48, 36), Segment = Color3.fromRGB(64, 92, 68), Track = Color3.fromRGB(52, 74, 56),
        SliderFill = Color3.fromRGB(230, 250, 235), Outline = Color3.fromRGB(48, 66, 50), Text = Color3.fromRGB(232, 245, 234),
        SubText = Color3.fromRGB(140, 170, 148), Accent = Color3.fromRGB(52, 199, 89), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Sunset = {
        Window = Color3.fromRGB(32, 18, 22), Sidebar = Color3.fromRGB(40, 24, 28), Titlebar = Color3.fromRGB(50, 30, 34),
        Card = Color3.fromRGB(48, 28, 32), Control = Color3.fromRGB(72, 42, 48), ControlHover = Color3.fromRGB(88, 52, 58),
        Popup = Color3.fromRGB(56, 34, 38), Segment = Color3.fromRGB(110, 64, 72), Track = Color3.fromRGB(90, 54, 60),
        SliderFill = Color3.fromRGB(255, 236, 220), Outline = Color3.fromRGB(78, 46, 52), Text = Color3.fromRGB(255, 240, 235),
        SubText = Color3.fromRGB(190, 150, 145), Accent = Color3.fromRGB(255, 120, 50), AccentText = Color3.fromRGB(40, 15, 10),
        Red = Color3.fromRGB(255, 90, 80), IsLight = false,
    },
    Lavender = {
        Window = Color3.fromRGB(28, 24, 38), Sidebar = Color3.fromRGB(36, 30, 48), Titlebar = Color3.fromRGB(44, 38, 58),
        Card = Color3.fromRGB(42, 36, 56), Control = Color3.fromRGB(62, 54, 82), ControlHover = Color3.fromRGB(76, 66, 98),
        Popup = Color3.fromRGB(50, 44, 68), Segment = Color3.fromRGB(98, 86, 130), Track = Color3.fromRGB(80, 70, 108),
        SliderFill = Color3.fromRGB(245, 238, 255), Outline = Color3.fromRGB(70, 60, 96), Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(165, 155, 195), Accent = Color3.fromRGB(175, 130, 255), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 110, 120), IsLight = false,
    },
    Nord = {
        Window = Color3.fromRGB(36, 41, 51), Sidebar = Color3.fromRGB(46, 52, 64), Titlebar = Color3.fromRGB(59, 66, 82),
        Card = Color3.fromRGB(54, 60, 74), Control = Color3.fromRGB(67, 76, 94), ControlHover = Color3.fromRGB(76, 86, 106),
        Popup = Color3.fromRGB(50, 56, 70), Segment = Color3.fromRGB(94, 106, 130), Track = Color3.fromRGB(76, 86, 106),
        SliderFill = Color3.fromRGB(236, 239, 244), Outline = Color3.fromRGB(67, 76, 94), Text = Color3.fromRGB(236, 239, 244),
        SubText = Color3.fromRGB(136, 146, 170), Accent = Color3.fromRGB(136, 192, 208), AccentText = Color3.fromRGB(20, 28, 36),
        Red = Color3.fromRGB(191, 97, 106), IsLight = false,
    },
    Dracula = {
        Window = Color3.fromRGB(30, 31, 41), Sidebar = Color3.fromRGB(40, 42, 54), Titlebar = Color3.fromRGB(48, 50, 64),
        Card = Color3.fromRGB(44, 46, 60), Control = Color3.fromRGB(68, 71, 90), ControlHover = Color3.fromRGB(80, 84, 106),
        Popup = Color3.fromRGB(52, 54, 70), Segment = Color3.fromRGB(98, 104, 128), Track = Color3.fromRGB(78, 82, 104),
        SliderFill = Color3.fromRGB(248, 248, 242), Outline = Color3.fromRGB(68, 71, 90), Text = Color3.fromRGB(248, 248, 242),
        SubText = Color3.fromRGB(152, 158, 180), Accent = Color3.fromRGB(189, 147, 249), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 85, 85), IsLight = false,
    },
    Cyber = {
        Window = Color3.fromRGB(8, 12, 18), Sidebar = Color3.fromRGB(12, 18, 28), Titlebar = Color3.fromRGB(16, 24, 36),
        Card = Color3.fromRGB(14, 22, 34), Control = Color3.fromRGB(24, 40, 58), ControlHover = Color3.fromRGB(32, 54, 76),
        Popup = Color3.fromRGB(18, 28, 42), Segment = Color3.fromRGB(40, 70, 100), Track = Color3.fromRGB(30, 52, 74),
        SliderFill = Color3.fromRGB(180, 255, 240), Outline = Color3.fromRGB(30, 50, 70), Text = Color3.fromRGB(220, 255, 250),
        SubText = Color3.fromRGB(100, 160, 170), Accent = Color3.fromRGB(0, 255, 200), AccentText = Color3.fromRGB(0, 20, 18),
        Red = Color3.fromRGB(255, 60, 100), IsLight = false,
    },
    Sand = {
        Window = Color3.fromRGB(42, 36, 28), Sidebar = Color3.fromRGB(52, 44, 34), Titlebar = Color3.fromRGB(62, 52, 40),
        Card = Color3.fromRGB(58, 50, 38), Control = Color3.fromRGB(80, 68, 52), ControlHover = Color3.fromRGB(96, 82, 62),
        Popup = Color3.fromRGB(66, 56, 44), Segment = Color3.fromRGB(120, 100, 76), Track = Color3.fromRGB(98, 84, 64),
        SliderFill = Color3.fromRGB(255, 245, 230), Outline = Color3.fromRGB(86, 72, 56), Text = Color3.fromRGB(250, 242, 228),
        SubText = Color3.fromRGB(180, 160, 130), Accent = Color3.fromRGB(230, 180, 80), AccentText = Color3.fromRGB(40, 28, 10),
        Red = Color3.fromRGB(220, 90, 70), IsLight = false,
    },
    Arctic = {
        Window = Color3.fromRGB(232, 238, 244), Sidebar = Color3.fromRGB(220, 228, 236), Titlebar = Color3.fromRGB(210, 220, 230),
        Card = Color3.fromRGB(248, 250, 252), Control = Color3.fromRGB(220, 228, 236), ControlHover = Color3.fromRGB(200, 212, 224),
        Popup = Color3.fromRGB(255, 255, 255), Segment = Color3.fromRGB(255, 255, 255), Track = Color3.fromRGB(190, 202, 214),
        SliderFill = Color3.fromRGB(30, 120, 200), Outline = Color3.fromRGB(190, 200, 210), Text = Color3.fromRGB(28, 36, 48),
        SubText = Color3.fromRGB(100, 118, 136), Accent = Color3.fromRGB(30, 144, 220), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(220, 70, 70), IsLight = true,
    },
    Emerald = {
        Window = Color3.fromRGB(14, 28, 22), Sidebar = Color3.fromRGB(18, 36, 28), Titlebar = Color3.fromRGB(24, 44, 34),
        Card = Color3.fromRGB(22, 42, 32), Control = Color3.fromRGB(34, 62, 48), ControlHover = Color3.fromRGB(44, 78, 60),
        Popup = Color3.fromRGB(28, 50, 38), Segment = Color3.fromRGB(52, 96, 72), Track = Color3.fromRGB(42, 78, 58),
        SliderFill = Color3.fromRGB(200, 255, 220), Outline = Color3.fromRGB(36, 64, 48), Text = Color3.fromRGB(230, 255, 240),
        SubText = Color3.fromRGB(130, 180, 150), Accent = Color3.fromRGB(16, 185, 129), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(248, 113, 113), IsLight = false,
    },
    Crimson = {
        Window = Color3.fromRGB(28, 14, 16), Sidebar = Color3.fromRGB(36, 18, 20), Titlebar = Color3.fromRGB(46, 22, 26),
        Card = Color3.fromRGB(44, 20, 24), Control = Color3.fromRGB(68, 32, 38), ControlHover = Color3.fromRGB(86, 40, 48),
        Popup = Color3.fromRGB(52, 26, 30), Segment = Color3.fromRGB(110, 48, 58), Track = Color3.fromRGB(88, 40, 48),
        SliderFill = Color3.fromRGB(255, 220, 225), Outline = Color3.fromRGB(72, 34, 40), Text = Color3.fromRGB(255, 236, 238),
        SubText = Color3.fromRGB(190, 140, 148), Accent = Color3.fromRGB(239, 68, 68), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 100, 100), IsLight = false,
    },
    Sky = {
        Window = Color3.fromRGB(16, 24, 40), Sidebar = Color3.fromRGB(20, 32, 52), Titlebar = Color3.fromRGB(28, 42, 68),
        Card = Color3.fromRGB(26, 40, 64), Control = Color3.fromRGB(40, 60, 92), ControlHover = Color3.fromRGB(52, 76, 112),
        Popup = Color3.fromRGB(32, 48, 76), Segment = Color3.fromRGB(64, 96, 140), Track = Color3.fromRGB(50, 76, 112),
        SliderFill = Color3.fromRGB(220, 240, 255), Outline = Color3.fromRGB(44, 66, 100), Text = Color3.fromRGB(232, 244, 255),
        SubText = Color3.fromRGB(140, 170, 210), Accent = Color3.fromRGB(56, 189, 248), AccentText = Color3.fromRGB(10, 20, 40),
        Red = Color3.fromRGB(251, 113, 133), IsLight = false,
    },
    OLED = {
        Window = Color3.fromRGB(0, 0, 0), Sidebar = Color3.fromRGB(8, 8, 8), Titlebar = Color3.fromRGB(12, 12, 12),
        Card = Color3.fromRGB(14, 14, 14), Control = Color3.fromRGB(28, 28, 28), ControlHover = Color3.fromRGB(40, 40, 40),
        Popup = Color3.fromRGB(18, 18, 18), Segment = Color3.fromRGB(48, 48, 48), Track = Color3.fromRGB(36, 36, 36),
        SliderFill = Color3.fromRGB(240, 240, 240), Outline = Color3.fromRGB(32, 32, 32), Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(140, 140, 140), Accent = Color3.fromRGB(0, 255, 140), AccentText = Color3.fromRGB(0, 0, 0),
        Red = Color3.fromRGB(255, 60, 60), IsLight = false,
    },
    Catppuccin = {
        Window = Color3.fromRGB(30, 30, 46), Sidebar = Color3.fromRGB(24, 24, 37), Titlebar = Color3.fromRGB(49, 50, 68),
        Card = Color3.fromRGB(49, 50, 68), Control = Color3.fromRGB(69, 71, 90), ControlHover = Color3.fromRGB(88, 91, 112),
        Popup = Color3.fromRGB(49, 50, 68), Segment = Color3.fromRGB(108, 112, 134), Track = Color3.fromRGB(69, 71, 90),
        SliderFill = Color3.fromRGB(205, 214, 244), Outline = Color3.fromRGB(69, 71, 90), Text = Color3.fromRGB(205, 214, 244),
        SubText = Color3.fromRGB(166, 173, 200), Accent = Color3.fromRGB(203, 166, 247), AccentText = Color3.fromRGB(30, 30, 46),
        Red = Color3.fromRGB(243, 139, 168), IsLight = false,
    },
    Cream = {
        Window = Color3.fromRGB(250, 245, 235), Sidebar = Color3.fromRGB(242, 234, 220), Titlebar = Color3.fromRGB(235, 226, 210),
        Card = Color3.fromRGB(255, 252, 245), Control = Color3.fromRGB(235, 226, 210), ControlHover = Color3.fromRGB(220, 210, 190),
        Popup = Color3.fromRGB(255, 252, 245), Segment = Color3.fromRGB(255, 255, 255), Track = Color3.fromRGB(210, 198, 180),
        SliderFill = Color3.fromRGB(180, 120, 60), Outline = Color3.fromRGB(210, 198, 180), Text = Color3.fromRGB(50, 40, 30),
        SubText = Color3.fromRGB(120, 105, 90), Accent = Color3.fromRGB(200, 140, 70), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(200, 80, 70), IsLight = true,
    },
    -- Palette lifted from the Vitality reference: flat near-black panels, deep crimson accent
    Vitality = {
        Window = Color3.fromRGB(18, 18, 18), Sidebar = Color3.fromRGB(16, 16, 16), Titlebar = Color3.fromRGB(22, 22, 22),
        Card = Color3.fromRGB(23, 23, 23), Control = Color3.fromRGB(28, 28, 28), ControlHover = Color3.fromRGB(38, 38, 38),
        Popup = Color3.fromRGB(24, 24, 24), Segment = Color3.fromRGB(38, 38, 38), Track = Color3.fromRGB(35, 35, 35),
        SliderFill = Color3.fromRGB(181, 32, 55), Outline = Color3.fromRGB(43, 43, 43), Text = Color3.fromRGB(232, 232, 232),
        SubText = Color3.fromRGB(139, 139, 139), Accent = Color3.fromRGB(181, 32, 55), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 95, 87), IsLight = false,
    },
}

--// Library \\--
local Labels, Buttons, Toggles, Options = {}, {}, {}, {}

local Library = {
    Version = "1.0.0",
    AppName = "Evergreen",
    Themes = Themes,

    Labels = Labels,
    Buttons = Buttons,
    Toggles = Toggles,
    Options = Options,

    Toggled = false,
    Unloaded = false,
    GroupboxDragEnabled = true,

    IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
    IsPicking = false,
    CantDragForced = false,
    ForceCheckbox = false,

    Window = nil,
    ActiveTab = nil,
    Tabs = {},
    TabList = {},

    DependencyBoxes = {},
    Notifications = {},
    NotifySide = "Right",
    KeybindPickers = {},
    KeybindListEnabled = false,

    Searching = false,
    SearchText = "",

    ToggleKeybind = Enum.KeyCode.RightControl,
    CurrentPopup = nil,

    Signals = {},
    UnloadSignals = {},
    Registry = {},

    IconProvider = "lucide",
    IconFallback = "lucide",
    AppliedIcons = {},

    TweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    SlowTween = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    PopTween = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),

    Scheme = {
        Font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        FontBold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    },
}
for Key, Value in Themes.Dark do
    Library.Scheme[Key] = Value
end
Library.DPIScale = 1
Library.DPIScales = {} -- UIScale -> true (strong; cleaned on removal)
Library.Surfaces = {}  -- Frame -> { Base, Factor } for UI transparency
Library.UITransparency = 0
Library.BlurEnabled = false
Library.BlurSize = 16
Library.ThemeHooks = {}

local Templates = {
    Window = {
        Title = "Evergreen",
        Subtitle = nil,
        Footer = "",
        Icon = nil,

        Size = UDim2.fromOffset(780, 520),
        Position = UDim2.fromOffset(40, 40),
        MinSize = Vector2.new(600, 380),
        Center = true,
        AutoShow = true,
        Resizable = true,
        ShowTabTitle = true,
        CornerRadius = 12,

        SidebarWidth = 190,
        ShowUserChip = true,
        ShowTrafficLights = true,
        DisableSearch = false,

        NotifySide = "Right",
        ToggleKeybind = Enum.KeyCode.RightControl,
        UnlockMouseWhileOpen = true,
        ShowMobileButton = true,

        CloseUnloads = false,
        OnClose = nil,

        Theme = "Dark",
        Accent = nil,
        SearchStyle = 1, -- 1 = collapsible title-bar search, 2 = spotlight search
        Transparency = 0, -- 0 - 0.9 (also Library:SetTransparency)
        Blur = false,     -- blur the game behind the UI (also Library:SetBlur)
        BlurSize = 16,
        DPIScale = 100,
        Dock = true,      -- top-center button bar (true / false / table of CreateDock options)
        Glass = false,    -- frosted glass look (transparency + blur)
        Wallpaper = nil,  -- rbxassetid:// or image URL behind the window content
        WallpaperTransparency = 0.55,
    },
    Groupbox = { Side = 1, Name = "Groupbox", IconName = nil, Description = nil, Visible = true, Collapsed = false, DisableCollapsing = false },
    Tabbox = { Side = 1, Name = nil },
    Dialog = { Title = "Dialog", Description = "", Icon = nil, AutoDismiss = true, OutsideClickDismiss = false, FooterButtons = {}, Hidden = false },
    Toggle = { Text = "Toggle", Default = false, Callback = function() end, Changed = function() end, Risky = false, Disabled = false, Visible = true, Checkbox = false },
    Input = { Text = "Input", Default = "", AnimatePlaceholder = false, PlaceholderSpeed = 0.055, Finished = false, Numeric = false, ClearTextOnFocus = false, Placeholder = "", AllowEmpty = true, EmptyReset = "---", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Slider = { Text = "Slider", Default = 0, Min = 0, Max = 100, Rounding = 0, Prefix = "", Suffix = "", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    RangeSlider = { Text = "Range", Default = { 20, 80 }, Min = 0, Max = 100, Rounding = 0, Prefix = "", Suffix = "", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Dropdown = { Values = {}, DisabledValues = {}, Multi = false, MaxVisibleDropdownItems = 8, Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    List = { Text = "List", Values = {}, DisabledValues = {}, Multi = false, Height = 140, MaxVisibleItems = 6, AllowNull = true, Extended = false, Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Skeleton = { Rows = 3, Height = 18, Gap = 8, Visible = true },
    Image = { Image = "", Height = 160, Color = Color3.new(1, 1, 1), Transparency = 0, ScaleType = Enum.ScaleType.Fit, Visible = true },
    UIPassthrough = { Instance = nil, Height = 24, Visible = true },
    KeyPicker = { Text = "Keybind", Default = "None", Mode = "Toggle", Modes = { "Always", "Toggle", "Hold" }, SyncToggleState = false, Callback = function() end, ChangedCallback = function() end, Changed = function() end, Clicked = function() end },
    ColorPicker = { Default = Color3.new(1, 1, 1), Callback = function() end, Changed = function() end },
}

--// Basic helpers \\--
local function Tween(Object, Props, Info)
    local T = TweenService:Create(Object, Info or Library.TweenInfo, Props)
    T:Play()
    return T
end

local function Anim(Object, Props, Instant)
    if Instant then
        for K, V in Props do
            Object[K] = V
        end
    else
        Tween(Object, Props)
    end
end

local function StopTween(T)
    if T and T.PlaybackState == Enum.PlaybackState.Playing then
        T:Cancel()
    end
end

local function Trim(S) return (tostring(S):match("^%s*(.-)%s*$")) end
local function MousePos() return Vector2.new(Mouse.X, Mouse.Y) end

local function IsOver(Gui, Pos)
    if not Gui or not Gui.Parent then return false end
    local P, S = Gui.AbsolutePosition, Gui.AbsoluteSize
    return Pos.X >= P.X and Pos.X <= P.X + S.X and Pos.Y >= P.Y and Pos.Y <= P.Y + S.Y
end

local function IsShown(Gui)
    local Cur = Gui
    while Cur and typeof(Cur) == "Instance" do
        if Cur:IsA("GuiObject") and not Cur.Visible then return false end
        if Cur:IsA("ScreenGui") then return true end
        Cur = Cur.Parent
    end
    return Cur ~= nil
end

local function IsPress(Input)
    return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
end

local function IsArray(T)
    if typeof(T) ~= "table" then return false end
    local N = 0
    for _ in T do N += 1 end
    return N == #T
end

local function Round(Value, Rounding)
    if Rounding <= 0 then
        if Value >= 0 then return math.floor(Value + 0.5) end
        return math.ceil(Value - 0.5)
    end
    return tonumber(string.format("%." .. Rounding .. "f", Value))
end

local function Lighten(C, Amount)
    return Color3.new(math.clamp(C.R + Amount, 0, 1), math.clamp(C.G + Amount, 0, 1), math.clamp(C.B + Amount, 0, 1))
end

local function NormalizeSearch(S) return (tostring(S):lower():gsub("%s+", "")) end
local function Fuzzy(Text, Search)
    if typeof(Text) ~= "string" or Text == "" or Search == "" then return false end
    Text = NormalizeSearch(Text)
    Search = NormalizeSearch(Search)
    if Text:find(Search, 1, true) then return true end
    if #Search < 3 or #Search > #Text then return false end
    local I = 1
    for C = 1, #Text do
        if Text:sub(C, C) == Search:sub(I, I) then
            I += 1
            if I > #Search then return true end
        end
    end
    return false
end

function Library:Validate(Table, Template)
    if typeof(Table) ~= "table" then Table = {} end
    for K, V in Template do
        if Table[K] == nil then
            Table[K] = typeof(V) == "table" and table.clone(V) or V
        end
    end
    return Table
end

function Library:GiveSignal(Connection)
    if typeof(Connection) == "RBXScriptConnection" then
        table.insert(Library.Signals, Connection)
    end
    return Connection
end

function Library:OnUnload(Callback) table.insert(Library.UnloadSignals, Callback) end

function Library:SafeCallback(Func, ...)
    if typeof(Func) ~= "function" then return end
    local Result = table.pack(xpcall(Func, function(Err)
        task.defer(error, debug.traceback(tostring(Err), 2))
        return Err
    end, ...))
    if not Result[1] then return nil end
    return table.unpack(Result, 2, Result.n)
end

--// Instance creation + theme registry \\--
local Templ = {
    Frame = { BorderSizePixel = 0 },
    ImageLabel = { BackgroundTransparency = 1, BorderSizePixel = 0 },
    ImageButton = { AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0 },
    ScrollingFrame = { BorderSizePixel = 0, BackgroundTransparency = 1, ScrollBarThickness = 0, ScrollBarImageTransparency = 1 },
    TextLabel = { BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", RichText = true, TextColor3 = "Text", TextSize = 13 },
    TextButton = { AutoButtonColor = false, BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", RichText = true, TextColor3 = "Text", TextSize = 13, Text = "" },
    TextBox = { BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", TextColor3 = "Text", PlaceholderColor3 = "SubText", TextSize = 13, Text = "" },
}

local function Resolve(Prop, Value)
    if typeof(Value) == "string" and (Prop == "FontFace" or Prop:find("Color")) and Library.Scheme[Value] ~= nil then
        return Library.Scheme[Value], true
    elseif typeof(Value) == "function" then
        return Value(), true
    end
    return Value, false
end

local function Fill(Inst, Props)
    local Theme = Library.Registry[Inst] or {}
    for K, V in Props do
        if K ~= "Parent" then
            local RV, Themed = Resolve(K, V)
            Theme[K] = Themed and V or nil
            Inst[K] = RV
        end
    end
    if next(Theme) then Library.Registry[Inst] = Theme end
end

local function New(Class, Props)
    local Inst = Instance.new(Class)
    if Templ[Class] then Fill(Inst, Templ[Class]) end
    Fill(Inst, Props)
    if Props.Parent then Inst.Parent = Props.Parent end
    return Inst
end

local function Bind(Inst, Prop, Key)
    local T = Library.Registry[Inst]
    if not T then
        T = {}
        Library.Registry[Inst] = T
    end
    T[Prop] = Key
end

-- Corner / Stroke / List route through the skin so a skin swap can restyle live instances
local function Corner(Parent, R)
    local C = New("UICorner", { CornerRadius = UDim.new(0, Library.SkinRadius and Library:SkinRadius(R) or R), Parent = Parent })
    Library.Corners = Library.Corners or {}
    Library.Corners[C] = R
    return C
end
local function Stroke(Parent, Color, Thickness, Transparency)
    local Skin = Library.Skin
    local T = Thickness or 1
    if Skin and Skin.BorderThickness and T == 1 then T = Skin.BorderThickness end
    return New("UIStroke", {
        Color = Color or "Outline", Thickness = T, Transparency = Transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = Parent,
    })
end
local function Pad(Parent, T, R, B, L)
    return New("UIPadding", {
        PaddingTop = UDim.new(0, T or 0), PaddingRight = UDim.new(0, R or 0),
        PaddingBottom = UDim.new(0, B or 0), PaddingLeft = UDim.new(0, L or 0), Parent = Parent,
    })
end
local function List(Parent, Padding, Dir, HA, VA)
    local Base = Padding or 0
    local L = New("UIListLayout", {
        Padding = UDim.new(0, Library.SkinGap and Library:SkinGap(Base) or Base), FillDirection = Dir or Enum.FillDirection.Vertical,
        HorizontalAlignment = HA or Enum.HorizontalAlignment.Left, VerticalAlignment = VA or Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder, Parent = Parent,
    })
    Library.SkinLists = Library.SkinLists or {}
    Library.SkinLists[L] = Base
    return L
end
local function Flex(Parent) return New("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = Parent }) end

--// Gradients (re-evaluated whenever the theme changes) \--
Library.Gradients = {}
local function Two(Key, TopAdd, BottomAdd)
    return function()
        local C = Library.Scheme[Key]
        return ColorSequence.new(Lighten(C, TopAdd), Lighten(C, BottomAdd))
    end
end
-- Panel colors live in the gradient (white base * gradient), so a flat skin collapses
-- the ramp into one solid color taken from its midpoint instead of dropping it.
local function GradientMid(Seq)
    -- typeof(ColorSequence) is "ColorSequence" and typeof(Color3) is "Color3" on Roblox,
    -- so probe for Keypoints / Lerp instead of trusting the type name
    local KPs = Seq ~= nil and Seq.Keypoints
    if not (KPs and #KPs > 0) then return nil end
    local A, B = KPs[1].Value, KPs[#KPs].Value
    local Ok, Mid = pcall(function() return A:Lerp(B, 0.5) end)
    if Ok and typeof(Mid) == "Color3" then return Mid end
    if typeof(A) == "Color3" then return A end
    return nil
end
local function Grad(Inst, Fn, Rotation)
    local G = New("UIGradient", { Rotation = Rotation or 90, Parent = Inst })
    -- Re-evaluated on theme *and* skin changes: ramps collapse to a solid color on flat skins
    local function Auto()
        if Library.Skin and Library.Skin.Flat then
            local Ok, Seq = pcall(Fn)
            return ColorSequence.new((Ok and GradientMid(Seq)) or Color3.new(1, 1, 1))
        end
        return Fn()
    end
    G.Color = Auto()
    Library.Gradients[G] = Auto
    return G
end
function Library:UpdateGradients()
    for G, Fn in Library.Gradients do
        pcall(function() G.Color = Fn() end)
    end
end

local function ApplyThemedProps(Inst, Props)
    for Prop, Key in Props do
        local RV, Themed = Resolve(Prop, Key)
        if Themed then Inst[Prop] = RV end
    end
end
function Library:UpdateColorsUsingRegistry()
    for Inst, Props in Library.Registry do
        pcall(ApplyThemedProps, Inst, Props)
    end
end

--// Skin typefaces: a skin may swap the whole typography, themes only ever change colors
local function SkinFont(Spec, FallbackFace)
    if typeof(Spec) ~= "table" or typeof(Spec.Family) ~= "string" then return FallbackFace end
    local Ok, Face = pcall(function()
        local Weight = Enum.FontWeight[Spec.Weight or "Medium"]
        return Font.new(Spec.Family, Weight, Enum.FontStyle.Normal)
    end)
    return Ok and Face or FallbackFace
end

local defaultFonts = { Font = Library.Scheme.Font, FontBold = Library.Scheme.FontBold }

function Library:RefreshTheme()
    Library:UpdateColorsUsingRegistry()
    Library:UpdateGradients()
    for _, E in Toggles do if E.Display then pcall(E.Display, E, true) end end
    for _, E in Options do if E.Display then pcall(E.Display, E, true) end end
    for _, T in Library.TabList do pcall(T.RefreshStyle, T) end
    for _, Fn in Library.ThemeHooks do pcall(Fn) end
end

function Library:RegisterTheme(Name, Theme)
    Themes[Name] = Theme
end

-- SetTheme("Name") replaces the whole palette; SetTheme({ Accent = ... }) merges on top of the current one.
function Library:SetTheme(Theme)
    if typeof(Theme) == "string" then
        local Found = Themes[Theme]
        if not Found then return end
        if Library.ThemeExtraKeys then
            for K in Library.ThemeExtraKeys do
                if K ~= "Font" and K ~= "FontBold" then Library.Scheme[K] = nil end
            end
            Library.ThemeExtraKeys = nil
        end
        for K, V in Themes.Dark do Library.Scheme[K] = V end
        for K, V in Found do Library.Scheme[K] = V end
        for K in Found do
            if Themes.Dark[K] == nil and K ~= "Font" and K ~= "FontBold" then
                Library.ThemeExtraKeys = Library.ThemeExtraKeys or {}
                Library.ThemeExtraKeys[K] = true
            end
        end
        Library.ThemeName = Theme
        -- A theme picked by hand wins over the one a skin suggests
        if not Library.ApplyingSkin then Library.ThemePinned = true end
    elseif typeof(Theme) == "table" then
        for K, V in Theme do
            Library.Scheme[K] = V
            if Themes.Dark[K] == nil and K ~= "Font" and K ~= "FontBold" then
                Library.ThemeExtraKeys = Library.ThemeExtraKeys or {}
                Library.ThemeExtraKeys[K] = true
            end
        end
    else
        return
    end

    -- Skins own the typefaces; a theme swap only changes colors
    if Library.Skin and Library.Skin.Font then
        Library.Scheme.Font = SkinFont(Library.Skin.Font, defaultFonts.Font)
        Library.Scheme.FontBold = SkinFont(Library.Skin.BoldFont, defaultFonts.FontBold)
    end

    if Library.AccentOverride then
        Library.Scheme.Accent = Library.AccentOverride
        if Library.Scheme.IsLight then Library.Scheme.SliderFill = Library.AccentOverride end
    end
    Library:RefreshTheme()
end

function Library:SetAccent(Color)
    if typeof(Color) ~= "Color3" then return end
    Library.AccentOverride = Color
    Library.Scheme.Accent = Color
    if Library.Scheme.IsLight then Library.Scheme.SliderFill = Color end
    Library:RefreshTheme()
end

function Library:ResetAccent()
    Library.AccentOverride = nil
    Library:SetTheme(Library.ThemeName or "Dark")
end

function Library:SetFont(FontFace)
    if typeof(FontFace) == "EnumItem" then FontFace = Font.fromEnum(FontFace) end
    Library.Scheme.Font = FontFace
    Library:UpdateColorsUsingRegistry()
end

--// Skins \\--
-- A skin is the *design* layer: geometry, borders, decoration, type and chrome layout.
-- A theme is the *color* layer. Any skin works with any theme, and both can be swapped live.
--
-- Builders never read skin values directly from literals: they go through Skin.* helpers and the
-- Corner / Stroke / List / Grad wrappers below, which register every instance they style. That is
-- what lets SetSkin() restyle a window that is already on screen instead of rebuilding it.
local DefaultSkin = {
    Name = "Default",
    Font = nil,          -- nil = keep Library.Scheme.Font defaults
    BoldFont = nil,
    Square = false,      -- square off every radius below CornerKeep
    CornerKeep = 90,     -- radii at or above this are the "pill" radius below
    PillRadius = nil,    -- nil = keep pills round; a number squares them off
    RadiusScale = 1,     -- multiplier for the remaining radii
    BorderThickness = nil,
    GapScale = 1,        -- multiplier for UIListLayout padding
    Scrollbar = nil,     -- { Thickness = 2, Color = "Accent", Transparency = 0 } to show thin scrollbars
    Flat = false,        -- drop decorative panel gradients

    Titlebar = { Height = 40, Align = "Center", Icon = nil, TrafficLights = true, SidebarButton = true, UppercaseTitle = false },
    Tabs = { Style = "Sidebar", Height = 30, Gap = 2, Pad = 10, ActiveStyle = "Fill", Icons = true, Separator = false },
    Content = { ShowHeader = true, HeaderHeight = 54, PadX = 16 },
    Groupbox = { HeaderHeight = 36, HeaderSize = 13, Icon = true, Gap = 10, Pad = 12 },
    Toggle = { Style = "Switch", BoxSize = 18, CheckGlyph = true },
    Slider = { TrackHeight = 12, Knob = true, Area = 30, Square = false },
    Button = { Flat = false },
    Dropdown = { Chevron = nil, Height = 28 },
    Keybind = { Title = "Keybinds", Accent = false },
}

local VitalitySkin = {
    Name = "Vitality",
    DefaultTheme = "Vitality",
    Font = { Family = "rbxasset://fonts/families/RobotoMono.json", Weight = "Medium" },
    BoldFont = { Family = "rbxasset://fonts/families/RobotoMono.json", Weight = "Bold" },
    Square = true,
    CornerKeep = 90,
    PillRadius = 3,
    RadiusScale = 0,
    BorderThickness = 1,
    GapScale = 0.82,
    Flat = true,
    Scrollbar = { Thickness = 2, Color = "Accent", Transparency = 0 },

    Titlebar = { Height = 42, Align = "Left", Icon = "activity", TrafficLights = false, SidebarButton = true, UppercaseTitle = false },
    -- Navigation stays in the usual sidebar: squared rows, flat crimson fill on the active tab
    Tabs = { Style = "Sidebar", Height = 32, Gap = 2, Pad = 10, ActiveStyle = "Fill", Icons = true, Separator = false, Uppercase = false },
    Content = { ShowHeader = false, HeaderHeight = 0, PadX = 14 },
    Groupbox = { HeaderHeight = 34, HeaderSize = 13, Icon = true, Gap = 10, Pad = 12 },
    Toggle = { Style = "Box", BoxSize = 16, CheckGlyph = false },
    Slider = { TrackHeight = 8, Knob = false, Area = 22, Square = true },
    Button = { Flat = true },
    Dropdown = { Chevron = "▼", Height = 30 },
    Keybind = { Title = "Keybind List", Accent = true },
}

local Skins = { Default = DefaultSkin, Vitality = VitalitySkin }
Library.Skins = Skins
Library.Skin = DefaultSkin
Library.SkinName = "Default"

-- Deep-copies a skin spec over a base, so specs can be partial
local function MergeSkin(Base, Over)
    local Out = {}
    for Key, Value in Base do
        Out[Key] = typeof(Value) == "table" and MergeSkin(Value, {}) or Value
    end
    for Key, Value in Over do
        if typeof(Value) == "table" and typeof(Out[Key]) == "table" then
            Out[Key] = MergeSkin(Out[Key], Value)
        else
            Out[Key] = Value
        end
    end
    return Out
end

-- Every styled instance is remembered so a skin swap can restyle it in place
Library.Corners = {}
Library.SkinStrokes = {}
Library.SkinLists = {}
Library.SkinGradients = {}
Library.SkinHooks = {}

-- Resolves a corner radius through the active skin
function Library:SkinRadius(R)
    local Skin = Library.Skin or DefaultSkin
    if R == nil then return 0 end
    if R >= (Skin.CornerKeep or 90) then
        if Skin.PillRadius ~= nil then return Skin.PillRadius end
        return R
    end
    if Skin.Square then return 0 end
    if (Skin.RadiusScale or 1) == 1 then return R end
    return math.floor(R * Skin.RadiusScale + 0.5)
end

function Library:SkinGap(Gap)
    local Skin = Library.Skin or DefaultSkin
    return math.max(0, math.floor((Gap or 0) * (Skin.GapScale or 1) + 0.5))
end

-- Some skins show a thin colored scrollbar instead of hiding it entirely
function Library:SkinScrollbar(Scroll)
    local Bar = (Library.Skin or DefaultSkin).Scrollbar
    if typeof(Scroll) ~= "Instance" or not Scroll:IsA("ScrollingFrame") then return end
    if not Bar then
        Scroll.ScrollBarThickness = 0
        Scroll.ScrollBarImageTransparency = 1
        return
    end
    Scroll.ScrollBarThickness = Bar.Thickness or 2
    Scroll.ScrollBarImageTransparency = Bar.Transparency or 0
    local Color = Library.Scheme[Bar.Color or "Accent"]
    if typeof(Color) == "Color3" then Scroll.ScrollBarImageColor3 = Color end
end

function Library:ApplySkinScrollbars()
    local Bar = (Library.Skin or DefaultSkin).Scrollbar
    if not Library.ScreenGui then return 0 end
    local Count = 0
    for _, Inst in Library.ScreenGui:GetDescendants() do
        if Inst:IsA("ScrollingFrame") then
            Library:SkinScrollbar(Inst)
            Count += 1
        end
    end
    return Count
end

-- Re-applies every registered corner / gap after a skin change
function Library:ApplySkinGeometry()
    for Corner_, Base in Library.Corners do
        pcall(function() Corner_.CornerRadius = UDim.new(0, Library:SkinRadius(Base)) end)
    end
    for Layout_, Base in Library.SkinLists do
        pcall(function() Layout_.Padding = UDim.new(0, Library:SkinGap(Base)) end)
    end
end

function Library:GetSkin(): string
    return Library.SkinName or "Default"
end

function Library:GetSkins(): { string }
    local Names = {}
    for Name in Skins do table.insert(Names, Name) end
    table.sort(Names)
    return Names
end

function Library:GetSkinSpec(Name): any
    return Skins[Name or Library.SkinName or "Default"]
end

-- Library:SetSkin("Vitality")  -- design only; colors keep coming from the current theme
function Library:SetSkin(Name, Silent)
    if typeof(Name) ~= "string" or not Skins[Name] then Name = "Default" end
    local Spec = MergeSkin(DefaultSkin, Skins[Name])

    Library.SkinName = Name
    Library.Skin = Spec

    --// Type
    local FontFace, BoldFace = Spec.Font, Spec.BoldFont
    if FontFace or BoldFace then
        Library.Scheme.Font = SkinFont(FontFace, defaultFonts.Font)
        Library.Scheme.FontBold = SkinFont(BoldFace, defaultFonts.FontBold)
    else
        Library.Scheme.Font = defaultFonts.Font
        Library.Scheme.FontBold = defaultFonts.FontBold
    end

    --// Theme suggested by the skin (only when the user has not pinned one)
    if not Silent and Spec.DefaultTheme and Skins[Name] and not Library.ThemePinned then
        Library.ApplyingSkin = true
        Library:SetTheme(Spec.DefaultTheme)
        Library.ApplyingSkin = false
        Library.Scheme.Font = SkinFont(FontFace, defaultFonts.Font)
        Library.Scheme.FontBold = SkinFont(BoldFace, defaultFonts.FontBold)
    end

    Library:ApplySkinGeometry()
    Library:UpdateColorsUsingRegistry()
    Library:UpdateGradients()
    Library:ApplySkinScrollbars()

    if Library.Window and Library.Window.ApplySkin then pcall(Library.Window.ApplySkin, Library.Window) end
    for _, Tab in Library.Tabs do
        if typeof(Tab) == "table" and Tab.ApplySkin then pcall(Tab.ApplySkin, Tab) end
    end
    for _, Box in Library.DependencyBoxes do
        if typeof(Box) == "table" and Box.ApplySkin then pcall(Box.ApplySkin, Box) end
    end
    -- controls that rebuild or resize themselves (toggles, sliders, groupbox headers)
    for _, List_ in { Library.Toggles, Library.Options, Library.Labels, Library.Buttons } do
        for _, El in List_ do
            if typeof(El) == "table" and not El.Destroyed and El.ApplySkin then pcall(El.ApplySkin, El) end
        end
    end
    for _, Hook in Library.SkinHooks do
        pcall(Hook, Name)
    end

    local DD = Options and Options.EvergreenSkin
    if DD and typeof(DD.SetValue) == "function" and not Library.SyncingSkin then
        Library.SyncingSkin = true
        pcall(DD.SetValue, DD, Name)
        Library.SyncingSkin = false
    end

    return true
end

-- Small helpers used by builders
function Library:IsFlatSkin() return (Library.Skin or DefaultSkin).Flat == true end
function Library:SkinTabs() return (Library.Skin or DefaultSkin).Tabs or DefaultSkin.Tabs end
function Library:SkinTitlebar() return (Library.Skin or DefaultSkin).Titlebar or DefaultSkin.Titlebar end
function Library:SkinGroupbox() return (Library.Skin or DefaultSkin).Groupbox or DefaultSkin.Groupbox end
function Library:SkinToggle() return (Library.Skin or DefaultSkin).Toggle or DefaultSkin.Toggle end
function Library:SkinSlider() return (Library.Skin or DefaultSkin).Slider or DefaultSkin.Slider end

--// Icons \\--
-- Backend: the Molto icon registry (vendored below — original module, plus a sprite-only accessor).
-- It bundles seven packs (lucide, tabler, heroicons, solar, material, fluent, phosphor) and caches
-- each pack's sprite sheets on disk. Icons still reach the UI as ImageLabels (Url + ImageRect*), so
-- every ImageLabel / Glyph call site keeps working untouched.
--
-- Lucide is the fallback pack: a name the active pack is missing is looked up in Lucide before
-- anything gives up. If the registry cannot run at all (no file access and no HTTP), the pinned
-- lucide-roblox-direct module is loaded as a last-resort backend.
--
--   Library:SetIconProvider("phosphor")  -- switch pack (repaints every icon already on screen)
--   Library:GetIconProvider()            -- "lucide"
--   Library:GetIconProviders()           -- { "fluent", "heroicons", ... }
--   Library:GetIconProviderValues()      -- dropdown-ready { { "Lucide (1962)", "lucide" }, ... }
--   Library:HasIcon("user")              -- boolean
--   Library:PreloadIcons("tabler")       -- warm a pack up front so lookups never yield
--   Library:SetIconFallback("lucide")    -- nil / false disables the fallback lookup
--   Library:RefreshIcons()               -- re-apply every tracked icon with the current pack
local MoltoIcons = nil
do
    local Ok, Result = pcall(function()
        local Registry = {}

        --// Helpers \\--
        local function Check(...)
            for index = 1, select("#", ...) do
                if typeof((select(index, ...))) ~= "function" then return false end
            end
            return true
        end

        local AssetManager = {}
        do
            local BASE_PATH = "molto-icons"

            AssetManager.Supported = Check(isfile, isfolder, makefolder, readfile, writefile, getcustomasset)
            AssetManager.CanDelete = AssetManager.Supported and Check(listfiles, delfolder)

            function AssetManager.Path(relative: string?): string
                return if relative then `{BASE_PATH}/{relative}` else BASE_PATH
            end

            function AssetManager.EnsureFolder(relative: string?)
                local current = ""
                for _, part in string.split(AssetManager.Path(relative), "/") do
                    current = if current == "" then part else `{current}/{part}`
                    if not isfolder(current) then
                        makefolder(current)
                    end
                end
            end

            function AssetManager.IsFile(relative: string): boolean
                local success, result = pcall(isfile, AssetManager.Path(relative))
                return success and result == true
            end

            function AssetManager.Read(relative: string): string?
                return if AssetManager.IsFile(relative) then readfile(AssetManager.Path(relative)) else nil
            end

            function AssetManager.Write(relative: string, data: string)
                writefile(AssetManager.Path(relative), data)
            end

            function AssetManager.Download(relative: string, url: string, validate: ((string) -> boolean)?)
                if AssetManager.IsFile(relative) then return end

                local data = game:HttpGet(url)
                assert(not validate or validate(data), `Invalid download for {relative}`)
                AssetManager.Write(relative, data)
            end

            function AssetManager.ListNames(): { string }
                local names = {}
                for _, entry in listfiles(BASE_PATH) do
                    local name = entry:gsub("\\", "/"):gsub("/$", ""):match("([^/]+)$")
                    if name then
                        table.insert(names, name)
                    end
                end
                return names
            end

            function AssetManager.GetAsset(relative: string): string
                return getcustomasset(AssetManager.Path(relative))
            end
        end

        --// Constants \\--
        local ASSET_BASE_URL = "https://molto.pages.dev/"
        local DEFAULT_PROVIDER = "lucide"
        local PROVIDERS = {lucide={Hash="d696c1613123ecf29dd415cafa9c1c4cfe753307ed88439c7c02e2bf765c75d4",FontSources={"4ebe99c5ae25efcc41662dc5ab6eaba4e593bb8a5553b88beb21214834291fdd","cf5cfeeb5d34dc869e14028d7b3b29890a3210a2e180c3b68bc35f1c68ab2447"},Font=true,Count=1962,SourceHash="423a40bf7c8261df0f4488795f29363459e0d983f7a472a56361a0ca732cb06b",Sheets=2,License="ISC",Name="Lucide",FontParts=2},tabler={Hash="e5e6ef7cc035c9828b5cddf5280412d3081277c7e2550b9ae09e7afad487c846",FontSources={"cc7965bfb2aaf7f3d7f8d0588d5eddefebbbed8b30a59b4b077d5b9f8adf891f","5cee0c3b5b0b34409d30f4a3f9b2f62e22b608c9b6794dff1974c0bc22c69201","91b40bd91bfeca8e50e0cbe4564dc54fc37d18ff81cb9827119bf41f212aa649","ded3bb4c65fe91d7538025ee7a66f156fbf87daadb118f9fadbfdac0663a51ce","e1531143a79337f8b92379276bbbc7dc79a44b69cc5684701432d186e75758c5"},Font=true,Count=6286,SourceHash="c4ac52a2a33e7c753fd0d132626ea18e96e99fd62beaebf9249932767e4f31eb",Sheets=4,License="MIT",Name="Tabler",FontParts=5},heroicons={Hash="da3ef30e5bda1a0cf6586a6de9789a12537d550aec9598eccc85b4326be76615",FontSources={"da02a3a8e3f2b01840e735d0025f9c898a597fa3f22802b8cf61fba7ca4dd065","1a0ce866418752177d2393a48aede97f27ba5c52239eab5e3b7a9b0de15e6c44"},Font=true,Count=1288,SourceHash="6439652a852d969b2916cffd09efb0ab9a6f2127b7b7692b7b0e48315b4b8029",Sheets=1,License="MIT",Name="Heroicons",FontParts=2},solar={Hash="01d27f4a6f5ef2740f7080fb66f89fdaca0682cff34776dd71342aed31c4788b",FontSources={"0fbc79d272ced0ecc7e9b4357c8d89c5fc58681d491c9af67cb7c16aa98db15d","c60573fba17a7a8493d8385cd2f63f5c6c2509b780a93ae358d42fdc4d724c42","9b645fa22ab9a6f9ff56f7bba9fcde3d6a9b85d09ccbd71a95e31914c636a51d","95f3976e92db9a2478efcc5629b8aec2693e33b17276ce8aa068055a1f33a08b","e12f62e3ef20c62d3a7735e915199dbc3baffbdb958c09ab24bfb1d04177ec2d","414dd9aa75fbfc2005138857544df5febe4a55e5b670d2303f2034f27e701426"},Font=true,Name="Solar",SourceHash="bc5184a9d553589aad59d3375558bd13e4af5bb176dea7c89a164eabf9ee28c7",Sheets=6,License="CC BY 4.0",Count=8859,FontParts=6},material={Hash="6d11d395dda424ae2d8253513ff7317b8fc0f4a0ada0456d607e59f13ab762ea",FontSources={"a6c3b947bc82401b8fb6c7fb8b37cae4efbdbaa7e3b0ea5ee2654ae9f318e3e4","7a7ca51f6604403d8a6f7e20d2625b80aeb9ffecb398775762a24e22c0f470b0","a1ef7a9bf6412ef4532c9eb14284b3046051fcb1b6a65015f1a61d6b692c0f53","e8d6e6babc6a12e7a0d703e5df813b1f3a965359af60e3a8b3673b3289b08f77","acb95b43b3d2b2a0276449de286742820855cacd790c55d81f878e961e35ec81","cfc9890dcf418bcbdcdb7ee3ffc194d21f8a82a648bbec0e19bbffde1740e075","8678c8a58f00204f31e5b39aada3a5bc3aa7c70680c2752c7b328fac72e28d56","dcddc643c20abafef86ff881df4431426570bec2b4d1ec07e9e6df482651104a","29ee2e12f047d3241c81cbf805678ef3e81ab0da562ea43a8d9c57ed9488375b","34c129915b924951d6a63961ee2a0a4df1fa4973b8dbb0f1b514b29db19b8410","736463c4cb2de1dfdb87191833fc9b0bb607c3afcfa8183e886d44a3bf91e445","00d98ed7e153a244c0099221af02796c48ecef42daaa02e5fc602ee1ab439826","74a8f8daf6a161836d72107ee02e942474817440794f3187832dd1450a006862","91d06a7f5b083e2fa865bff7c4742ba1f6f27c415a3462482b783916e0ab911a","4e942f188ad52e90818fc3bf37a28ef188621f546d975d1e537207326a9f7a3b","198f0878e3a7d4a0f6e16c1a754a6db440aeb6d3302d8a6131d5ca80cc81e2a8","2b8e4080a3cff6c658c825c0f283bca3ae51192f6370381ccee8d0c33ece58e3"},Font=true,Name="Material Symbols",SourceHash="83cdd5e4fbc8e9a6bf8b78864b81f967985bf2d6ff0fae751ea474af0193d84a",Sheets=11,License="Apache 2.0",Count=16442,FontParts=17},fluent={Hash="eea2ac0ea41cbaeaa955ffc63a8c19228eb254d1436c9537570627f000780f98",FontSources={"0ca2ebc12344dfc21b2a0c6d2cd967adff5437de09c2843f165fc0ea715b735e","c025ee859ab9b30623da15c41bdc54453d7ca28b3b7512ccbfee87da8a5e231c","81ec0aec30f4d22a749352e93543167320ed88a6f5c51aee63f31fc6ef42b4a2","08c2d11f4e3c3cf9c89a4c70dd3e1774a8590d9530836a03880025ddca5a3867","ec03717283f571d664222c4ac9ddd8cdc7378113e32b3ea9c3455e75fc59aada","5877c0d62d3b88e05847d6caa50b8ea228d27f66df3e15dfd7e4ada1b3f86a7e","6882f8421b1870a7ad7bd98ba933c950c9021d5975a291b6c5ded9a1c1eb3aae","0b6d115f0496bb0737ebd3092b0d6a77b0e1c8309824f36b44aaedfabad84d14","3b0484af44ee884f75040e964703fb659e14fead7be5eca80e9baed6eee5b09a","459b54e519f643aac8b4febc20ebce816f51299ea8b59ed881efdda46f97b8cf","b5b95e254ef47aacce39eccd3886587d050f1a9c103513516a775bc6112e4f93","12c77501f8279630483ec7fda5cbaedf23147b42ac89e70563f8b8dcf54f6900","2b33de99ad42aeaaa60414fd699fa6117683524760bb14b86d982c7bf0fa0f77","a0815cc57d498fb4dad8ad04a5164f1767c18aa96cdf864f31a6fba6ec29f0ab","b9708402b5a529863a263341478fd44ae6f362f2320bacf5118cda474bac1fcb","68b9dbded5d541c81943a74d381ae69516d02aa7f07ed0c3ab519f0c59a099f2","4685a4902150718823b10d7b0c442628dc79b78a648b6800e4dc581704cc7b67","03a38183356a4c6c15071c7ae71779146aa4fc6d6e47f3af6ae9ddd0582d3ad9","d4cf604e15f3c7e1e8bd65ef36f3342403eeea8f7773d79eceb116188507dc39","a80c414eb482bbad39463586ecb021f49fe1285072e5336a360786c6b3ea3e57","0b537ae8676593b0b991b9df6c76c69fe76a8e116a0193e335ae8346b67562f2","c4977f667b3efa70906ea3bc4e183a95a5e248f9e030fac10b07f608d45047b2","40a771f73627c5fd8093fc2d8b79819cf2aafa0fa48fa313460272dbdf5fcf55","c7f4bc777ac1aa70c54070b3b62e7d665b89a9e421346a285fca34be0704bbd7","5638ab3b76ca1af8584e592c5eb977b6ae331801f0078de546f8167999ef3231"},Font=true,Count=20289,SourceHash="7bf2c2d522bf7bf203a61b82b402f36b4ec6fbde41876b299d98b116c982125b",Sheets=13,License="MIT",Name="Fluent UI",FontParts=25},phosphor={Hash="3a5e9b8ed33e68efb30de3f96814cb55320b7d7579fa375e29cf2f9fcea4d371",FontSources={"e8c24227843917e3fc9290d8bf203705de7f4a59485d07f9401cea9d4fc3d1c9","616bc7cf12efd96cffe2ea91298d2a928e6e0a508a233ec887c97cbc9c4395bb","53f51b226944327ba01306717fe829cec5d638f4d1179b4f121af355330399d7","a4d996e7818c0514d1d1f5f068b33de5667c7c735b88414276686b29128cc829","a2c1f74720b1a04cb699b54cb3938fc81643bb7d036147753ea130ea70019bb4","32b4ec07d36dee3d04585246dbb3c82f3c178a1229cc6179827ca15fe3922776","e5c39571e65797199d631dd71df13f9ac935c784eb7f3c2abd8f3d0f58c2ff75"},Font=true,Count=9161,SourceHash="841b552595d27509a630dadd2bc5a04fc0b30e724e3b42f6f2807ef7628fd415",Sheets=6,License="MIT",Name="Phosphor",FontParts=7}}

        local MAX_ALIAS_DEPTH = 8
        local PRELOAD_WORKERS = 6

        --// Providers \\--
        type ProviderState = {
            Id: string,
            Icons: { string },
            Aliases: { [string]: string },
            Rects: { { any } },
            NoFont: { [string]: boolean },
            Index: { [string]: number },
            SheetUrls: { [number]: string },
            Folder: string,
            FontParts: number?,
            FontName: string,
            Fonts: { [number]: Font | false },
        }

        local loadedProviders: { [string]: ProviderState } = {}
        local currentProvider = DEFAULT_PROVIDER

        -- Keeps only the newest build of a provider on disk
        local function PruneCache(id: string, currentFolder: string)
            if not AssetManager.CanDelete then return end

            for _, name in AssetManager.ListNames() do
                local hash = if name:sub(1, #id + 1) == `{id}-` then name:sub(#id + 2) else nil
                if hash and name ~= currentFolder and hash:match("^" .. string.rep("%x", 64) .. "$") then
                    pcall(delfolder, AssetManager.Path(name))
                end
            end
        end

        local function LoadProvider(id: string): ProviderState
            local loaded = loadedProviders[id]
            if loaded then return loaded end

            local meta = PROVIDERS[id]
            assert(meta, `Unknown icon provider "{id}"`)

            local folder = `{id}-{meta.Hash}`
            local dataFile = `{folder}/data.lua`
            local dataUrl = `{ASSET_BASE_URL}providers/{id}.lua`

            local useCustomSprites = false
            local source: string? = nil

            if AssetManager.Supported then
                useCustomSprites = pcall(function()
                    AssetManager.EnsureFolder(folder)
                    for sheet = 1, meta.Sheets do
                        AssetManager.Download(`{folder}/{sheet}.png`, `{ASSET_BASE_URL}spritesheets/{id}/{sheet}.png`, function(data)
                            return data:sub(1, 8) == "\137PNG\r\n\26\n" -- PNG header
                        end)
                    end
                    AssetManager.GetAsset(`{folder}/1.png`)
                end)

                pcall(function()
                    AssetManager.EnsureFolder(folder)
                    AssetManager.Download(dataFile, dataUrl, function(data)
                        return data:sub(1, 6) == "return"
                    end)
                    source = AssetManager.Read(dataFile)
                end)

                if useCustomSprites then
                    pcall(PruneCache, id, folder)
                end
            end

            local data = loadstring(source or game:HttpGet(dataUrl))()

            local sheetUrls = {}
            for sheet, fallback in data.Sheets do
                sheetUrls[sheet] = if useCustomSprites then AssetManager.GetAsset(`{folder}/{sheet}.png`) else fallback
            end

            local index = {}
            for position, name in data.Icons do
                index[name] = position
            end

            -- Icons with see-through layers cannot be drawn by a one color font, so they only exist as sprites
            local noFont = {}
            for _, name in data.NoFont or {} do
                noFont[name] = true
            end

            local state: ProviderState = {
                Id = id,
                Icons = data.Icons,
                Aliases = data.Aliases,
                Rects = data.Rects,
                NoFont = noFont,
                Index = index,
                SheetUrls = sheetUrls,
                Folder = folder,
                FontParts = if meta.Font then meta.FontParts else nil,
                FontName = meta.Name,
                Fonts = {},
            }

            loadedProviders[id] = state
            return state
        end

        -- Must match FontPartOf in scripts/build.luau
        local function FontPartOf(name: string, parts: number): number
            local hash = 7
            for index = 1, #name do
                hash = (hash * 131 + string.byte(name, index)) % 2147483629
            end
            return hash % parts + 1
        end

        -- Roblox does not shape a ligature whose text starts with a digit, so the font stores those icons with a letter prefix.
        -- Must match LigatureOf in scripts/build.luau
        local function LigatureOf(name: string): string
            return if name:match("^%d") then `x-{name}` else name
        end

        -- Big sets are split into several fonts, so a font is downloaded when its first icon is looked up
        local function GetFontFace(state: ProviderState, part: number): Font?
            local cached = state.Fonts[part]
            if cached ~= nil then return cached or nil end

            local face: Font? = nil
            if AssetManager.Supported then
                pcall(function()
                    local ttfFile = `{state.Folder}/font-{part}.ttf`
                    local familyFile = `{state.Folder}/font-{part}.json`

                    AssetManager.EnsureFolder(state.Folder)
                    AssetManager.Download(ttfFile, `{ASSET_BASE_URL}fonts/{state.Id}/{state.Id}-{part}.ttf`, function(data)
                        return data:sub(1, 4) == "\0\1\0\0" -- TrueType header
                    end)
                    AssetManager.Write(familyFile, game:GetService("HttpService"):JSONEncode({
                        name = `{state.FontName} {part}`,
                        loadStrategy = "sameFamilyOnly",
                        faces = {
                            { name = "Regular", weight = 400, style = "normal", assetId = AssetManager.GetAsset(ttfFile) },
                        },
                    }))

                    face = Font.new(AssetManager.GetAsset(familyFile))
                end)
            end

            state.Fonts[part] = face or false
            return face
        end

        --// API \\--
        Registry.Providers = {}
        for id in PROVIDERS do
            table.insert(Registry.Providers, id)
        end
        table.sort(Registry.Providers)

        function Registry.GetProviderInfo(id: string?)
            local meta = PROVIDERS[id or currentProvider]
            if not meta then return nil end

            return { Id = id or currentProvider, Name = meta.Name, License = meta.License, Count = meta.Count }
        end

        function Registry.GetProvider(): string
            return currentProvider
        end

        function Registry.SetProvider(id: string)
            assert(PROVIDERS[id], `Unknown icon provider "{id}"`)

            LoadProvider(id)
            currentProvider = id
        end

        function Registry.GetIcons(provider: string?): { string }
            return LoadProvider(provider or currentProvider).Icons
        end

        function Registry.HasIcon(name: string, provider: string?): boolean
            return Registry.GetSprite(name, provider) ~= nil
        end

        local function ResolveAlias(state: ProviderState, name: string): string
            local resolved = name
            for _ = 1, MAX_ALIAS_DEPTH do
                local target = state.Aliases[resolved]
                if not target then break end
                resolved = target
            end
            return resolved
        end

        -- Downloads everything up front so GetAsset never yields. Without names it fetches every font part of the provider.
        -- Returns the number of font parts that are ready
        function Registry.PreloadAsync(names: { string }?, provider: string?): number
            local state = LoadProvider(provider or currentProvider)
            if not state.FontParts then return 0 end

            local seen: { [number]: boolean } = {}
            local queue: { number } = {}
            local function Add(part: number)
                if not seen[part] then
                    seen[part] = true
                    table.insert(queue, part)
                end
            end

            if names then
                for _, name in names do
                    local resolved = ResolveAlias(state, name)
                    if state.Index[resolved] and not state.NoFont[resolved] then
                        Add(FontPartOf(resolved, state.FontParts))
                    end
                end
            else
                for part = 1, state.FontParts do
                    Add(part)
                end
            end

            local ready = 0
            local function Work()
                while true do
                    local part = table.remove(queue)
                    if not part then return end
                    if GetFontFace(state, part) then
                        ready += 1
                    end
                end
            end

            -- Several parts download at once, the rest of the queue is picked up as workers finish
            local workers = math.min(PRELOAD_WORKERS, #queue)
            if typeof(task) ~= "table" or workers <= 1 then
                Work()
                return ready
            end

            local running = workers
            for _ = 1, workers do
                task.spawn(function()
                    pcall(Work)
                    running -= 1
                end)
            end
            while running > 0 do
                task.wait()
            end
            return ready
        end

        -- Sprite data only: no fonts are downloaded, which keeps image based UI (ImageLabel) fast to build
        function Registry.GetSprite(name: string, provider: string?)
            local state = LoadProvider(provider or currentProvider)

            local resolved = ResolveAlias(state, name)

            local position = state.Index[resolved]
            if not position then
                return nil
            end

            local rect = state.Rects[position]

            return {
                IconName = name,
                Resolved = resolved,
                Provider = state.Id,
                Url = state.SheetUrls[rect[1]],
                ImageRectSize = Vector2.new(rect[2][1], rect[2][2]),
                ImageRectOffset = Vector2.new(rect[3][1], rect[3][2]),
            }
        end

        function Registry.GetAsset(name: string, provider: string?)
            local sprite = Registry.GetSprite(name, provider)
            if not sprite then return nil end

            local state = LoadProvider(provider or currentProvider)
            local fontPart = if state.FontParts and not state.NoFont[sprite.Resolved] then FontPartOf(sprite.Resolved, state.FontParts) else nil
            local fontFace = if fontPart then GetFontFace(state, fontPart) else nil

            -- Only present when the provider font loaded. The font shapes Text into one icon through a ligature
            sprite.FontFace = fontFace
            sprite.FontPart = fontPart
            sprite.Text = if fontFace then LigatureOf(sprite.Resolved) else nil
            return sprite
        end

        return Registry
    end)

    if Ok and typeof(Result) == "table" then
        MoltoIcons = Result
    else
        pcall(warn, "[Evergreen] icon registry unavailable, using the legacy lucide backend: " .. tostring(Result))
    end
end

--// Legacy lucide-roblox-direct backend (last resort, only touched when the registry is unusable) \\--
local LEGACY_ICON_URL = "https://raw.githubusercontent.com/mstudio45/lucide-roblox-direct/47bd6483938bd093f942e7494f315c4bb08939d3/source.lua"
local LEGACY_ICON_CACHE = "evergreen_lucide_cache.lua"

local LegacyState = { Module = nil, Tried = false }
local IconCache = {}
local FailedPacks = {} -- pack id -> error, so one dead pack can't take the fallback down with it

Library.AppliedIcons = {}     -- ImageLabel/TextLabel -> icon name, repainted when the pack changes
Library.IconFallback = "lucide" -- any icon the active pack is missing is looked up here first
Library.IconBackendError = nil  -- set when the registry throws, so lookups can drop to the legacy backend

do
    local Default = "lucide"
    if MoltoIcons then
        local Ok, Id = pcall(MoltoIcons.GetProvider)
        if Ok and typeof(Id) == "string" then Default = Id end
    end
    Library.IconProvider = Default
end

local function KnownProvider(Id)
    if typeof(Id) ~= "string" then return false end
    if not MoltoIcons then return Id == "lucide" end
    local List = MoltoIcons.Providers
    if typeof(List) ~= "table" then return true end
    return table.find(List, Id) ~= nil
end

local function MoltoIcon(Name, Provider)
    if not MoltoIcons or not KnownProvider(Provider) or FailedPacks[Provider] then return nil end

    local Ok, Data = pcall(MoltoIcons.GetSprite, Name, Provider)
    if not Ok then
        FailedPacks[Provider] = tostring(Data)
        Library.IconBackendError = tostring(Data)
        return nil
    end
    if typeof(Data) ~= "table" then return nil end

    return {
        Name = Name,
        Provider = Data.Provider or Provider,
        Url = Data.Url,
        ImageRectOffset = Data.ImageRectOffset or Vector2.zero,
        ImageRectSize = Data.ImageRectSize or Vector2.zero,
    }
end

local function LegacyModule()
    if LegacyState.Tried then return LegacyState.Module end
    LegacyState.Tried = true

    pcall(function()
        if readfile and isfile and isfile(LEGACY_ICON_CACHE) then
            local Ok, Src = pcall(readfile, LEGACY_ICON_CACHE)
            if Ok and typeof(Src) == "string" and #Src > 100 then
                LegacyState.Module = loadstring(Src)()
            end
        end
        if not LegacyState.Module then
            local Src = game:HttpGet(LEGACY_ICON_URL)
            LegacyState.Module = loadstring(Src)()
            if writefile and typeof(Src) == "string" then pcall(writefile, LEGACY_ICON_CACHE, Src) end
        end
    end)

    return LegacyState.Module
end

local function LegacyIcon(Name)
    local Module = LegacyModule()
    if not Module then return nil end

    local Ok, Icon = pcall(Module.GetAsset, Name)
    if not Ok or typeof(Icon) ~= "table" then return nil end

    return {
        Name = Name,
        Provider = "lucide",
        Legacy = true,
        Url = Icon.Url,
        ImageRectOffset = Icon.ImageRectOffset or Vector2.zero,
        ImageRectSize = Icon.ImageRectSize or Vector2.zero,
    }
end

--// Icon API \\--
-- Library:GetIcon(name, provider?) -> { Name, Provider, Url, ImageRectOffset, ImageRectSize } | nil
function Library:GetIcon(Name: string, Provider: string?)
    if typeof(Name) ~= "string" or Name == "" then return nil end

    local Pack = Provider or Library.IconProvider or "lucide"
    local Key = Pack .. "/" .. Name

    local Cached = IconCache[Key]
    if Cached ~= nil then return Cached or nil end

    local Icon = MoltoIcon(Name, Pack)
    if not Icon and Library.IconFallback and Library.IconFallback ~= Pack then
        Icon = MoltoIcon(Name, Library.IconFallback)
    end
    -- Registry gave up entirely (no module, or Lucide itself failed): pinned lucide-roblox-direct build
    if not Icon and (not MoltoIcons or FailedPacks["lucide"]) then
        Icon = LegacyIcon(Name)
    end

    IconCache[Key] = Icon or false
    return Icon
end

function Library:HasIcon(Name: string, Provider: string?): boolean
    return Library:GetIcon(Name, Provider) ~= nil
end

function Library:GetIconProvider(): string
    return Library.IconProvider
end

function Library:GetIconProviders(): { string }
    local Ids = {}
    if MoltoIcons and typeof(MoltoIcons.Providers) == "table" then
        for _, Id in MoltoIcons.Providers do
            if typeof(Id) == "string" then table.insert(Ids, Id) end
        end
    end
    if #Ids == 0 then table.insert(Ids, "lucide") end
    return Ids
end

function Library:GetIconProviderInfo(Id: string?)
    Id = Id or Library.IconProvider
    if MoltoIcons then
        local Ok, Info = pcall(MoltoIcons.GetProviderInfo, Id)
        if Ok and typeof(Info) == "table" then return Info end
    end
    if Id == "lucide" then
        return { Id = "lucide", Name = "Lucide", License = "ISC", Count = 0 }
    end
    return nil
end

-- Values for the "Icon pack" dropdown: { { "Lucide (1962)", "lucide" }, ... }
function Library:GetIconProviderValues()
    local Values = {}
    for _, Id in Library:GetIconProviders() do
        local Info = Library:GetIconProviderInfo(Id)
        local Text = if Info then `{Info.Name} ({Info.Count})` else Id
        table.insert(Values, { Text, Id })
    end
    return Values
end

-- Switches the active pack. Returns false + a reason when the pack can't be loaded.
function Library:SetIconProvider(Id: string?, Silent: boolean?)
    if typeof(Id) == "number" then Id = tostring(Id) end
    if typeof(Id) ~= "string" or Id == "" then return false, "Invalid icon provider" end
    if not KnownProvider(Id) then return false, `Unknown icon provider "{Id}"` end

    -- Retry a pack that failed earlier (transient download errors shouldn't be permanent)
    if FailedPacks[Id] then
        FailedPacks[Id] = nil
        Library.IconBackendError = nil
        table.clear(IconCache)
    end

    if MoltoIcons then
        -- Loads the pack (data + sprite sheets) now; every later lookup comes from disk
        local Ok, Err = pcall(MoltoIcons.SetProvider, Id)
        if not Ok then return false, tostring(Err) end
    end

    Library.IconProvider = Id
    table.clear(IconCache)

    if Silent then return true end

    local DD = Options.EvergreenIconPack
    if DD and typeof(DD.SetValue) == "function" and not Library.SyncingIconPack then
        Library.SyncingIconPack = true
        pcall(DD.SetValue, DD, Id)
        Library.SyncingIconPack = false
    end

    Library:RefreshIcons()
    return true
end

-- Pass nil / false to turn the Lucide fallback off
function Library:SetIconFallback(Provider: string?): boolean
    if Provider ~= nil and Provider ~= false and not KnownProvider(Provider) then return false end

    Library.IconFallback = Provider or false
    table.clear(IconCache)
    Library:RefreshIcons()
    return true
end

-- Fetches a pack ahead of time so the first icon lookup doesn't yield
function Library:PreloadIcons(Provider: string?): boolean
    Provider = Provider or Library.IconProvider
    if not MoltoIcons or not KnownProvider(Provider) then return false end
    return (pcall(MoltoIcons.GetIcons, Provider))
end

-- Repaints every icon label the library has handed out, using the current pack
function Library:RefreshIcons(): number
    local Count = 0
    for Img, Name in Library.AppliedIcons do
        if typeof(Img) ~= "Instance" or Img.Parent == nil then
            Library.AppliedIcons[Img] = nil
        else
            local Icon = Library:GetIcon(Name)
            if Icon then
                Library:ApplyIcon(Img, Icon)
                Count += 1
            end
        end
    end
    return Count
end

-- Forgets every remembered failure so the registry is retried on the next lookup
function Library:ResetIconBackend()
    Library.IconBackendError = nil
    table.clear(FailedPacks)
    table.clear(IconCache)
    return Library
end

function Library:GetCustomIcon(Name)
    if Name == nil or Name == "" then return nil end
    if tonumber(Name) then Name = "rbxassetid://" .. tostring(Name) end
    if typeof(Name) ~= "string" then return nil end
    if Name:match("^rbxassetid://") or Name:match("^rbxasset://") or Name:match("^rbxthumb://") or Name:match("^content://") or Name:match("roblox%.com/asset") then
        return { Url = Name, ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero, Custom = true }
    end
    return Library:GetIcon(Name)
end

-- Applies a pack icon to an ImageLabel (or to a TextLabel when the pack font is available).
function Library:ApplyIcon(Img, Icon)
    if not Img or typeof(Icon) ~= "table" then return end

    -- Remember the name so Library:RefreshIcons can repaint this label after a pack switch
    if typeof(Icon.Name) == "string" then
        Library.AppliedIcons[Img] = Icon.Name
    end

    if Icon.FontFace and Img:IsA("TextLabel") then
        Img.Text = Icon.Text or ""
        Img.FontFace = Icon.FontFace
    else
        Img.Image = Icon.Url or ""
        Img.ImageRectOffset = Icon.ImageRectOffset or Vector2.zero
        Img.ImageRectSize = Icon.ImageRectSize or Vector2.zero
    end
end

--// Glyph: pack icon with a text fallback \\--
local function Glyph(Parent, IconName, Fallback, Props)
    Props = Props or {}
    Props.Parent = Parent
    local Icon = Library:GetIcon(IconName)
    if Icon then
        local Img = New("ImageLabel", {
            AnchorPoint = Props.AnchorPoint, Position = Props.Position, Size = Props.Size or UDim2.fromOffset(14, 14),
            ImageColor3 = Props.Color or "SubText", Rotation = Props.Rotation or 0, LayoutOrder = Props.LayoutOrder or 0,
            Visible = Props.Visible ~= false, Parent = Parent,
        })
        Library:ApplyIcon(Img, Icon)
        return Img
    end
    return New("TextLabel", {
        AnchorPoint = Props.AnchorPoint, Position = Props.Position, Size = Props.Size or UDim2.fromOffset(14, 14),
        Text = Fallback, TextSize = 13, TextColor3 = Props.Color or "SubText", Rotation = Props.Rotation or 0,
        LayoutOrder = Props.LayoutOrder or 0, Visible = Props.Visible ~= false, Parent = Parent,
    })
end
local function GlyphTransparency(G, T)
    if G:IsA("ImageLabel") then G.ImageTransparency = T else G.TextTransparency = T end
end

--// Root GUI \\--
local ScreenGui = New("ScreenGui", { Name = "Evergreen", DisplayOrder = 998, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
pcall(protectgui, ScreenGui)
local ParentOk = pcall(function() ScreenGui.Parent = gethui() end)
if not ParentOk or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
Library.ScreenGui = ScreenGui

ScreenGui.DescendantAdded:Connect(function(Inst)
    if Inst:IsA("ScrollingFrame") and Library.Skin and Library.Skin.Scrollbar then
        Library:SkinScrollbar(Inst)
    end
end)

ScreenGui.DescendantRemoving:Connect(function(Inst)
    if not (Library.Registry[Inst] or Library.Gradients[Inst] or Library.DPIScales[Inst]
        or Library.Surfaces[Inst] or Library.AppliedIcons[Inst]
        or (Library.GlassFrames and Library.GlassFrames[Inst])) then return end
    task.defer(function()
        if Inst.Parent and Inst:IsDescendantOf(ScreenGui) then return end
        Library.Registry[Inst] = nil
        Library.Gradients[Inst] = nil
        Library.DPIScales[Inst] = nil
        Library.Surfaces[Inst] = nil
        Library.AppliedIcons[Inst] = nil
        local G = Library.GlassFrames[Inst]
        if G then
            if G.Part then G.Part:Destroy() end
            Library.GlassFrames[Inst] = nil
        end
    end)
end)

local ModalElement = New("TextButton", { Modal = false, Size = UDim2.fromOffset(0, 0), ZIndex = -999, Parent = ScreenGui })
local Floats = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 10, Parent = ScreenGui })
local Overlay = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 20, Parent = ScreenGui })
Library.Floats, Library.Overlay = Floats, Overlay

--// Dragging \\--
function Library:MakeDraggable(Target, Handle, IsWindow)
    local Dragging, StartPos, StartFrame = false, nil, nil
    Handle.InputBegan:Connect(function(Input)
        if not IsPress(Input) or (IsWindow and Library.CantDragForced) then return end
        Dragging, StartPos, StartFrame = true, Input.Position, Target.Position
        local C; C = Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End or Input.UserInputState == Enum.UserInputState.Cancel then
                Dragging = false
                C:Disconnect()
            end
        end)
    end)
    Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then return end
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            local D = Input.Position - StartPos
            Target.Position = UDim2.new(StartFrame.X.Scale, StartFrame.X.Offset + D.X, StartFrame.Y.Scale, StartFrame.Y.Offset + D.Y)
        end
    end))
end

--// UI transparency (must exist before load-time surfaces like the keybind list) \\--
function Library:AddSurface(Frame, Base, Factor)
    Base, Factor = Base or 0, Factor or 1
    Library.Surfaces[Frame] = { Base = Base, Factor = Factor }
    Frame.BackgroundTransparency = Base + (1 - Base) * Library.UITransparency * Factor
end

function Library:SetTransparency(T)
    T = math.clamp(tonumber(T) or 0, 0, 0.9)
    Library.UITransparency = T
    for Frame, D in Library.Surfaces do
        if Frame.Parent then
            Frame.BackgroundTransparency = D.Base + (1 - D.Base) * T * D.Factor
        end
    end
end

--// Glass registry: frames that get a real blur behind them (region blur, not full screen) \\--
Library.GlassFrames = {}
Library.GlassMode = "Region" -- "Region" = blur only behind registered UI | "Full" = blur the whole screen
function Library:AddGlass(Frame)
    if Library.GlassFrames[Frame] == nil then Library.GlassFrames[Frame] = {} end
end

--// Popups (dropdown, color picker, key mode menu) \\--
function Library:CreatePopup(Anchor, Opt)
    Opt = Opt or {}
    local Popup = { Active = false, Anchor = Anchor, Destroyed = false, Connections = {} }

    local Frame = New("Frame", {
        BackgroundColor3 = "Popup", Visible = false, ClipsDescendants = true,
        Size = UDim2.fromOffset(Opt.Width or 150, Opt.Height or 100), Parent = Overlay,
    })
    if Opt.AutoY then
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.Size = UDim2.fromOffset(Opt.Width or 150, 0)
    end
    Corner(Frame, 9)
    Stroke(Frame, "Outline", 1, 0.2)
    local Scale = New("UIScale", { Scale = Library.DPIScale, Parent = Frame })
    Library.DPIScales[Scale] = true
    Library:AddSurface(Frame, 0, 0.5)
    Library:AddGlass(Frame)
    Popup.Frame = Frame

    function Popup:UpdatePosition()
        if not Anchor.Parent then return end
        local AP, AS, FS = Anchor.AbsolutePosition, Anchor.AbsoluteSize, Frame.AbsoluteSize
        local View = ScreenGui.AbsoluteSize
        local X = AP.X + (Opt.AlignRight and (AS.X - FS.X) or 0)
        local Y = AP.Y + AS.Y + 4
        if Y + FS.Y > View.Y - 8 then Y = AP.Y - FS.Y - 4 end
        X = math.clamp(X, 8, math.max(8, View.X - FS.X - 8))
        Frame.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
    end

    function Popup:SetSize(Size)
        Frame.Size = Size
        if Popup.Active then Popup:UpdatePosition() end
    end

    function Popup:Open()
        if Popup.Active or Popup.Destroyed then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        Library.CurrentPopup = Popup
        Popup.Active = true
        if Opt.OnOpen then Library:SafeCallback(Opt.OnOpen, Popup) end

        Frame.Visible = true
        Scale.Scale = 0.95 * Library.DPIScale
        Tween(Scale, { Scale = Library.DPIScale }, Library.PopTween)
        Popup:UpdatePosition()

        Popup.Connections = {
            Anchor:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() Popup:UpdatePosition() end),
            Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() Popup:UpdatePosition() end),
        }
        if Opt.OnToggle then Library:SafeCallback(Opt.OnToggle, true) end
    end

    function Popup:Close()
        if not Popup.Active then return end
        Popup.Active = false
        if Library.CurrentPopup == Popup then Library.CurrentPopup = nil end
        for _, C in Popup.Connections do C:Disconnect() end
        Popup.Connections = {}
        Frame.Visible = false
        if Opt.OnToggle then Library:SafeCallback(Opt.OnToggle, false) end
    end

    function Popup:Toggle()
        if Popup.Active then Popup:Close() else Popup:Open() end
    end

    function Popup:Destroy()
        Popup:Close()
        Popup.Destroyed = true
        Frame:Destroy()
    end

    return Popup
end

Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input)
    if Library.Unloaded then return end
    local Type = Input.UserInputType
    if Type == Enum.UserInputType.MouseButton1 or Type == Enum.UserInputType.MouseButton2 or Type == Enum.UserInputType.Touch then
        local P = Library.CurrentPopup
        if P then
            local M = MousePos()
            if not IsOver(P.Frame, M) and not IsOver(P.Anchor, M) then P:Close() end
        end
    elseif Input.KeyCode == Enum.KeyCode.Escape then
        if UserInputService:GetFocusedTextBox() then return end
        if Library.CurrentModal then Library.CurrentModal:Close() return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
    end
end))

--// Tooltips \\--
local TooltipLabel = New("TextLabel", {
    BackgroundColor3 = "Popup", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.XY,
    Size = UDim2.fromOffset(0, 0), TextSize = 12, TextWrapped = true, Visible = false, ZIndex = 60, Parent = ScreenGui,
})
Corner(TooltipLabel, 6)
Stroke(TooltipLabel, "Outline", 1, 0.2)
Pad(TooltipLabel, 5, 8, 5, 8)
New("UISizeConstraint", { MaxSize = Vector2.new(260, math.huge), Parent = TooltipLabel })
Library.DPIScales[New("UIScale", { Parent = TooltipLabel })] = true

local HoverTarget
Library:GiveSignal(RunService.RenderStepped:Connect(function()
    if HoverTarget then
        if not HoverTarget.Parent or not HoverTarget.Visible or Library.CurrentPopup then
            TooltipLabel.Visible = false
            HoverTarget = nil
            return
        end
        TooltipLabel.Position = UDim2.fromOffset(Mouse.X + 14, Mouse.Y + 14)
    end
end))

function Library:AddTooltip(Text, Target)
    if typeof(Text) ~= "string" or not Target then return end
    -- Instance-scoped: auto-disconnects when Target is destroyed, so no GiveSignal needed.
    Target.MouseEnter:Connect(function()
        if Library.CurrentPopup then return end
        HoverTarget = Target
        TooltipLabel.Text = Text
        TooltipLabel.Visible = true
    end)
    Target.MouseLeave:Connect(function()
        if HoverTarget == Target then
            HoverTarget = nil
            TooltipLabel.Visible = false
        end
    end)
end

--// Keybind list (floating macOS-style HUD) \\--
local KeybindFrame = New("Frame", {
    BackgroundColor3 = "Card", AutomaticSize = Enum.AutomaticSize.XY, AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(0, 0), Visible = false, Parent = Floats,
})
Corner(KeybindFrame, 10)
Library:AddSurface(KeybindFrame, 0, 0.6)
Library:AddGlass(KeybindFrame)
Stroke(KeybindFrame, "Outline", 1, 0.2)
Pad(KeybindFrame, 8, 12, 10, 12)
List(KeybindFrame, 4)
local KeybindTitle = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 16), Text = "Keybinds", FontFace = "FontBold", TextSize = 12, LayoutOrder = -1, Parent = KeybindFrame })
do
    local function RestyleKeybindSkin()
        local K = Library:GetSkinSpec() and Library:GetSkinSpec().Keybind or {}
        KeybindTitle.Text = K.Title or "Keybinds"
        KeybindTitle.TextColor3 = K.Accent and Library.Scheme.Accent or Library.Scheme.Text
    end
    table.insert(Library.SkinHooks, RestyleKeybindSkin)
    RestyleKeybindSkin()
end
local KeybindContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 0), Parent = KeybindFrame })
List(KeybindContainer, 2)
Library.KeybindFrame, Library.KeybindContainer = KeybindFrame, KeybindContainer
Library:MakeDraggable(KeybindFrame, KeybindFrame)
Library.DPIScales[New("UIScale", { Parent = KeybindFrame })] = true

function Library:UpdateKeybindList()
    local Any = false
    for _, KP in Library.KeybindPickers do
        if KP.Row and KP.Row.Visible then Any = true break end
    end
    KeybindFrame.Visible = Library.KeybindListEnabled and Any
end
function Library:SetKeybindListVisible(Value)
    Library.KeybindListEnabled = Value == true
    Library:UpdateKeybindList()
    if Library.Dock then Library.Dock:Refresh() end
end

--// Players / Teams \\--
local function GetPlayers(ExcludeLocal)
    local L = Players:GetPlayers()
    if ExcludeLocal then
        local I = table.find(L, LocalPlayer)
        if I then table.remove(L, I) end
    end
    table.sort(L, function(A, B) return A.Name:lower() < B.Name:lower() end)
    return L
end
local function GetTeams()
    local L = Teams:GetTeams()
    table.sort(L, function(A, B) return A.Name:lower() < B.Name:lower() end)
    return L
end

--// Rich text: custom tags, inline icons/images, click-to-copy, text animations \\--
--  <Copyable>text</Copyable>  <Link=url>..</Link>  <Title> <Subtitle> <Muted> <Accent> <Red> <Green> <Blue> <Yellow> ...
--  <B> <I> <U> <S> <Code> <Size=18> <Color=#ff8800> <Br/> <Icon=house Size=14/> <Image=rbxassetid://123 Size=32/>
--  Animations: <Rainbow> <Wave> <Pulse> <Shake> <Typewriter> ... or <Animated:wave>text</Animated> (44 styles).  Closing with <Tag/> works too.
local RichNamed = {
    blue = Color3.fromRGB(64, 156, 255), green = Color3.fromRGB(48, 209, 88), yellow = Color3.fromRGB(255, 214, 10),
    orange = Color3.fromRGB(255, 159, 10), purple = Color3.fromRGB(191, 90, 242), pink = Color3.fromRGB(255, 55, 95),
    cyan = Color3.fromRGB(90, 200, 250), white = Color3.new(1, 1, 1), gray = Color3.fromRGB(150, 150, 158),
}
local RichKeys = { accent = "Accent", muted = "SubText", subtext = "SubText", red = "Red", text = "Text" }
local RichAnims = {
    rainbow = true, wave = true, pulse = true, shake = true, typewriter = true,
    typing = true, coding = true, glow = true, flicker = true, swing = true, bounce = true,
    jitter = true, spin = true, pendulum = true, gradient = true, blink = true, breathe = true,
    neon = true, glitch = true, sway = true, shimmer = true, strobe = true,
    spark = true, flame = true, frost = true, electric = true, ripple = true, zoom = true,
    wobble = true, twist = true, flip = true, rise = true, echo = true, prism = true,
    plasma = true, laser = true, star = true, heartbeat = true, clock = true, dice = true,
    spring = true, cascade = true, caret = true, quantum = true,
}
local RichFonts = {
    Italic = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Italic),
    BoldItalic = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic),
    Code = Font.fromEnum(Enum.Font.Code),
}

local function Esc(S)
    return (S:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function ParseColor(V)
    if not V then return nil end
    local L = tostring(V):lower()
    if RichKeys[L] then return RichKeys[L] end
    if RichNamed[L] then return RichNamed[L] end
    if L:sub(1, 1) == "#" then
        local Ok, C = pcall(Color3.fromHex, L)
        if Ok then return C end
    end
    local R, G, B = L:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
    if R then return Color3.fromRGB(tonumber(R), tonumber(G), tonumber(B)) end
    return nil
end

function Library:HasRich(Text)
    return typeof(Text) == "string" and Text:find("<[/%a]") ~= nil
end

function Library:ParseRich(Text)
    Text = tostring(Text or "")
    local Segs, Stack, Cur = {}, {}, {}

    local function AddText(T)
        if T == "" then return end
        local Lines = T:split("\n")
        for I, Line in Lines do
            if I > 1 then table.insert(Segs, { Type = "br" }) end
            if Line ~= "" then
                if Cur.CopyRef then Cur.CopyRef.Text ..= Line end
                table.insert(Segs, { Type = "text", Text = Line, Style = table.clone(Cur) })
            end
        end
    end

    local function Apply(Name, Val, Attrs)
        if Name == "copyable" or Name == "copy" then
            Cur.CopyRef = { Text = "" }; Cur.Color = RichNamed.blue; Cur.Underline = true
        elseif Name == "link" or Name == "url" then
            Cur.Link = Val or Attrs.url or Attrs.href or ""; Cur.Color = RichNamed.blue; Cur.Underline = true
        elseif Name == "title" then Cur.Size = 20; Cur.Bold = true
        elseif Name == "subtitle" then Cur.Size = 16; Cur.Bold = true
        elseif Name == "b" or Name == "bold" then Cur.Bold = true
        elseif Name == "i" or Name == "italic" then Cur.Italic = true
        elseif Name == "u" or Name == "underline" then Cur.Underline = true
        elseif Name == "s" or Name == "strike" then Cur.Strike = true
        elseif Name == "code" then Cur.Code = true; Cur.Color = "Accent"
        elseif Name == "size" then Cur.Size = tonumber(Val) or Cur.Size
        elseif Name == "color" or Name == "colour" or Name == "c" then Cur.Color = ParseColor(Val) or Cur.Color
        elseif RichKeys[Name] or RichNamed[Name] then Cur.Color = RichKeys[Name] or RichNamed[Name]
        elseif RichAnims[Name] then Cur.Anim = Name
        elseif Name == "animated" or Name == "anim" then
            local K = tostring(Val or Attrs.style or Attrs.type or ""):lower()
            if RichAnims[K] then Cur.Anim = K else return false end
        else return false end
        return true
    end

    local Pos = 1
    while Pos <= #Text do
        local S, E, Close, Name, Rest = Text:find("<(/?)%s*([%a_][%w_]*)([^<>]-)>", Pos)
        if not S then AddText(Text:sub(Pos)) break end
        AddText(Text:sub(Pos, S - 1))
        Pos = E + 1

        local LName = Name:lower()
        local SelfClose = false
        if Rest:sub(-1) == "/" then SelfClose = true; Rest = Rest:sub(1, -2) end
        Rest = Rest:match("^%s*(.-)%s*$")

        local Val, Attrs = nil, {}
        if Rest:sub(1, 1) == "=" then
            local Quoted = Rest:match('^=%s*"[^"]*"')
            local Plain = Quoted or Rest:match("^=%s*%S+")
            Val = Quoted and Quoted:match('"([^"]*)"') or (Plain and Plain:match("^=%s*(%S+)"))
            Rest = Rest:sub(#(Plain or "") + 1)
        end
        if not Val and Rest:sub(1, 1) == ":" then
            Val = Rest:match("^:%s*([%a_][%w_]*)")
            Rest = ""
        end
        for K, V in Rest:gmatch('([%w_]+)%s*=%s*"([^"]*)"') do Attrs[K:lower()] = V end
        for K, V in Rest:gmatch('([%w_]+)%s*=%s*([%w_%.%:%/%?%#%-%+%%]+)') do
            if Attrs[K:lower()] == nil then Attrs[K:lower()] = V end
        end

        local function CloseTag()
            for I = #Stack, 1, -1 do
                if Stack[I].Name == LName then
                    Cur = Stack[I].Prev
                    for J = #Stack, I, -1 do table.remove(Stack, J) end
                    return true
                end
            end
            return false
        end

        if Close == "/" then
            if not CloseTag() then AddText(Text:sub(S, E)) end
        elseif LName == "br" then
            table.insert(Segs, { Type = "br" })
        elseif LName == "icon" or LName == "img" or LName == "image" then
            table.insert(Segs, {
                Type = "icon", Value = Val or Attrs.name or Attrs.id or Attrs.src, IsImage = LName ~= "icon",
                Size = tonumber(Attrs.size) or Cur.Size or 14, Color = Attrs.color and ParseColor(Attrs.color) or Cur.Color,
            })
        elseif SelfClose then
            if not CloseTag() then AddText(Text:sub(S, E)) end
        else
            local Prev = table.clone(Cur)
            if Apply(LName, Val, Attrs) then
                table.insert(Stack, { Name = LName, Prev = Prev })
            else
                Cur = Prev
                AddText(Text:sub(S, E))
            end
        end
    end
    return Segs
end

function Library:StripRich(Text)
    Text = tostring(Text or "")
    if not Text:find("<[/%a]") then return Text end
    local Out = {}
    for _, Seg in Library:ParseRich(Text) do
        if Seg.Type == "text" then table.insert(Out, Seg.Text) elseif Seg.Type == "br" then table.insert(Out, " ") end
    end
    return table.concat(Out)
end

-- single-label version: converts custom tags to Roblox RichText (not clickable, no inline icons)
function Library:ToRichText(Text)
    Text = tostring(Text or "")
    if not Text:find("<[/%a]") then return Text end
    local Out = {}
    for _, Seg in Library:ParseRich(Text) do
        if Seg.Type == "br" then
            table.insert(Out, "\n")
        elseif Seg.Type == "text" then
            local St, T = Seg.Style, Esc(Seg.Text)
            if St.Strike then T = "<s>" .. T .. "</s>" end
            if St.Underline then T = "<u>" .. T .. "</u>" end
            if St.Italic then T = "<i>" .. T .. "</i>" end
            if St.Bold then T = "<b>" .. T .. "</b>" end
            if St.Color then
                local C3 = typeof(St.Color) == "string" and Library.Scheme[St.Color] or St.Color
                if typeof(C3) == "Color3" then T = string.format('<font color="#%s">%s</font>', C3:ToHex(), T) end
            end
            if St.Size then T = string.format('<font size="%d">%s</font>', St.Size, T) end
            table.insert(Out, T)
        end
    end
    return table.concat(Out)
end

-- search highlight (Roblox RichText)
function Library:HighlightText(Text, Query)
    local Plain = Library:StripRich(Text)
    Query = Trim(tostring(Query or "")):lower()
    if Query == "" then return Library:ToRichText(Text) end
    local Lower = Plain:lower()
    local A, B = Lower:find(Query, 1, true)
    if not A then return Library:ToRichText(Text) end
    local Hex, Out, Pos = Library.Scheme.Accent:ToHex(), {}, 1
    while A do
        if A > Pos then table.insert(Out, Esc(Plain:sub(Pos, A - 1))) end
        table.insert(Out, string.format('<font color="#%s"><b>%s</b></font>', Hex, Esc(Plain:sub(A, B))))
        Pos = B + 1
        A, B = Lower:find(Query, Pos, true)
    end
    if Pos <= #Plain then table.insert(Out, Esc(Plain:sub(Pos))) end
    return table.concat(Out)
end

--// Text animations \\--
Library.TextAnims = {}
function Library:AnimateText(Label, Kind, Index, Count)
    Kind = tostring(Kind):lower()
    if not RichAnims[Kind] then return end
    if Kind == "typewriter" or Kind == "typing" then Label.TextTransparency = 1 end
    table.insert(Library.TextAnims, { L = Label, K = Kind, I = Index or 0, N = Count or 1, T0 = os.clock() })
end

Library:GiveSignal(RunService.RenderStepped:Connect(function()
    local Now = os.clock()
    for I = #Library.TextAnims, 1, -1 do
        local A = Library.TextAnims[I]
        local L = A.L
        if not L.Parent then
            table.remove(Library.TextAnims, I)
        else
            local T = Now - A.T0
            if A.K == "rainbow" then
                L.TextColor3 = Color3.fromHSV((T * 0.35 + A.I * 0.045) % 1, 0.7, 1)
            elseif A.K == "wave" then
                L.Rotation = math.sin(T * 5 + A.I * 0.6) * 7
            elseif A.K == "pulse" then
                L.TextTransparency = 0.3 - 0.3 * math.cos(T * 3)
            elseif A.K == "shake" then
                L.Rotation = (math.random() - 0.5) * 6
            elseif A.K == "typewriter" or A.K == "typing" then
                if T >= A.I * 0.045 then
                    L.TextTransparency = 0
                    if A.I >= A.N - 1 or T > A.N * 0.045 + 0.2 then table.remove(Library.TextAnims, I) end
                end
            elseif A.K == "coding" then
                local Reveal = math.min(1, T / math.max(A.N * 0.045 + 0.2, 0.3))
                local H = ((A.I * 2654435761) % 1009) / 1009
                L.TextTransparency = (H < Reveal) and 0 or 1
                if Reveal >= 1 and T > A.N * 0.045 + 0.6 then table.remove(Library.TextAnims, I) end
            elseif A.K == "glow" then
                L.TextColor3 = Library.Scheme.Accent:Lerp(Color3.new(1, 1, 1), (math.sin(T * 4) + 1) * 0.35)
            elseif A.K == "flicker" then
                L.TextTransparency = math.random() < 0.88 and 0 or (0.25 + math.random() * 0.5)
            elseif A.K == "swing" then
                L.Rotation = math.sin(T * 2.5 + A.I * 0.4) * 14
            elseif A.K == "bounce" then
                local S = math.sin(T * 6 + A.I * 0.5)
                L.Rotation = math.abs(S) * 10 * (S >= 0 and 1 or -1)
            elseif A.K == "jitter" then
                L.Rotation = (math.random() - 0.5) * 3
                L.TextTransparency = math.random() * 0.15
            elseif A.K == "spin" then
                L.Rotation = (T * 160) % 360
            elseif A.K == "pendulum" then
                L.Rotation = math.sin(T * 1.6 + A.I * 0.3) * 16
            elseif A.K == "gradient" then
                L.TextColor3 = Color3.fromHSV((T * 0.12 + A.I * 0.15) % 1, 0.55, 1)
            elseif A.K == "blink" then
                L.TextTransparency = (((T * 2.5 + A.I * 0.12) % 1) < 0.5) and 0 or 1
            elseif A.K == "breathe" then
                L.TextTransparency = 0.25 - 0.25 * math.cos(T * 2)
            elseif A.K == "neon" then
                L.TextColor3 = Color3.fromHSV((T * 0.6) % 1, 1, 1)
            elseif A.K == "glitch" then
                L.TextTransparency = math.random() < 0.9 and 0 or (math.random() * 0.8)
                L.Rotation = math.random() < 0.06 and ((math.random() - 0.5) * 10) or 0
            elseif A.K == "sway" then
                L.Rotation = math.sin(T * 3.2 + A.I * 0.9) * 3
            elseif A.K == "shimmer" then
                L.TextTransparency = 0.15 * ((math.sin(T * 9 + A.I * 0.7) + 1) * 0.5)
            elseif A.K == "strobe" then
                L.TextTransparency = (math.floor(T * 8) % 2 == 0) and 0 or 1
            elseif A.K == "spark" then
                L.TextColor3 = (math.random() < 0.12) and Color3.new(1, 1, 1) or Library.Scheme.Accent
            elseif A.K == "flame" then
                L.TextColor3 = Color3.fromHSV(0.02 + 0.05 * (math.sin(T * 9 + A.I) + 1) * 0.5, 0.9, 0.85 + 0.15 * math.random())
            elseif A.K == "frost" then
                L.TextColor3 = Color3.fromHSV(0.55, 0.35, 1)
                L.TextTransparency = 0.12 * (math.sin(T * 1.6 + A.I * 0.6) + 1) * 0.5
            elseif A.K == "electric" then
                L.TextTransparency = (math.random() < 0.75) and 0 or (0.4 + math.random() * 0.5)
                L.TextColor3 = (math.random() < 0.5) and Color3.fromHSV(0.55, 0.4, 1) or Color3.new(1, 1, 1)
            elseif A.K == "ripple" then
                L.TextTransparency = ((math.sin(T * 2.6 - A.I * 0.9) + 1) * 0.5) * 0.5
            elseif A.K == "zoom" then
                local Sc = L:FindFirstChildOfClass("UIScale") or New("UIScale", { Scale = 1, Parent = L })
                Sc.Scale = 1 + 0.1 * math.sin(T * 3)
            elseif A.K == "wobble" then
                L.Rotation = math.sin(T * 7 + A.I * 0.4) * 8
            elseif A.K == "twist" then
                L.Rotation = 55 * ((math.sin(T * 3.4 + A.I * 0.5) >= 0) and 1 or -1)
            elseif A.K == "flip" then
                L.TextTransparency = (((T * 5.5 + A.I * 0.4) % 1) < 0.55) and 0 or 0.85
            elseif A.K == "rise" then
                local Sc = L:FindFirstChildOfClass("UIScale") or New("UIScale", { Scale = 1, Parent = L })
                Sc.Scale = 1 + 0.07 * math.sin(T * 2.4 - A.I * 0.45)
            elseif A.K == "echo" then
                L.TextTransparency = (math.sin(T * 7) > 0.25 or math.sin(T * 7) < -0.25) and 0 or 0.55
            elseif A.K == "prism" then
                L.TextColor3 = Color3.fromHSV((T * 0.05 + A.I * 0.09) % 1, 0.6, 1)
            elseif A.K == "plasma" then
                L.TextColor3 = Color3.fromHSV((T * 0.25 + A.I * 0.12) % 1, 1, 0.75 + 0.25 * math.abs(math.sin(T * 5)))
            elseif A.K == "laser" then
                L.TextColor3 = (math.sin(T * 12) > 0) and Color3.fromRGB(255, 40, 60) or Color3.new(1, 1, 1)
            elseif A.K == "star" then
                L.TextColor3 = (math.sin(T * 3 + A.I * 1.1) > 0.85) and Color3.fromRGB(255, 255, 210) or Library.Scheme.Accent
            elseif A.K == "heartbeat" then
                local Sc = L:FindFirstChildOfClass("UIScale") or New("UIScale", { Scale = 1, Parent = L })
                local B1 = math.sin(T * 4)
                local B2 = math.sin(T * 4 - 1.7)
                Sc.Scale = 1 + 0.16 * ((B1 > 0 and B1 or 0) ^ 2 + 0.5 * ((B2 > 0 and B2 or 0) ^ 2))
            elseif A.K == "clock" then
                L.Rotation = 12 * (math.floor(T * 2) % 2 == 0 and 1 or -1)
            elseif A.K == "dice" then
                L.Rotation = ((math.floor(T * 2.5) * 7 + A.I * 13) % 31) - 15
            elseif A.K == "spring" then
                local Sc = L:FindFirstChildOfClass("UIScale") or New("UIScale", { Scale = 1, Parent = L })
                local Cy = T % 1.3
                Sc.Scale = 1 + math.exp(-3.5 * Cy) * math.sin(Cy * 13) * 0.22
            elseif A.K == "cascade" then
                L.TextColor3 = Library.Scheme.Accent:Lerp(Color3.new(1, 1, 1), ((math.sin(T * 3 + A.I * 0.8) + 1) * 0.5) * 0.7)
            elseif A.K == "caret" then
                L.TextTransparency = (A.I == A.N - 1 and math.floor(T * 2.5) % 2 == 1) and 1 or 0
            elseif A.K == "quantum" then
                L.TextTransparency = math.random() * 0.4
            end
        end
    end
end))

-- Full renderer: flowing words as separate widgets so Copyable/Link/icons/animations work inline.
function Library:RenderRich(Parent, Text, Opt)
    Opt = Opt or {}
    local BaseSize = Opt.Size or 13
    local Host = New("Frame", {
        BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = Opt.LayoutOrder or 0, Visible = Opt.Visible ~= false, Parent = Parent,
    })
    New("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, Wraps = true, SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Opt.Align == "Center" and Enum.HorizontalAlignment.Center or (Opt.Align == "Right" and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left),
        Parent = Host,
    })
    local Rich = { Host = Host, Text = tostring(Text or "") }

    function Rich:Render(NewText)
        Rich.Text = tostring(NewText or "")
        for _, C in Host:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end

        local Order = 0
        local Groups = {}
        local function Next() Order += 1 return Order end
        local BaseLine = math.ceil(BaseSize * 1.45)

        local function CopyOut(Str, Group)
            local Fn = setclipboard or toclipboard
            if Fn then pcall(Fn, Str) end
            for _, P in Group do
                if P.Parent then
                    local Prev = P.TextColor3
                    P.TextColor3 = RichNamed.green
                    task.delay(0.8, function() if P.Parent then P.TextColor3 = Prev end end)
                end
            end
        end

        local function MakePiece(Str, St, Idx, Count)
            local Size = St.Size or BaseSize
            local Interactive = St.CopyRef ~= nil or (St.Link ~= nil and St.Link ~= "")
            local Face = "Font"
            if St.Code then Face = RichFonts.Code
            elseif (St.Bold or Opt.Bold) and St.Italic then Face = RichFonts.BoldItalic
            elseif St.Bold or Opt.Bold then Face = "FontBold"
            elseif St.Italic then Face = RichFonts.Italic end

            local Content = Esc(Str)
            if St.Strike then Content = "<s>" .. Content .. "</s>" end
            if St.Underline then Content = "<u>" .. Content .. "</u>" end

            local P = New(Interactive and "TextButton" or "TextLabel", {
                BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, math.ceil(Size * 1.45)),
                Text = Content, TextSize = Size, FontFace = Face, TextColor3 = St.Color or Opt.Color or "Text",
                TextYAlignment = Enum.TextYAlignment.Center, LayoutOrder = Next(), Parent = Host,
            })
            if St.Code then
                P.BackgroundTransparency = 0.75
                P.BackgroundColor3 = Library.Scheme.Control
                Bind(P, "BackgroundColor3", "Control")
                Corner(P, 4)
                Pad(P, 0, 3, 0, 3)
            end
            if Interactive then
                local Group = St.CopyRef and Groups[St.CopyRef]
                if St.CopyRef and not Group then Group = {}; Groups[St.CopyRef] = Group end
                if not Group then Group = { P } else table.insert(Group, P) end
                local Payload = St.CopyRef and St.CopyRef or { Text = St.Link }
                P.MouseEnter:Connect(function() Tween(P, { TextTransparency = 0.3 }) end)
                P.MouseLeave:Connect(function() Tween(P, { TextTransparency = 0 }) end)
                P.MouseButton1Click:Connect(function() CopyOut(Payload.Text, Group) end)
                Library:AddTooltip(St.Link and "Click to copy link" or "Click to copy", P)
            end
            if St.Anim then Library:AnimateText(P, St.Anim, Idx, Count) end
            return P
        end

        for _, Seg in Library:ParseRich(Rich.Text) do
            if Seg.Type == "br" then
                New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = Next(), Parent = Host })
            elseif Seg.Type == "icon" then
                local Sz = Seg.Size
                local W = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Sz + 4, math.max(BaseLine, Sz + 2)), LayoutOrder = Next(), Parent = Host })
                local Data = Library:GetCustomIcon(Seg.Value)
                if Data then
                    local Img = New("ImageLabel", {
                        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(Sz, Sz),
                        ImageColor3 = Seg.IsImage and Color3.new(1, 1, 1) or (Seg.Color or Opt.Color or "Text"), Parent = W,
                    })
                    Library:ApplyIcon(Img, Data)
                end
            else
                local St = Seg.Style
                if St.Anim then
                    local Chars = {}
                    for _, Code in utf8.codes(Seg.Text) do table.insert(Chars, utf8.char(Code)) end
                    for I, Ch in Chars do MakePiece(Ch, St, I - 1, #Chars) end
                else
                    local Any = false
                    for Word in Seg.Text:gmatch("%s*%S+%s*") do
                        Any = true
                        MakePiece(Word, St)
                    end
                    if not Any then MakePiece(Seg.Text, St) end
                end
            end
        end
    end

    function Rich:SetText(NewText) Rich:Render(NewText) end
    Rich:Render(Text)
    return Rich
end

--// Elements \\--
local Funcs = {}
local BaseGroupbox = { __index = Funcs }
local AddonFuncs = {}
local BaseAddons = { __index = AddonFuncs }

local function SetSidesScrolling(Enabled)
    if Library.ActiveTab and Library.ActiveTab.Sides then
        for _, S in Library.ActiveTab.Sides do S.ScrollingEnabled = Enabled end
    end
end

-- Only one slider/range may own the pointer at a time (fixes sticky dual-drag on mobile).
local ActiveSliderDrag = nil
local function BindPointerDrag(Area, Owner, OnMove, OnTap, OnEnd)
    local Session = nil
    table.insert(Owner.Connections, Area.InputBegan:Connect(function(Input)
        if Owner.Disabled or not IsPress(Input) then return end
        if ActiveSliderDrag and ActiveSliderDrag ~= Owner then return end
        if Session then return end

        ActiveSliderDrag = Owner
        Session = {
            Input = Input,
            Start = Input.Position,
            Engaged = false,
            Moved = false,
            Token = {},
        }
        local Token = Session.Token
        local MoveConn, EndConn

        local function Cleanup(WasTap)
            if not Session or Session.Token ~= Token then return end
            local Engaged, Moved = Session.Engaged, Session.Moved
            Session = nil
            if ActiveSliderDrag == Owner then ActiveSliderDrag = nil end
            if MoveConn then MoveConn:Disconnect() end
            if EndConn then EndConn:Disconnect() end
            if Engaged then
                SetSidesScrolling(true)
                if OnEnd then OnEnd(Moved) end
            elseif WasTap and OnTap then
                OnTap(Input.Position)
            end
        end

        MoveConn = UserInputService.InputChanged:Connect(function(Move)
            if not Session or Session.Token ~= Token then return end
            if Move.UserInputType ~= Enum.UserInputType.MouseMovement and Move.UserInputType ~= Enum.UserInputType.Touch then return end
            -- Only follow the same touch / mouse that started the drag
            if Move.UserInputType == Enum.UserInputType.Touch and Move ~= Session.Input then return end
            local Pos = Move.Position
            local Dist = math.abs(Pos.X - Session.Start.X) + math.abs(Pos.Y - Session.Start.Y)
            if not Session.Engaged then
                if Dist < 8 then return end
                Session.Engaged = true
                SetSidesScrolling(false)
            end
            if OnMove(Pos, Session) then Session.Moved = true end
        end)

        EndConn = UserInputService.InputEnded:Connect(function(Ended)
            if not Session or Session.Token ~= Token then return end
            if Ended == Session.Input then
                Cleanup(not Session.Engaged)
                return
            end
            if Session.Input.UserInputType ~= Enum.UserInputType.Touch
                and Ended.UserInputType == Enum.UserInputType.MouseButton1 then
                Cleanup(not Session.Engaged)
                return
            end
            if Session.Input.UserInputType == Enum.UserInputType.Touch
                and Ended.UserInputType == Enum.UserInputType.Touch
                and (Session.Input.UserInputState == Enum.UserInputState.End
                    or Session.Input.UserInputState == Enum.UserInputState.Cancel) then
                Cleanup(not Session.Engaged)
            end
        end)

        -- Safety timeout in case InputEnded is missed on some executors
        task.delay(8, function()
            if Session and Session.Token == Token then Cleanup(false) end
        end)
    end))
end

local function Finalize(Group, Element, Holder, Store, Idx, Info)
    Element.Holder = Holder
    Element.Parent = Group
    Element.Group = Group
    Element.Connections = Element.Connections or {}
    if Element.Visible == nil then Element.Visible = true end
    Element.Tooltip = Info and Info.Tooltip
    table.insert(Group.Elements, Element)

    if Store then
        if Idx ~= nil then
            if typeof(Idx) ~= "string" and (Store == Toggles or Store == Options) then
                warn("[Evergreen] non-string id (" .. tostring(Idx) .. ") — element will not be saved to configs: " .. tostring(Element.Type))
            elseif Store[Idx] ~= nil then
                warn("[Evergreen] duplicate id '" .. tostring(Idx) .. "' — the previous element with this id is now shadowed")
            end
            Store[Idx] = Element
        else
            table.insert(Store, Element)
        end
    end

    function Element:SetVisible(V)
        Element.Visible = V
        Holder.Visible = V
        if Library.Searching then Library:UpdateSearch(Library.SearchText) end
        if V and Library.KickScrolls then task.defer(Library.KickScrolls) end
    end

    function Element:Destroy()
        if Element.Destroyed then return end
        Element.Destroyed = true
        for _, C in Element.Connections do C:Disconnect() end
        if Element.Addons then
            for I = #Element.Addons, 1, -1 do
                if Element.Addons[I].Destroy then Element.Addons[I]:Destroy() end
            end
        end
        Holder:Destroy()
        local I = table.find(Group.Elements, Element)
        if I then table.remove(Group.Elements, I) end
        if Store then
            if Idx ~= nil then Store[Idx] = nil else
                local J = table.find(Store, Element)
                if J then table.remove(Store, J) end
            end
        end
    end

    if Info and typeof(Info.Tooltip) == "string" then
        Library:AddTooltip(Info.Tooltip, Holder)
    end
end

local function MakeRow(Group, Height, AsButton)
    local Row = New(AsButton and "TextButton" or "Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Height or 22), Parent = Group.Container })
    List(Row, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
    return Row
end

local function MakeAddonHolder(Row)
    local H = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), LayoutOrder = 2, Parent = Row })
    List(H, 6, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
    return H
end

--// Divider \\--
function Funcs:AddDivider(Text)
    if self.Destroyed then return end
    if typeof(Text) == "table" then Text = Text.Text end
    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 12), Parent = Group.Container })
    local Div = { Type = "Divider", Visible = true }
    if Text then
        List(Holder, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
        local L1 = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(0, 0, 0, 1), Parent = Holder }); Flex(L1)
        New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 12), Text = Text, TextSize = 11, TextColor3 = "SubText", Parent = Holder })
        local L2 = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(0, 0, 0, 1), Parent = Holder }); Flex(L2)
    else
        New("Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = "Outline", Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), Parent = Holder })
    end
    Finalize(Group, Div, Holder)
    return Div
end

--// Label \\--
function Funcs:AddLabel(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Data = {}
    if typeof(First) == "table" or typeof(Second) == "table" then
        local P = typeof(First) == "table" and First or Second
        Data.Text, Data.DoesWrap, Data.Size = P.Text or "", P.DoesWrap or false, P.Size or 13
        Data.Visible = P.Visible ~= false
        Data.Idx = typeof(Second) == "table" and First or nil
    else
        Data.Text, Data.DoesWrap, Data.Size, Data.Visible = First or "", Second or false, 13, true
        Data.Idx = select(3, ...)
    end

    local Group = self
    local IsRich = Data.Rich == true or Library:HasRich(Data.Text)
    local Label = { Type = "Label", Text = Data.Text, DoesWrap = Data.DoesWrap, Addons = {}, Visible = Data.Visible }
    local Row, TextLabel, RichObj

    if IsRich then
        Row = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Group.Container })
        RichObj = Library:RenderRich(Row, Data.Text, { Size = Data.Size, Align = Group.IsKeyTab and "Center" or "Left" })
        Label.AddonHolder = MakeAddonHolder(Row)
        Label.AddonHolder.AnchorPoint = Vector2.new(1, 0)
        Label.AddonHolder.Position = UDim2.fromScale(1, 0)
        Label.AddonHolder.Size = UDim2.fromOffset(0, 18)
        Label.TextLabel = Row
        function Label:SetText(T) Label.Text = T; RichObj:SetText(T) end
    else
        if Data.DoesWrap then
            Row = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Group.Container })
            TextLabel = New("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
                Text = Library:ToRichText(Data.Text), TextSize = Data.Size, TextWrapped = true,
                TextXAlignment = Group.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top, Parent = Row,
            })
            Label.AddonHolder = MakeAddonHolder(Row)
            Label.AddonHolder.AnchorPoint = Vector2.new(1, 0)
            Label.AddonHolder.Position = UDim2.fromScale(1, 0)
        else
            Row = MakeRow(Group, 18)
            TextLabel = New("TextLabel", {
                Size = UDim2.new(0, 0, 1, 0), Text = Library:ToRichText(Data.Text), TextSize = Data.Size,
                TextXAlignment = Group.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center, LayoutOrder = 1, Parent = Row,
            })
            Flex(TextLabel)
            Label.AddonHolder = MakeAddonHolder(Row)
        end
        Label.TextLabel = TextLabel
        Label.LabelObj = TextLabel
        function Label:SetText(T) Label.Text = T; TextLabel.Text = Library:ToRichText(T) end
    end
    Row.Visible = Label.Visible
    setmetatable(Label, BaseAddons)
    Finalize(Group, Label, Row, Labels, Data.Idx)
    return Label
end

--// Title / Paragraph / Callout (all use the rich text renderer) \--
function Funcs:AddTitle(Text, Info)
    if self.Destroyed then return end
    if typeof(Text) == "table" then Info = Text; Text = Info.Text end
    Info = Info or {}
    local Group = self
    local Title = { Type = "Title", Text = tostring(Text or ""), Visible = Info.Visible ~= false }
    local Rich = Library:RenderRich(Group.Container, Title.Text, {
        Size = Info.Size or 17, Bold = true, Align = Info.Align or (Group.IsKeyTab and "Center" or "Left"),
    })
    Rich.Host.Visible = Title.Visible
    function Title:SetText(T) Title.Text = tostring(T); Rich:SetText(T) end
    Finalize(Group, Title, Rich.Host)
    return Title
end

function Funcs:AddParagraph(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Info = typeof(First) == "table" and First or { Title = First, Text = Second }
    local Group = self
    local Para = { Type = "Paragraph", Title = tostring(Info.Title or ""), Body = tostring(Info.Text or ""), Visible = Info.Visible ~= false }
    Para.Text = Para.Title .. " " .. Para.Body

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Para.Visible, Parent = Group.Container })
    List(Holder, 3)
    local TitleRich
    if Para.Title ~= "" then
        TitleRich = Library:RenderRich(Holder, Para.Title, { Size = 13, Bold = true, LayoutOrder = 1 })
    end
    local BodyRich = Library:RenderRich(Holder, Para.Body, { Size = 12, Color = "SubText", LayoutOrder = 2 })

    function Para:SetText(T) Para.Body = tostring(T); Para.Text = Para.Title .. " " .. Para.Body; BodyRich:SetText(T) end
    function Para:SetTitle(T)
        Para.Title = tostring(T); Para.Text = Para.Title .. " " .. Para.Body
        if TitleRich then TitleRich:SetText(T) end
    end
    Finalize(Group, Para, Holder)
    return Para
end

function Funcs:AddCallout(Info)
    if self.Destroyed then return end
    Info = Info or {}
    local Group = self
    local Kind = tostring(Info.Type or "Info"):lower()
    local Look = ({
        info = { RichNamed.blue, "info" }, warning = { RichNamed.yellow, "triangle-alert" },
        success = { RichNamed.green, "circle-check" }, error = { Color3.fromRGB(255, 69, 58), "circle-x" },
    })[Kind] or { RichNamed.blue, "info" }

    local Call = { Type = "Callout", Title = tostring(Info.Title or ""), Body = tostring(Info.Text or ""), Visible = Info.Visible ~= false }
    Call.Text = Call.Title .. " " .. Call.Body

    local Holder = New("Frame", { BackgroundColor3 = Look[1], BackgroundTransparency = 0.88, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Call.Visible, Parent = Group.Container })
    Corner(Holder, 8)
    Stroke(Holder, Look[1], 1, 0.6)
    Pad(Holder, 9, 10, 9, 10)
    local IconData = Library:GetIcon(Look[2])
    if IconData then
        local Img = New("ImageLabel", { Position = UDim2.fromOffset(0, 1), Size = UDim2.fromOffset(16, 16), ImageColor3 = Look[1], Parent = Holder })
        Library:ApplyIcon(Img, IconData)
    end
    local Inner = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(IconData and 24 or 0, 0), Size = UDim2.new(1, IconData and -24 or 0, 0, 0), Parent = Holder })
    List(Inner, 2)
    local TitleRich
    if Call.Title ~= "" then TitleRich = Library:RenderRich(Inner, Call.Title, { Size = 13, Bold = true, LayoutOrder = 1 }) end
    local BodyRich = Library:RenderRich(Inner, Call.Body, { Size = 12, LayoutOrder = 2 })
    function Call:SetText(T) Call.Body = tostring(T); Call.Text = Call.Title .. " " .. Call.Body; BodyRich:SetText(T) end
    function Call:SetTitle(T) Call.Title = tostring(T); if TitleRich then TitleRich:SetText(T) end end
    Finalize(Group, Call, Holder)
    return Call
end

--// Button \\--
function Funcs:AddButton(...)
    if self.Destroyed then return end
    local function GetInfo(...)
        local First, Second = ...
        local I = {}
        if typeof(First) == "table" or typeof(Second) == "table" then
            local P = typeof(First) == "table" and First or Second
            I.Text, I.Func = P.Text or "", P.Func or P.Callback or function() end
            I.DoubleClick, I.Icon, I.Risky, I.Primary = P.DoubleClick, P.Icon, P.Risky, P.Primary
            I.Hold = typeof(P.Hold) == "number" and P.Hold > 0 and P.Hold or (P.Hold == true and 3 or nil)
            I.Tooltip, I.Disabled = P.Tooltip, P.Disabled or false
            I.Visible = P.Visible ~= false
            I.Idx = typeof(Second) == "table" and First or nil
        else
            I.Text, I.Func, I.Disabled, I.Visible = First or "", Second or function() end, false, true
            I.Idx = select(3, ...)
        end
        return I
    end

    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), Parent = Group.Container })
    List(Holder, 8, Enum.FillDirection.Horizontal)

    local function Build(Info, Type)
        local B = {
            Type = Type, Text = Info.Text, Func = Info.Func, DoubleClick = Info.DoubleClick, Risky = Info.Risky,
            Primary = Info.Primary, Disabled = Info.Disabled, Visible = Info.Visible, Locked = false, Hold = Info.Hold, Addons = {},
            Connections = {}, Icon = Info.Icon,
        }
        local BaseKey = B.Primary and "Accent" or "Control"
        B.Base = New("TextButton", { BackgroundColor3 = BaseKey, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Visible = B.Visible, Parent = Holder })
        Flex(B.Base)
        Corner(B.Base, 7)
        B.Stroke = Stroke(B.Base, "Outline", 1, 0.55)
        if not Library:IsFlatSkin() then
            New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B.Base })
        end

        local Icon = Library:GetCustomIcon(B.Icon)
        local TextColor = B.Primary and "AccentText" or (B.Risky and "Red" or "Text")
        B.Label = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Library:ToRichText(B.Text), TextColor3 = TextColor, Parent = B.Base })
        B.LabelObj = B.Label
        if Icon then
            B.Label.Position = UDim2.fromOffset(10, 0)
            B.Label.Size = UDim2.new(1, -10, 1, 0)
            local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(14, 14), ImageColor3 = TextColor, Parent = B.Base })
            Library:ApplyIcon(Img, Icon)
        end

        local function Colors(Hover)
            local Normal, Hovered
            if B.Primary then
                Normal, Hovered = Library.Scheme.Accent, Lighten(Library.Scheme.Accent, 0.07)
            else
                Normal, Hovered = Library.Scheme.Control, Library.Scheme.ControlHover
            end
            return Hover and Hovered or Normal
        end

        function B:UpdateColors()
            B.Label.TextTransparency = B.Disabled and 0.55 or 0
            B.Stroke.Transparency = B.Disabled and 0.8 or 0.55
            B.Base.BackgroundTransparency = B.Disabled and 0.5 or 0
            B.Base.Active = not B.Disabled
        end

        table.insert(B.Connections, B.Base.MouseEnter:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Colors(true) }) end
        end))
        table.insert(B.Connections, B.Base.MouseLeave:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Colors(false) }) end
        end))
        table.insert(B.Connections, B.Base.MouseButton1Down:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Lighten(Colors(false), B.Primary and -0.06 or 0.08) }) end
        end))
        if B.Hold then
            local Holding, HoldRemain = false, 0
            local function HoldShow()
                B.Label.Text = Library:ToRichText(string.format("%s ( %.1f )", B.Text, HoldRemain))
            end
            table.insert(B.Connections, B.Base.InputBegan:Connect(function(Input)
                if B.Disabled or B.Locked or Holding then return end
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                Holding = true
                HoldRemain = B.Hold
                HoldShow()
                task.spawn(function()
                    while Holding and HoldRemain > 0 and not B.Destroyed do
                        task.wait(0.1)
                        if not Holding or B.Destroyed then break end
                        HoldRemain = math.max(0, HoldRemain - 0.1)
                        if not B.Destroyed then HoldShow() end
                    end
                    if Holding and HoldRemain <= 0 and not B.Destroyed then
                        Holding = false
                        B.Label.Text = Library:ToRichText(B.Text)
                        if not B.Disabled and not B.Locked then Library:SafeCallback(B.Func) end
                    end
                end)
            end))
            table.insert(B.Connections, UserInputService.InputEnded:Connect(function(Input)
                if Holding and IsPress(Input) then
                    Holding = false
                    if not B.Destroyed then B.Label.Text = Library:ToRichText(B.Text) end
                end
            end))
        end
        table.insert(B.Connections, B.Base.MouseButton1Click:Connect(function()
            if B.Disabled or B.Locked then return end
            if B.Hold then return end
            if B.DoubleClick then
                B.Locked = true
                B.Label.Text = "Click again to confirm"
                local Clicked = false
                local C = B.Base.MouseButton1Click:Once(function() Clicked = true end)
                task.wait(1.4)
                if C.Connected then C:Disconnect() end
                B.Label.Text = Library:ToRichText(B.Text)
                B.Locked = false
                if Clicked then Library:SafeCallback(B.Func) end
                return
            end
            Library:SafeCallback(B.Func)
        end))

        function B:SetDisabled(D) B.Disabled = D; B:UpdateColors(); Library:UpdateAddons(B) end
        function B:SetText(T) B.Text = T; B.Label.Text = Library:ToRichText(T) end
        function B:SetVisible(V)
            B.Visible = V
            B.Base.Visible = V
            local Other = Type == "Button" and B.SubButton or B.Main
            Holder.Visible = V or (Other ~= nil and Other.Visible)
        end

        B.AddonHolder = Holder
        B.TextLabel = B.Base
        B:UpdateColors()
        if typeof(Info.Tooltip) == "string" then Library:AddTooltip(Info.Tooltip, B.Base) end
        setmetatable(B, BaseAddons)
        return B
    end

    local Info = GetInfo(...)
    local Button = Build(Info, "Button")
    Holder.Visible = Button.Visible

    function Button:AddButton(...)
        local SubInfo = GetInfo(...)
        local Sub = Build(SubInfo, "SubButton")
        Sub.Main = Button
        Button.SubButton = Sub
        Holder.Visible = true
        if SubInfo.Idx then Buttons[SubInfo.Idx] = Sub else table.insert(Buttons, Sub) end
        function Sub:Destroy()
            for _, C in Sub.Connections do C:Disconnect() end
            Sub.Base:Destroy()
            Button.SubButton = nil
        end
        return Sub
    end

    Finalize(Group, Button, Holder, Buttons, Info.Idx, { Tooltip = nil })
    -- Finalize overrides Destroy/SetVisible; restore button-aware versions
    function Button:SetVisible(V)
        Button.Visible = V
        Button.Base.Visible = V
        Holder.Visible = V or (Button.SubButton ~= nil and Button.SubButton.Visible)
        if Library.Searching then Library:UpdateSearch(Library.SearchText) end
    end
    local BaseDestroy = Button.Destroy
    function Button:Destroy()
        if Button.SubButton then Button.SubButton:Destroy() end
        for _, C in Button.Connections do C:Disconnect() end
        BaseDestroy(Button)
    end
    return Button
end

function Funcs:AddCircleButton(...)
    if self.Destroyed then return end
    local First, Second = ...
    local I = (typeof(First) == "table" and First) or (typeof(Second) == "table" and Second) or {}
    local Idx = (typeof(First) ~= "table" and typeof(Second) == "table") and First or nil
    local Info = {
        Text = I.Text or "", Icon = I.Icon, Size = tonumber(I.Size) or 36,
        Func = I.Func or I.Callback or function() end,
        Risky = I.Risky == true, Primary = I.Primary == true, Disabled = I.Disabled == true,
        Visible = I.Visible ~= false, Tooltip = I.Tooltip,
    }

    local Group = self
    local SizeN = math.clamp(Info.Size, 20, 72)
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, SizeN), Parent = Group.Container })
    List(Holder, 8, Enum.FillDirection.Horizontal)

    local B = {
        Type = "CircleButton", Text = Info.Text, Func = Info.Func, Risky = Info.Risky, Primary = Info.Primary,
        Disabled = Info.Disabled, Visible = Info.Visible, Addons = {}, Connections = {}, Icon = Info.Icon,
    }
    local BaseKey = B.Primary and "Accent" or "Control"
    B.Base = New("TextButton", { BackgroundColor3 = BaseKey, Size = UDim2.fromOffset(SizeN, SizeN), Visible = B.Visible, Parent = Holder })
    Corner(B.Base, 99)
    B.Stroke = Stroke(B.Base, "Outline", 1, 0.55)
    if not Library:IsFlatSkin() then
        New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B.Base })
    end
    local BtnScale = New("UIScale", { Scale = 1, Parent = B.Base })

    local TextColor = B.Primary and "AccentText" or (B.Risky and "Red" or "Text")
    local GlyphSize = UDim2.fromOffset(math.max(10, math.floor(SizeN * 0.45)), math.max(10, math.floor(SizeN * 0.45)))
    local IconData = Library:GetCustomIcon(B.Icon)
    if IconData then
        B.Glyph = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = GlyphSize, ImageColor3 = TextColor, Parent = B.Base })
        Library:ApplyIcon(B.Glyph, IconData)
    else
        local Letter = B.Text ~= "" and string.upper(string.sub(B.Text, 1, 1)) or "●"
        B.Glyph = Glyph(B.Base, B.Icon, Letter, { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = GlyphSize, Color = TextColor })
    end

    local function Colors(Hover)
        if B.Primary then
            return Hover and Lighten(Library.Scheme.Accent, 0.07) or Library.Scheme.Accent
        end
        return Hover and Library.Scheme.ControlHover or Library.Scheme.Control
    end

    function B:UpdateColors()
        B.Stroke.Transparency = B.Disabled and 0.8 or 0.55
        B.Base.BackgroundTransparency = B.Disabled and 0.5 or 0
        local GT = B.Disabled and 0.55 or 0
        if B.Glyph then
            if B.Glyph:IsA("ImageLabel") then B.Glyph.ImageTransparency = GT else B.Glyph.TextTransparency = GT end
        end
    end
    function B:SetDisabled(D) B.Disabled = D; B:UpdateColors(); Library:UpdateAddons(B) end
    function B:SetText(T) B.Text = T end

    table.insert(B.Connections, B.Base.MouseEnter:Connect(function()
        if not B.Disabled then
            Tween(B.Base, { BackgroundColor3 = Colors(true) })
            Tween(BtnScale, { Scale = 1.07 }, Library.TweenInfo)
        end
    end))
    table.insert(B.Connections, B.Base.MouseLeave:Connect(function()
        if not B.Disabled then
            Tween(B.Base, { BackgroundColor3 = Colors(false) })
            Tween(BtnScale, { Scale = 1 }, Library.TweenInfo)
        end
    end))
    table.insert(B.Connections, B.Base.MouseButton1Down:Connect(function()
        if not B.Disabled then
            Tween(B.Base, { BackgroundColor3 = Lighten(Colors(false), B.Primary and -0.06 or 0.08) })
            Tween(BtnScale, { Scale = 0.94 }, Library.TweenInfo)
        end
    end))
    table.insert(B.Connections, B.Base.MouseButton1Up:Connect(function()
        if not B.Disabled then Tween(BtnScale, { Scale = 1 }, Library.TweenInfo) end
    end))
    table.insert(B.Connections, B.Base.MouseButton1Click:Connect(function()
        if B.Disabled or B.Locked then return end
        Library:SafeCallback(B.Func)
    end))

    B.AddonHolder = Holder
    B.TextLabel = B.Base
    B:UpdateColors()
    if typeof(Info.Tooltip) == "string" then Library:AddTooltip(Info.Tooltip, B.Base) end
    setmetatable(B, BaseAddons)
    Holder.Visible = B.Visible
    Finalize(Group, B, Holder, Buttons, Idx, { Tooltip = Info.Tooltip })
    return B
end

--// Toggle / Checkbox \\--
function Funcs:AddToggle(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.Toggle)
    local Group = self
    local BaseStyle = (Library.ForceCheckbox or Info.Checkbox) and "Checkbox" or "Switch"

    local Toggle = {
        Type = "Toggle", Text = Info.Text, Value = Info.Default == true, Callback = Info.Callback, Changed = Info.Changed,
        Risky = Info.Risky, Disabled = Info.Disabled, Visible = Info.Visible, Addons = {}, AnyKeyPickerPicking = false, Connections = {},
    }

    local Row = MakeRow(Group, 22, true)
    Row.Visible = Toggle.Visible
    local Click = Row
    local Label = New("TextLabel", { Size = UDim2.new(0, 0, 1, 0), Text = Library:ToRichText(Toggle.Text), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Toggle.Risky and "Red" or "Text", LayoutOrder = 1, Parent = Row })
    Toggle.LabelObj = Label
    Flex(Label)
    Toggle.AddonHolder = MakeAddonHolder(Row)
    Toggle.TextLabel = Label

    local Switch, Knob, Check, SwitchBox = nil, nil, nil, false
    -- The control is rebuilt from scratch when the skin changes style
    local function BuildToggleControl()
        if Switch then
            Switch:Destroy()
            Switch, Knob, Check = nil, nil, nil
        end
        local ST = Library:SkinToggle()
        local BoxSize = ST.BoxSize or 18
        -- box styles draw a filled square instead of an iOS switch
        SwitchBox = BaseStyle == "Checkbox" or ST.Style == "Box"
        if not SwitchBox then
            Switch = New("Frame", { BackgroundColor3 = "Track", Size = UDim2.fromOffset(34, 20), LayoutOrder = 3, Parent = Row })
            Corner(Switch, 99)
            Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(16, 16), Parent = Switch })
            Corner(Knob, 99)
            Stroke(Knob, Color3.new(0, 0, 0), 1, 0.88)
        else
            Switch = New("Frame", { BackgroundColor3 = "Control", Size = UDim2.fromOffset(BoxSize, BoxSize), LayoutOrder = 3, Parent = Row })
            Corner(Switch, 5)
            Stroke(Switch, "Outline", 1, 0.2)
            Check = Glyph(Switch, "check", "✓", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 12), Color = "AccentText" })
            -- square "LED" styles have no tick: the filled color carries the state
            Check.Visible = ST.CheckGlyph ~= false
            if ST.CheckGlyph ~= false then GlyphTransparency(Check, 1) end
        end
        if Toggle.Display then Toggle:Display(true) end
    end

    function Toggle:Display(Instant)
        if Library.Unloaded or not Switch then return end
        local On = Toggle.Value
        local Dim = Toggle.Disabled and 0.55 or 0
        if not SwitchBox then
            Anim(Switch, { BackgroundColor3 = On and Library.Scheme.Accent or Library.Scheme.Track, BackgroundTransparency = Dim }, Instant)
            Bind(Switch, "BackgroundColor3", On and "Accent" or "Track")
            Anim(Knob, { Position = On and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), BackgroundTransparency = Dim }, Instant)
        else
            Anim(Switch, { BackgroundColor3 = On and Library.Scheme.Accent or Library.Scheme.Control, BackgroundTransparency = Dim }, Instant)
            Bind(Switch, "BackgroundColor3", On and "Accent" or "Control")
            if Check and Check.Visible then GlyphTransparency(Check, On and Dim or 1) end
        end
        Anim(Label, { TextTransparency = Toggle.Disabled and 0.55 or 0 }, Instant)
    end

    function Toggle:ApplySkin() BuildToggleControl() end

    function Toggle:OnChanged(F) Toggle.Changed = F end
    function Toggle:RunChanged()
        if Toggle.Disabled then return end
        Library:SafeCallback(Toggle.Callback, Toggle.Value)
        Library:SafeCallback(Toggle.Changed, Toggle.Value)
    end
    function Toggle:SetValue(V)
        V = V == true
        if V == Toggle.Value then return end
        Toggle.Value = V
        Toggle:Display()
        for _, A in Toggle.Addons do
            if A.Type == "KeyPicker" and A.SyncToggleState then
                A.Toggled = V
                A:Update()
            end
        end
        if not Toggle.Disabled then Library:UpdateDependencyBoxes() end
        if not Toggle.AnyKeyPickerPicking then Toggle:RunChanged() end
    end
    function Toggle:SetDisabled(D)
        Toggle.Disabled = D
        Click.Active = not D
        Toggle:Display()
        Library:UpdateAddons(Toggle)
        Library:UpdateDependencyBoxes()
    end
    function Toggle:SetText(T) Toggle.Text = T; Label.Text = Library:ToRichText(T) end

    table.insert(Toggle.Connections, Click.MouseButton1Click:Connect(function()
        if not Toggle.Disabled then Toggle:SetValue(not Toggle.Value) end
    end))

    BuildToggleControl()
    Toggle:Display(true)
    Toggle.Default = Toggle.Value
    setmetatable(Toggle, BaseAddons)
    Finalize(Group, Toggle, Row, Toggles, Idx, Info)
    return Toggle
end

function Funcs:AddCheckbox(Idx, Info)
    Info = Info or {}
    Info.Checkbox = true
    return Funcs.AddToggle(self, Idx, Info)
end

--// Input \\--
function Funcs:AddInput(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    if typeof(Info) == "table" and typeof(Info.VerifyValue) == "function" then Info.Finished = true end
    Info = Library:Validate(Info, Templates.Input)
    local Group = self

    local Input = {
        Type = "Input", Text = Info.Text, Value = Info.Default, Finished = Info.Finished, Numeric = Info.Numeric,
        AllowEmpty = Info.AllowEmpty, EmptyReset = Info.EmptyReset, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Input.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Library:ToRichText(Input.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Holder })
    Input.LabelObj = Label
    local Box = New("TextBox", {
        BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Text = Input.Value,
        PlaceholderText = Info.Placeholder, ClearTextOnFocus = Info.ClearTextOnFocus, TextXAlignment = Enum.TextXAlignment.Left,
        TextEditable = not Input.Disabled, ClipsDescendants = true, Parent = Holder,
    })
    Corner(Box, 7)
    Pad(Box, 0, 10, 0, 10)
    local BoxStroke = Stroke(Box, "Outline", 1, 0.4)

    function Input:UpdateColors()
        Label.TextTransparency = Input.Disabled and 0.55 or 0
        Box.TextTransparency = Input.Disabled and 0.55 or 0
    end
    function Input:OnChanged(F) Input.Changed = F end
    function Input:RunChanged()
        if Input.Disabled then return end
        Library:SafeCallback(Input.Callback, Input.Value)
        Library:SafeCallback(Input.Changed, Input.Value)
    end
    function Input:SetValue(Text, FromTyping)
        Text = tostring(Text)
        if not Input.AllowEmpty and Trim(Text) == "" and not FromTyping then Text = Input.EmptyReset end
        if Info.MaxLength and #Text > Info.MaxLength then Text = Text:sub(1, Info.MaxLength) end
        -- Numeric: reject only truly invalid strings; allow intermediate states like "-" or "1." while typing.
        if Input.Numeric and #Text > 0 and not Text:match("^%-?%d*%.?%d*$") then Text = tostring(Input.Value) end
        if typeof(Info.VerifyValue) == "function" and Text ~= Input.EmptyReset and Info.VerifyValue(Text) ~= true then
            Text = Input.EmptyReset
        end
        if Input.Numeric and tonumber(Text) then Input._GoodValue = Text end
        Input.Value = Text
        Box.Text = Text
        Input:RunChanged()
    end
    function Input:SetDisabled(D)
        Input.Disabled = D
        Box.TextEditable = not D
        Input:UpdateColors()
    end
    function Input:SetText(T) Input.Text = T; Label.Text = Library:ToRichText(T) end

    if Input.Finished then
        table.insert(Input.Connections, Box.FocusLost:Connect(function(Enter)
            if Enter then Input:SetValue(Box.Text) else Box.Text = Input.Value end
        end))
    else
        table.insert(Input.Connections, Box:GetPropertyChangedSignal("Text"):Connect(function()
            if Input._Typing then return end
            if Box.Text ~= Input.Value then Input:SetValue(Box.Text, true) end
        end))
    end
    table.insert(Input.Connections, Box.Focused:Connect(function()
        if Input.Disabled then return end
        Bind(BoxStroke, "Color", "Accent")
        Tween(BoxStroke, { Color = Library.Scheme.Accent, Transparency = 0, Thickness = 1.5 })
    end))
    table.insert(Input.Connections, Box.FocusLost:Connect(function()
        if Input.Numeric and not tonumber(Input.Value) then
            Input:SetValue(Input._GoodValue ~= nil and Input._GoodValue or (Input.AllowEmpty and "" or Input.EmptyReset))
        elseif not Input.AllowEmpty and Trim(Input.Value) == "" and Input.Value ~= Input.EmptyReset then
            Input:SetValue(Input.EmptyReset)
        end
        Bind(BoxStroke, "Color", "Outline")
        Tween(BoxStroke, { Color = Library.Scheme.Outline, Transparency = 0.4, Thickness = 1 })
    end))

    --// typing animations: animated placeholder + Input:Type(text)
    local function UtfLen(Str) return utf8.len(Str) or #Str end
    local function UtfSub(Str, N)
        if N <= 0 then return "" end
        if N >= UtfLen(Str) then return Str end
        local Off = utf8.offset(Str, N + 1)
        return Off and Str:sub(1, Off - 1) or Str
    end

    local Phrases = Info.Placeholders
    if typeof(Phrases) ~= "table" or #Phrases == 0 then
        Phrases = (Info.AnimatePlaceholder and Info.Placeholder ~= "") and { Info.Placeholder } or nil
    end
    if Phrases then
        local Speed = Info.PlaceholderSpeed or 0.055
        local Static = Info.Placeholder ~= "" and Info.Placeholder or tostring(Phrases[1])
        local function CanAnimate()
            return not Input.Destroyed and not Library.Unloaded and Box.Parent ~= nil and IsShown(Box)
                and Box.Text == "" and not Box:IsFocused() and Library.Toggled
        end
        task.spawn(function()
            local I = 1
            while not Input.Destroyed and not Library.Unloaded do
                local Phrase = tostring(Phrases[I])
                local N = UtfLen(Phrase)
                for C = 1, N do
                    if not CanAnimate() then break end
                    Box.PlaceholderText = UtfSub(Phrase, C) .. "|"
                    task.wait(Speed)
                end
                if CanAnimate() then
                    for B = 1, 6 do
                        if not CanAnimate() then break end
                        Box.PlaceholderText = Phrase .. (B % 2 == 0 and "|" or "")
                        task.wait(0.25)
                    end
                    for C = N - 1, 0, -1 do
                        if not CanAnimate() then break end
                        Box.PlaceholderText = UtfSub(Phrase, C) .. "|"
                        task.wait(Speed * 0.5)
                    end
                end
                if not CanAnimate() then
                    Box.PlaceholderText = Static
                    repeat task.wait(0.25) until Input.Destroyed or Library.Unloaded or CanAnimate()
                end
                I = I % #Phrases + 1
            end
        end)
    end

    function Input:Type(Text, Speed)
        Text = tostring(Text)
        Speed = Speed or 0.04
        Input._TypeId = (Input._TypeId or 0) + 1
        local Id = Input._TypeId
        task.spawn(function()
            Input._Typing = true
            Box.Text = ""
            for C = 1, UtfLen(Text) do
                if Input.Destroyed or Input._TypeId ~= Id then return end
                Box.Text = UtfSub(Text, C)
                task.wait(Speed)
            end
            Input._Typing = false
            if not Input.Destroyed then Input:SetValue(Text) end
        end)
    end

    Input.Default = Input.Value
    Input:UpdateColors()
    Finalize(Group, Input, Holder, Options, Idx, Info)
    return Input
end

--// Slider \\--
function Funcs:AddNestedGroupbox(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Name, Info
    if typeof(First) == "table" then
        Info = First
        Name = Info.Name or Info.Text or "Section"
    else
        Name = First or "Section"
        Info = (typeof(Second) == "table" and Second) or {}
    end
    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Group.Container })
    List(Holder, 6)

    local Head = New("TextButton", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), Parent = Holder })
    local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(13, 13), Color = "SubText" })
    New("TextLabel", { Position = UDim2.fromOffset(20, 0), Size = UDim2.new(1, -24, 1, 0), Text = Library:ToRichText(Name), TextXAlignment = Enum.TextXAlignment.Left, TextSize = 13, FontFace = "FontBold", TextTruncate = Enum.TextTruncate.AtEnd, Parent = Head })

    local BodyWrap = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Holder })
    local Body = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -14, 0, 0), Parent = BodyWrap })
    List(Body, 8)
    local Rail = New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.35, Position = UDim2.fromOffset(4, 2), Size = UDim2.new(0, 2, 1, -4), Parent = BodyWrap })
    Corner(Rail, 99)

    local Nested = {
        Type = "NestedGroupbox", Name = Name, Visible = true, Collapsed = false,
        Holder = Holder, Container = Body, Elements = {}, DependencyBoxes = {},
        Tab = Group.Tab, Connections = {},
    }

    function Nested:SetCollapsed(C)
        Nested.Collapsed = C == true
        BodyWrap.Visible = not Nested.Collapsed
        Tween(Arrow, { Rotation = Nested.Collapsed and -90 or 0 }, Library.SlowTween)
        if Library.KickScrolls then task.defer(Library.KickScrolls) end
    end
    function Nested:ToggleCollapsed() Nested:SetCollapsed(not Nested.Collapsed) end
    function Nested:SetVisible(V)
        Nested.Visible = V ~= false
        Holder.Visible = Nested.Visible
        if Library.Searching then Library:UpdateSearch(Library.SearchText) end
        if Library.KickScrolls then task.defer(Library.KickScrolls) end
    end
    function Nested:Show() Nested:SetVisible(true) end
    function Nested:Hide() Nested:SetVisible(false) end
    function Nested:Resize() end
    function Nested:Destroy()
        Nested.Destroyed = true
        for I = #Nested.Elements, 1, -1 do Nested.Elements[I]:Destroy() end
        Holder:Destroy()
    end

    Head.MouseButton1Click:Connect(function() Nested:ToggleCollapsed() end)
    setmetatable(Nested, BaseGroupbox)
    if Info.Collapsed then Nested:SetCollapsed(true) end
    return Nested
end

function Funcs:AddSlider(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.Slider)
    local Group = self

    local Slider = {
        Type = "Slider", Text = Info.Text, Value = Info.Default, Min = Info.Min, Max = Info.Max, Rounding = Info.Rounding,
        Prefix = Info.Prefix, Suffix = Info.Suffix, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Slider.Visible, Parent = Group.Container })
    List(Holder, 4)
    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16), Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(0.6, 0, 1, 0), Text = Library:ToRichText(Slider.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    Slider.LabelObj = Label
    local ValueBox = New("TextBox", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.4, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", ClearTextOnFocus = false, Text = "", Parent = Top,
    })
    local SkinSlider = Library:SkinSlider()
    -- knob is taller than the track so it visibly sticks out of it; knob-less skins set KS to 0
    local KS = if SkinSlider.Knob == false then 0 else 18
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, SkinSlider.Area or 30), ClipsDescendants = false, Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, SkinSlider.TrackHeight or 12), ClipsDescendants = false, Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)
    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0.5, 1), Parent = Track })
    Corner(FillBar, 99)
    local Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(KS, KS), Visible = KS > 0, ZIndex = 3, Parent = Area })
    Corner(Knob, 99)
    Stroke(Knob, Color3.new(0, 0, 0), 1, 0.8)

    -- thin tracks / knob-less handles come from the skin and can change while the UI is live
    function Slider:ApplySkin()
        local SS = Library:SkinSlider()
        KS = if SS.Knob == false then 0 else 18
        Area.Size = UDim2.new(1, 0, 0, SS.Area or 30)
        Track.Size = UDim2.new(1, 0, 0, SS.TrackHeight or 12)
        Knob.Size = UDim2.fromOffset(KS, KS)
        Knob.Visible = KS > 0
        Slider:Display()
    end

    local function Format(V)
        local N = Slider.Rounding > 0 and string.format("%." .. Slider.Rounding .. "f", V) or tostring(V)
        return Slider.Prefix .. N .. Slider.Suffix
    end

    function Slider:Display()
        if Library.Unloaded then return end
        local X = (Slider.Value - Slider.Min) / math.max(Slider.Max - Slider.Min, 1e-9)
        FillBar.Size = UDim2.new(X, (0.5 - X) * KS, 1, 0)
        Knob.Position = UDim2.new(X, (0.5 - X) * KS, 0.5, 0)
        ValueBox.Text = Info.FormatDisplayValue and tostring(Info.FormatDisplayValue(Slider, Slider.Value)) or Format(Slider.Value)
        local D = Slider.Disabled and 0.55 or 0
        Label.TextTransparency, ValueBox.TextTransparency = D, D
        FillBar.BackgroundColor3 = Slider.Disabled and Library.Scheme.Outline or Library.Scheme.SliderFill
        Bind(FillBar, "BackgroundColor3", Slider.Disabled and "Outline" or "SliderFill")
    end
    function Slider:OnChanged(F) Slider.Changed = F end
    function Slider:RunChanged()
        if Slider.Disabled then return end
        Library:SafeCallback(Slider.Callback, Slider.Value)
        Library:SafeCallback(Slider.Changed, Slider.Value)
    end
    function Slider:SetValue(V)
        V = tonumber(V)
        if not V then return end
        V = Round(math.clamp(V, Slider.Min, Slider.Max), Slider.Rounding)
        if V == Slider.Value then Slider:Display() return end
        Slider.Value = V
        Slider:Display()
        Slider:RunChanged()
    end
    function Slider:SetMax(V) Slider.Max = V; Slider:SetValue(math.clamp(Slider.Value, Slider.Min, V)); Slider:Display() end
    function Slider:SetMin(V) Slider.Min = V; Slider:SetValue(math.clamp(Slider.Value, V, Slider.Max)); Slider:Display() end
    function Slider:SetDisabled(D) Slider.Disabled = D; Area.Active = not D; ValueBox.TextEditable = not D; Slider:Display() end
    function Slider:SetText(T) Slider.Text = T; Label.Text = Library:ToRichText(T) end
    function Slider:SetPrefix(P) Slider.Prefix = P; Slider:Display() end
    function Slider:SetSuffix(S) Slider.Suffix = S; Slider:Display() end

    table.insert(Slider.Connections, ValueBox.FocusLost:Connect(function()
        local N = tonumber((ValueBox.Text:gsub("[^%d%.%-]", "")))
        if N then Slider:SetValue(N) else Slider:Display() end
    end))
    table.insert(Slider.Connections, ValueBox.Focused:Connect(function() ValueBox.Text = tostring(Slider.Value) end))

    local function ApplySliderPos(Pos)
        local K = math.max(Knob.AbsoluteSize.X, 1)
        local X = (Pos.X - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
        local V = Round(Slider.Min + (Slider.Max - Slider.Min) * math.clamp(X, 0, 1), Slider.Rounding)
        if V == Slider.Value then return false end
        Slider.Value = V
        Slider:Display()
        if not Info.Deferred then Slider:RunChanged() end
        return true
    end
    BindPointerDrag(Area, Slider, function(Pos)
        return ApplySliderPos(Pos)
    end, function(Pos)
        ApplySliderPos(Pos)
        if Info.Deferred then Slider:RunChanged() end
    end, function(Moved)
        if Info.Deferred and Moved then Slider:RunChanged() end
    end)

    Slider.Default = Slider.Value
    Slider:Display()
    Finalize(Group, Slider, Holder, Options, Idx, Info)
    return Slider
end

--// Range slider (dual-thumb min/max) \\--
function Funcs:AddRangeSlider(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.RangeSlider)
    local Group = self

    local Def = Info.Default
    local Low, High = Info.Min, Info.Max
    if typeof(Def) == "table" then
        Low = tonumber(Def[1] or Def.Min or Def.Low) or Info.Min
        High = tonumber(Def[2] or Def.Max or Def.High) or Info.Max
    end
    Low = Round(math.clamp(Low, Info.Min, Info.Max), Info.Rounding)
    High = Round(math.clamp(math.max(Low, High), Info.Min, Info.Max), Info.Rounding)

    local RS = {
        Type = "RangeSlider", Text = Info.Text, Min = Info.Min, Max = Info.Max, Rounding = Info.Rounding,
        Prefix = Info.Prefix, Suffix = Info.Suffix, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
        Value = { Low, High }, ValueMin = Low, ValueMax = High,
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = RS.Visible, Parent = Group.Container })
    List(Holder, 4)
    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16), Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(0.55, 0, 1, 0), Text = Library:ToRichText(RS.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    RS.LabelObj = Label
    local ValueLbl = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.45, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", Text = "", Parent = Top,
    })
    local SkinSlider = Library:SkinSlider()
    local KS = if SkinSlider.Knob == false then 0 else 18
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, SkinSlider.Area or 30), ClipsDescendants = false, Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, SkinSlider.TrackHeight or 12), Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)
    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0.5, 1), Parent = Track })
    Corner(FillBar, 99)

    local function MakeKnob()
        local Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(KS, KS), Visible = KS > 0, ZIndex = 3, Parent = Area })
        Corner(Knob, 99)
        Stroke(Knob, Color3.new(0, 0, 0), 1, 0.8)
        return Knob
    end
    local KnobL = MakeKnob()
    local KnobR = MakeKnob()

    function RS:ApplySkin()
        local SS = Library:SkinSlider()
        KS = if SS.Knob == false then 0 else 18
        Area.Size = UDim2.new(1, 0, 0, SS.Area or 30)
        Track.Size = UDim2.new(1, 0, 0, SS.TrackHeight or 12)
        for _, K in { KnobL, KnobR } do
            K.Size = UDim2.fromOffset(KS, KS)
            K.Visible = KS > 0
        end
        RS:Display()
    end

    local function Format(V)
        local N = RS.Rounding > 0 and string.format("%." .. RS.Rounding .. "f", V) or tostring(V)
        return RS.Prefix .. N .. RS.Suffix
    end
    local function Span() return math.max(RS.Max - RS.Min, 1e-9) end
    local function XOf(V) return (V - RS.Min) / Span() end

    function RS:Display()
        if Library.Unloaded then return end
        local XL, XR = XOf(RS.ValueMin), XOf(RS.ValueMax)
        FillBar.Position = UDim2.new(XL, (0.5 - XL) * KS, 0, 0)
        FillBar.Size = UDim2.new(XR - XL, (XL - XR) * KS, 1, 0)
        local function Place(Knob, X)
            Knob.Position = UDim2.new(X, (0.5 - X) * KS, 0.5, 0)
        end
        Place(KnobL, XL)
        Place(KnobR, XR)
        ValueLbl.Text = Format(RS.ValueMin) .. "  –  " .. Format(RS.ValueMax)
        local D = RS.Disabled and 0.55 or 0
        Label.TextTransparency, ValueLbl.TextTransparency = D, D
        FillBar.BackgroundColor3 = RS.Disabled and Library.Scheme.Outline or Library.Scheme.SliderFill
        Bind(FillBar, "BackgroundColor3", RS.Disabled and "Outline" or "SliderFill")
    end
    function RS:OnChanged(F) RS.Changed = F end
    function RS:RunChanged()
        if RS.Disabled then return end
        Library:SafeCallback(RS.Callback, RS.ValueMin, RS.ValueMax)
        Library:SafeCallback(RS.Changed, RS.ValueMin, RS.ValueMax)
    end
    function RS:SetValue(A, B)
        if typeof(A) == "table" then B = A[2] or A.Max or A.High; A = A[1] or A.Min or A.Low end
        A, B = tonumber(A), tonumber(B)
        if not A or not B then return end
        A = Round(math.clamp(A, RS.Min, RS.Max), RS.Rounding)
        B = Round(math.clamp(B, RS.Min, RS.Max), RS.Rounding)
        if A > B then A, B = B, A end
        if A == RS.ValueMin and B == RS.ValueMax then RS:Display() return end
        RS.ValueMin, RS.ValueMax = A, B
        RS.Value = { A, B }
        RS:Display()
        RS:RunChanged()
    end
    function RS:SetMin(V) RS.Min = V; RS:SetValue(math.max(RS.ValueMin, V), math.max(RS.ValueMax, V)) end
    function RS:SetMax(V) RS.Max = V; RS:SetValue(math.min(RS.ValueMin, V), math.min(RS.ValueMax, V)) end
    function RS:SetDisabled(D) RS.Disabled = D; Area.Active = not D; RS:Display() end
    function RS:SetText(T) RS.Text = T; Label.Text = Library:ToRichText(T) end

    local ActiveKnob = nil
    local function PickKnob(MX)
        local K = math.max(KnobL.AbsoluteSize.X, 1)
        local Rel = (MX - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
        local At = RS.Min + Span() * math.clamp(Rel, 0, 1)
        local DistL = math.abs(At - RS.ValueMin)
        local DistR = math.abs(At - RS.ValueMax)
        return DistL <= DistR and "L" or "R"
    end
    local function ApplyRangePos(Pos)
        if not ActiveKnob then ActiveKnob = PickKnob(Pos.X) end
        local K = math.max(KnobL.AbsoluteSize.X, 1)
        local Rel = (Pos.X - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
        local V = Round(RS.Min + Span() * math.clamp(Rel, 0, 1), RS.Rounding)
        if ActiveKnob == "L" then
            V = math.min(V, RS.ValueMax)
            if V == RS.ValueMin then return false end
            RS.ValueMin = V
        else
            V = math.max(V, RS.ValueMin)
            if V == RS.ValueMax then return false end
            RS.ValueMax = V
        end
        RS.Value = { RS.ValueMin, RS.ValueMax }
        RS:Display()
        if not Info.Deferred then RS:RunChanged() end
        return true
    end
    BindPointerDrag(Area, RS, function(Pos, Session)
        if not ActiveKnob then ActiveKnob = PickKnob(Session.Start.X) end
        return ApplyRangePos(Pos)
    end, function(Pos)
        ActiveKnob = PickKnob(Pos.X)
        ApplyRangePos(Pos)
        if Info.Deferred then RS:RunChanged() end
        ActiveKnob = nil
    end, function(Moved)
        if Info.Deferred and Moved then RS:RunChanged() end
        ActiveKnob = nil
    end)

    RS.Default = { RS.ValueMin, RS.ValueMax }
    RS:Display()
    Finalize(Group, RS, Holder, Options, Idx, Info)
    return RS
end

--// List (always-visible selectable list; dropdown without a popup) \\--
function Funcs:AddList(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.List)
    local Group = self

    local LS = {
        Type = "List", Text = typeof(Info.Text) == "string" and Info.Text or nil, Values = Info.Values,
        DisabledValues = Info.DisabledValues, Multi = Info.Multi, AllowNull = Info.AllowNull ~= false,
        Height = Info.Height, MaxVisibleItems = Info.MaxVisibleItems,
        Callback = Info.Callback, Changed = Info.Changed, Disabled = Info.Disabled, Visible = Info.Visible,
        Value = Info.Multi and {} or nil, Connections = {},
    }

    local function HasIcons()
        for _, Raw in LS.Values do
            if typeof(Raw) == "table" and (Raw.Icon ~= nil or Raw[3] ~= nil) then return true end
        end
        return false
    end
    LS.Extended = Info.Extended
    if LS.Extended == nil then LS.Extended = HasIcons() end

    local function GetItems()
        local Out = {}
        local Arr = IsArray(LS.Values)
        for K, Raw in LS.Values do
            local Item
            if typeof(Raw) == "table" and (Raw.Name ~= nil or Raw[1] ~= nil) then
                local Name = Raw.Name ~= nil and Raw.Name or Raw[1]
                local Val = Raw.Value ~= nil and Raw.Value or Raw[2]
                if Val == nil then Val = Name end
                Item = { Value = Val, Display = tostring(Name), Icon = Raw.Icon ~= nil and Raw.Icon or Raw[3] }
            else
                Item = { Value = Arr and Raw or K, Display = tostring(Raw) }
            end
            Item.Disabled = table.find(LS.DisabledValues, Item.Value) ~= nil
            table.insert(Out, Item)
        end
        if not Arr then table.sort(Out, function(A, B) return A.Display < B.Display end) end
        return Out
    end
    local function IsSelected(Val)
        if LS.Multi then return LS.Value[Val] == true end
        return LS.Value == Val
    end

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = LS.Visible, Parent = Group.Container })
    List(Holder, 5)
    local TitleRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), Visible = LS.Text ~= nil or LS.Extended, Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(1, LS.Extended and -28 or 0, 1, 0), Text = Library:ToRichText(LS.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = LS.Text ~= nil, Parent = TitleRow })
    LS.LabelObj = Label
    local ExpandBtn = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(22, 22),
        Visible = LS.Extended, Parent = TitleRow,
    })
    Glyph(ExpandBtn, "maximize-2", "⤢", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13) })

    local Frame = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, LS.Height), ClipsDescendants = true, Parent = Holder })
    Corner(Frame, 8)
    Stroke(Frame, "Outline", 1, 0.55)
    local Scroll = New("ScrollingFrame", {
        BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3, Parent = Frame,
    })
    Pad(Scroll, 4, 4, 4, 4)
    List(Scroll, 2)
    local RowRefs = {}

    function LS:Display()
        if Library.Unloaded then return end
        for _, R in RowRefs do
            local Sel = IsSelected(R.Value)
            R.Btn.BackgroundTransparency = Sel and 0 or 1
            R.Btn.BackgroundColor3 = Sel and Library.Scheme.Accent or Library.Scheme.ControlHover
            Bind(R.Btn, "BackgroundColor3", Sel and "Accent" or "ControlHover")
            R.Lbl.TextColor3 = Sel and Library.Scheme.AccentText or Library.Scheme.Text
            Bind(R.Lbl, "TextColor3", Sel and "AccentText" or "Text")
            if R.IconImg then
                R.IconImg.ImageColor3 = Sel and Library.Scheme.AccentText or Library.Scheme.Text
            end
        end
        local D = LS.Disabled and 0.55 or 0
        Label.TextTransparency = D
        Frame.BackgroundTransparency = LS.Disabled and 0.4 or 0
    end

    local function Rebuild()
        for _, C in Scroll:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end
        RowRefs = {}
        for _, It in GetItems() do
            local Row = New("TextButton", {
                BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28),
                AutoButtonColor = false, Parent = Scroll,
            })
            Corner(Row, 6)
            local IconWrap
            if It.Icon ~= nil then
                IconWrap = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 4), Size = UDim2.fromOffset(20, 20), Parent = Row })
            end
            local Lbl = New("TextLabel", {
                Position = UDim2.fromOffset(It.Icon ~= nil and 30 or 10, 0), Size = UDim2.new(1, It.Icon ~= nil and -36 or -16, 1, 0),
                Text = It.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row,
            })
            local IconImg
            if IconWrap then
                local Data = Library:GetCustomIcon(It.Icon)
                if Data then
                    IconImg = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconWrap })
                    Library:ApplyIcon(IconImg, Data)
                end
            end
            local Ref = { Btn = Row, Lbl = Lbl, Value = It.Value, IconImg = IconImg }
            table.insert(RowRefs, Ref)
            if not It.Disabled then
                Row.MouseButton1Click:Connect(function()
                    if LS.Disabled then return end
                    if LS.Multi then
                        LS.Value[It.Value] = not LS.Value[It.Value] or nil
                        if LS.Value[It.Value] == nil then LS.Value[It.Value] = nil end
                        if not LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                        -- toggle properly
                        if IsSelected(It.Value) then
                            LS.Value[It.Value] = nil
                        else
                            LS.Value[It.Value] = true
                        end
                    else
                        if LS.Value == It.Value and LS.AllowNull then
                            LS.Value = nil
                        else
                            LS.Value = It.Value
                        end
                    end
                    LS:Display()
                    Library:SafeCallback(LS.Callback, LS.Value)
                    Library:SafeCallback(LS.Changed, LS.Value)
                end)
            else
                Lbl.TextTransparency = 0.5
            end
        end
        LS:Display()
    end

    function LS:SetValues(V)
        LS.Values = V or {}
        if LS.Multi then
            local Keep = {}
            for Val in LS.Value do
                local Found = false
                for _, It in GetItems() do if It.Value == Val then Found = true break end end
                if Found then Keep[Val] = true end
            end
            LS.Value = Keep
        else
            local Found = false
            for _, It in GetItems() do if It.Value == LS.Value then Found = true break end end
            if not Found then LS.Value = nil end
        end
        Rebuild()
    end
    function LS:SetValue(V)
        if LS.Multi then
            LS.Value = {}
            if typeof(V) == "table" then
                if IsArray(V) then for _, X in V do LS.Value[X] = true end
                else for X, On in V do if On then LS.Value[X] = true end end end
            end
        else
            LS.Value = V
        end
        LS:Display()
        Library:SafeCallback(LS.Callback, LS.Value)
        Library:SafeCallback(LS.Changed, LS.Value)
    end
    function LS:GetActiveValues()
        if LS.Multi then
            local T = {}
            for V in LS.Value do table.insert(T, V) end
            return T
        end
        return LS.Value ~= nil and { LS.Value } or {}
    end
    function LS:SetDisabled(D) LS.Disabled = D; LS:Display() end
    function LS:SetText(T) LS.Text = T; Label.Text = Library:ToRichText(T or ""); Label.Visible = T ~= nil and T ~= "" end
    function LS:OnChanged(F) LS.Changed = F end

    -- cleaner row click wiring inside Rebuild
    local function RebuildClean()
        for _, C in Scroll:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end
        RowRefs = {}
        for _, It in GetItems() do
            local Row = New("TextButton", {
                BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28),
                AutoButtonColor = false, Parent = Scroll,
            })
            Corner(Row, 6)
            local hasIcon = It.Icon ~= nil
            local IconWrap = hasIcon and New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 4), Size = UDim2.fromOffset(20, 20), Parent = Row }) or nil
            local Lbl = New("TextLabel", {
                Position = UDim2.fromOffset(hasIcon and 30 or 10, 0), Size = UDim2.new(1, hasIcon and -36 or -16, 1, 0),
                Text = It.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row,
            })
            local IconImg
            if IconWrap then
                local Data = Library:GetCustomIcon(It.Icon)
                if Data then
                    IconImg = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconWrap })
                    Library:ApplyIcon(IconImg, Data)
                end
            end
            table.insert(RowRefs, { Btn = Row, Lbl = Lbl, Value = It.Value, IconImg = IconImg })
            if It.Disabled then
                Lbl.TextTransparency = 0.5
            else
                Row.MouseButton1Click:Connect(function()
                    if LS.Disabled then return end
                    if LS.Multi then
                        if LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                    else
                        if LS.Value == It.Value and LS.AllowNull then LS.Value = nil else LS.Value = It.Value end
                    end
                    LS:Display()
                    Library:SafeCallback(LS.Callback, LS.Value)
                    Library:SafeCallback(LS.Changed, LS.Value)
                end)
            end
        end
        local ItemH = 28 + 2
        local Count = math.min(#GetItems(), LS.MaxVisibleItems or 6)
        if Info.Height then
            Frame.Size = UDim2.new(1, 0, 0, Info.Height)
        else
            Frame.Size = UDim2.new(1, 0, 0, math.max(Count * ItemH + 8, 40))
        end
        LS:Display()
    end

    LS.SetValues = function(_, V)
        LS.Values = V or {}
        RebuildClean()
    end

    if Info.Default ~= nil then
        if LS.Multi then
            LS.Value = {}
            local D = Info.Default
            if typeof(D) == "table" then
                if IsArray(D) then for _, X in D do LS.Value[X] = true end
                else for X, On in D do if On then LS.Value[X] = true end end end
            end
        else
            LS.Value = Info.Default
        end
    elseif not LS.Multi and not LS.AllowNull then
        local Items = GetItems()
        if Items[1] then LS.Value = Items[1].Value end
    end

    local Modal
    function LS:CloseModal()
        if not Modal then return end
        local M = Modal
        Modal = nil
        if Library.CurrentModal == M then Library.CurrentModal = nil end
        Tween(M.Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
        Tween(M.Scale, { Scale = 0.95 }, Library.TweenInfo)
        task.delay(0.16, function() if M.Dim then M.Dim:Destroy() end end)
    end

    function LS:OpenModal()
        if LS.Disabled or Modal then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if Library.CurrentModal and Library.CurrentModal.Close then Library.CurrentModal:Close() end

        local Win = Library.Window
        local Host = Win and Win.MainFrame or Overlay
        local Real = Host.AbsoluteSize / (Host == Overlay and 1 or Library.DPIScale)
        local PW = math.clamp(Real.X - 70, 320, 660)
        local PH = math.clamp(Real.Y - 70, 280, 480)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = Host })
        if Win then Corner(Dim, Win.Info.CornerRadius) end
        Tween(Dim, { BackgroundTransparency = 0.45 }, Library.SlowTween)

        local Panel = New("Frame", {
            BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(PW, PH), ZIndex = 81, Parent = Dim,
        })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        Library:AddGlass(Panel)
        local PScale = New("UIScale", { Scale = 0.95, Parent = Panel })
        Tween(PScale, { Scale = 1 }, Library.SlowTween)

        New("TextLabel", {
            Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -110, 0, 22),
            Text = Library:ToRichText(LS.Text or "Select"), FontFace = "FontBold", TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Panel,
        })
        local Done = New("TextButton", {
            BackgroundColor3 = "Accent", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(64, 24),
            Text = LS.Multi and "Done" or "Close", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Panel,
        })
        Corner(Done, 99)

        local Search = New("TextBox", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search",
            Position = UDim2.fromOffset(16, 46), Size = UDim2.new(1, -32, 0, 30),
            TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Panel,
        })
        Corner(Search, 99)
        Pad(Search, 0, 12, 0, 14)

        local Grid = New("ScrollingFrame", {
            Position = UDim2.fromOffset(0, 86), Size = UDim2.new(1, 0, 1, -86),
            CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Panel,
        })
        New("UIGridLayout", {
            CellSize = UDim2.fromOffset(100, 118), CellPadding = UDim2.fromOffset(10, 10),
            SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Grid,
        })
        Pad(Grid, 4, 12, 16, 12)

        Modal = { Dim = Dim, Scale = PScale, Close = function() LS:CloseModal() end }
        Library.CurrentModal = Modal

        local function Build()
            for _, C in Grid:GetChildren() do
                if C:IsA("TextButton") then C:Destroy() end
            end
            local Q = NormalizeSearch(Search.Text)
            local N = 0
            for _, It in GetItems() do
                if Q == "" or Fuzzy(It.Display, Q) then
                    N += 1
                    local Cell = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, LayoutOrder = N, Parent = Grid })
                    Corner(Cell, 12)
                    local CStroke = Stroke(Cell, "Accent", 2, IsSelected(It.Value) and 0 or 1)
                    local IconBox = New("Frame", {
                        BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0),
                        Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.fromOffset(66, 66), Parent = Cell,
                    })
                    local Data = It.Icon and Library:GetCustomIcon(It.Icon)
                    if Data then
                        local Img = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconBox })
                        Library:ApplyIcon(Img, Data)
                    else
                        New("TextLabel", {
                            Size = UDim2.fromScale(1, 1), Text = It.Display:sub(1, 1):upper(),
                            FontFace = "FontBold", TextSize = 30, TextColor3 = "SubText", Parent = IconBox,
                        })
                    end
                    New("TextLabel", {
                        Position = UDim2.fromOffset(6, 80), Size = UDim2.new(1, -12, 0, 32), Text = It.Display,
                        TextSize = 11, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd,
                        TextTransparency = It.Disabled and 0.6 or 0, Parent = Cell,
                    })
                    local Badge = New("Frame", {
                        BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(18, 18),
                        Visible = IsSelected(It.Value), Parent = Cell,
                    })
                    Corner(Badge, 99)
                    New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = "✓", TextSize = 11, TextColor3 = "AccentText", FontFace = "FontBold", Parent = Badge })

                    if not It.Disabled then
                        Cell.MouseButton1Click:Connect(function()
                            if LS.Multi then
                                if LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                            else
                                if LS.Value == It.Value and LS.AllowNull then LS.Value = nil else LS.Value = It.Value end
                            end
                            LS:Display()
                            Library:SafeCallback(LS.Callback, LS.Value)
                            Library:SafeCallback(LS.Changed, LS.Value)
                            if LS.Multi then Build() else LS:CloseModal() end
                        end)
                    end
                end
            end
        end

        Search:GetPropertyChangedSignal("Text"):Connect(Build)
        Done.MouseButton1Click:Connect(function() LS:CloseModal() end)
        Dim.MouseButton1Click:Connect(function() LS:CloseModal() end)
        Build()
    end

    ExpandBtn.MouseButton1Click:Connect(function()
        if not LS.Disabled then LS:OpenModal() end
    end)

    RebuildClean()
    Finalize(Group, LS, Holder, Options, Idx, Info)
    local BaseDestroy = LS.Destroy
    function LS:Destroy()
        LS:CloseModal()
        if BaseDestroy then BaseDestroy(LS) end
    end
    return LS
end

--// Table (sortable, filterable, selectable, virtualised rows) \\--
-- Box:AddTable("Players", {
--     Text = "Players", Height = 220, Searchable = true, Selectable = true | "Multi",
--     Columns = { { Name = "Name", Width = 2 }, { Name = "Level", Align = "Center" }, "Status" },
--     Rows = { { Name = "Bob", Level = 5, Status = "Online" }, { "Ann", 9, { Text = "AFK", Color = Color3.fromRGB(255, 159, 10) } } },
--     Callback = function(Row, Index, Selected) end, DoubleClick = function(Row) end, RightClick = function(Row) end,
-- })
-- Cells accept: text / numbers / booleans / Color3 (swatch) / { Text, Color, Icon, Sort } / Column.Format(Value, Row) -> string
function Funcs:AddTable(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, {
        Columns = {}, Rows = {}, Height = 220, RowHeight = 28, Searchable = false, Sortable = true, Selectable = true,
        Striped = true, ShowHeader = true, ShowCount = true, EmptyText = "No data", Deselect = false,
        Callback = function() end, Changed = function() end, Disabled = false, Visible = true,
    })
    local Group = self
    local RH = Info.RowHeight

    local TB = {
        Type = "Table", Text = typeof(Info.Text) == "string" and Info.Text or nil, Columns = {}, Items = {}, View = {}, Selected = {},
        Counter = 0, SortColumn = nil, SortDir = 0, Search = "", Callback = Info.Callback, Changed = Info.Changed,
        DoubleClick = Info.DoubleClick, RightClick = Info.RightClick, Disabled = Info.Disabled, Visible = Info.Visible,
        Selectable = Info.Selectable ~= false, Multi = tostring(Info.Selectable):lower() == "multi", Connections = {},
    }

    --// helpers
    local function NormCols(Cols)
        local Out = {}
        for I, C in Cols do
            local Col = typeof(C) == "table" and table.clone(C) or { Name = tostring(C) }
            Col.Name = tostring(Col.Name or Col[1] or ("Column " .. I))
            Col.Key = Col.Key or Col.Name
            Col.Width = tonumber(Col.Width) or 1
            Col.Align = Col.Align or "Left"
            Col.Sortable = Col.Sortable ~= false
            Col.Index = I
            Out[I] = Col
        end
        return Out
    end
    local function CellOf(Row, Col)
        local V = Row[Col.Key]
        if V == nil then V = Row[Col.Index] end
        return V
    end
    local function CellText(V, Col, Row)
        if Col.Format then
            local Ok, R = pcall(Col.Format, V, Row)
            if Ok then return tostring(R) end
        end
        local T = typeof(V)
        if T == "table" then return tostring(V.Text or V[1] or "") end
        if T == "boolean" then return V and "✓" or "–" end
        if T == "Color3" then return "#" .. V:ToHex():upper() end
        if V == nil then return "" end
        return tostring(V)
    end
    local function SortKey(V)
        local T = typeof(V)
        if T == "table" then
            V = V.Sort ~= nil and V.Sort or (V.Value ~= nil and V.Value or V.Text)
            T = typeof(V)
        end
        if T == "boolean" then return V and 1 or 0 end
        if T == "Color3" then return V:ToHex() end
        if T == "number" then return V end
        return tostring(V or ""):lower()
    end
    local function ResolveRow(RowOrIndex)
        if typeof(RowOrIndex) == "number" then
            local It = TB.Items[RowOrIndex]
            return It and It.Data, RowOrIndex
        end
        for I, It in TB.Items do
            if It.Data == RowOrIndex then return It.Data, I end
        end
        return nil, nil
    end

    --// layout
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = TB.Visible, Parent = Group.Container })
    List(Holder, 6)

    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), Visible = TB.Text ~= nil or Info.Searchable, LayoutOrder = 1, Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(1, Info.Searchable and -150 or 0, 1, 0), Text = Library:ToRichText(TB.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = TB.Text ~= nil, Parent = Top })
    TB.LabelObj = Label
    local SearchBox
    if Info.Searchable then
        SearchBox = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(140, 24), PlaceholderText = "Filter", ClearTextOnFocus = false, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
        Corner(SearchBox, 99)
        Pad(SearchBox, 0, 10, 0, 12)
    end

    local Frame = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0.35, Size = UDim2.new(1, 0, 0, Info.Height), ClipsDescendants = true, LayoutOrder = 2, Parent = Holder })
    Corner(Frame, 9)
    Stroke(Frame, "Outline", 1, 0.5)
    Library:AddSurface(Frame, 0.35, 0.5)

    local HeaderH = Info.ShowHeader and 28 or 0
    local FooterH = Info.ShowCount and 22 or 0
    local Header = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HeaderH), Visible = Info.ShowHeader, Parent = Frame })
    New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = Header })

    local Body = New("ScrollingFrame", { Position = UDim2.fromOffset(0, HeaderH), Size = UDim2.new(1, 0, 1, -(HeaderH + FooterH)), CanvasSize = UDim2.new(), ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Frame })
    local Empty = New("TextLabel", { Position = UDim2.fromOffset(0, HeaderH), Size = UDim2.new(1, 0, 1, -(HeaderH + FooterH)), Text = Info.EmptyText, TextColor3 = "SubText", Visible = false, Parent = Frame })
    local Footer = New("TextLabel", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, FooterH), Text = "", TextSize = 11, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, Visible = Info.ShowCount, Parent = Frame })
    Pad(Footer, 0, 10, 0, 12)
    if Info.ShowCount then
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -FooterH), Size = UDim2.new(1, 0, 0, 1), Parent = Frame })
    end

    local function BodyHeight() return math.max(RH, Info.Height - HeaderH - FooterH) end

    --// header
    local function BuildHeader()
        for _, C in Header:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end
        local Total = 0
        for _, C in TB.Columns do Total += C.Width end
        local X = 0
        for _, C in TB.Columns do
            C.X, C.W = X / Total, C.Width / Total
            X += C.Width

            local H = New("TextButton", { Position = UDim2.fromScale(C.X, 0), Size = UDim2.new(C.W, 0, 1, -1), Parent = Header })
            local Align = Enum.TextXAlignment[C.Align] or Enum.TextXAlignment.Left
            local Text = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Library:ToRichText(C.Name):upper(), TextSize = 10, FontFace = "FontBold", TextColor3 = "SubText", TextXAlignment = Align, TextTruncate = Enum.TextTruncate.AtEnd, Parent = H })
            Pad(Text, 0, 18, 0, 10)
            local Arrow = New("TextLabel", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(10, 10), Text = "", TextSize = 8, TextColor3 = "Accent", Parent = H })
            C.Arrow = Arrow
            if Info.Sortable and C.Sortable then
                H.MouseEnter:Connect(function() Tween(Text, { TextColor3 = Library.Scheme.Text }) end)
                H.MouseLeave:Connect(function() Tween(Text, { TextColor3 = Library.Scheme.SubText }) end)
                H.MouseButton1Click:Connect(function()
                    if TB.Disabled then return end
                    if TB.SortColumn == C then
                        TB.SortDir = TB.SortDir == 1 and -1 or (TB.SortDir == -1 and 0 or 1)
                    else
                        TB.SortColumn, TB.SortDir = C, 1
                    end
                    TB:Refresh()
                end)
            end
        end
    end

    --// pooled rows
    local Pool = {}
    local function StyleRow(P, Hover)
        local Item = P.Item
        if not Item then return end
        local Sel = TB.Selected[Item.Data] == true
        local F = P.Frame
        if Sel then
            F.BackgroundColor3, F.BackgroundTransparency = Library.Scheme.Accent, 0.72
        elseif Hover and TB.Selectable and not TB.Disabled then
            F.BackgroundColor3, F.BackgroundTransparency = Library.Scheme.ControlHover, 0.45
        elseif Info.Striped and (Item.Order or P.Index) % 2 == 0 then
            F.BackgroundColor3, F.BackgroundTransparency = Library.Scheme.Segment, 0.88
        else
            F.BackgroundColor3, F.BackgroundTransparency = Library.Scheme.Control, 1
        end
        P.Bar.Visible = Sel
    end

    local function OnRowClick(P)
        if TB.Disabled or not P.Item then return end
        local Data = P.Item.Data
        if TB.Selectable then
            if TB.Multi then
                TB.Selected[Data] = (not TB.Selected[Data]) or nil
            elseif TB.Selected[Data] and Info.Deselect then
                TB.Selected = {}
            else
                TB.Selected = { [Data] = true }
            end
            TB:Render()
            Library:SafeCallback(TB.Callback, Data, P.Index, TB:GetSelected())
            Library:SafeCallback(TB.Changed, TB:GetSelected())
        end
        local Now = os.clock()
        if TB.DoubleClick and TB._LastRow == Data and Now - (TB._LastClick or 0) < 0.35 then
            Library:SafeCallback(TB.DoubleClick, Data, P.Index)
        end
        TB._LastRow, TB._LastClick = Data, Now
    end

    local function BuildPool()
        for _, P in Pool do P.Frame:Destroy() end
        table.clear(Pool)
        local Count = math.ceil(BodyHeight() / RH) + 3
        for I = 1, Count do
            local Row = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, RH), Visible = false, Parent = Body })
            local Bar = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.new(0, 3, 1, -8), Position = UDim2.fromOffset(0, 4), Visible = false, Parent = Row })
            Corner(Bar, 99)
            local P = { Frame = Row, Bar = Bar, Cells = {}, Item = nil, Index = 0 }
            for _, C in TB.Columns do
                local Align = Enum.TextXAlignment[C.Align] or Enum.TextXAlignment.Left
                local Cell = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromScale(C.X, 0), Size = UDim2.fromScale(C.W, 1), Parent = Row })
                local Swatch = New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(12, 12), Visible = false, Parent = Cell })
                Corner(Swatch, 99)
                Stroke(Swatch, "Text", 1, 0.75)
                local Icon = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(14, 14), ImageColor3 = "Text", Visible = false, Parent = Cell })
                local Text = New("TextLabel", { Size = UDim2.fromScale(1, 1), TextSize = 12, TextXAlignment = Align, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Cell })
                local PadObj = Pad(Text, 0, 8, 0, 10)
                table.insert(P.Cells, { Text = Text, Swatch = Swatch, Icon = Icon, Pad = PadObj })
            end
            Row.MouseEnter:Connect(function() StyleRow(P, true) end)
            Row.MouseLeave:Connect(function() StyleRow(P, false) end)
            Row.MouseButton1Click:Connect(function() OnRowClick(P) end)
            Row.MouseButton2Click:Connect(function()
                if TB.Disabled or not P.Item then return end
                if TB.RightClick then Library:SafeCallback(TB.RightClick, P.Item.Data, P.Index) end
            end)
            Pool[I] = P
        end
    end

    --// data -> view -> render
    local function BuildView()
        local V = {}
        local Q = NormalizeSearch(TB.Search)
        for _, Item in TB.Items do
            local Keep = true
            if Q ~= "" then
                Keep = false
                for _, Col in TB.Columns do
                    if Fuzzy(CellText(CellOf(Item.Data, Col), Col, Item.Data), Q) then Keep = true break end
                end
            end
            if Keep then table.insert(V, Item) end
        end
        if TB.SortColumn and TB.SortDir ~= 0 then
            local Col = TB.SortColumn
            table.sort(V, function(A, B)
                local KA, KB = SortKey(CellOf(A.Data, Col)), SortKey(CellOf(B.Data, Col))
                if typeof(KA) ~= typeof(KB) then KA, KB = tostring(KA), tostring(KB) end
                if KA == KB then return A.Order < B.Order end
                if TB.SortDir == 1 then return KA < KB end
                return KA > KB
            end)
        end
        TB.View = V
    end

    function TB:Render()
        if Library.Unloaded then return end
        local View = TB.View
        local Total = #View * RH
        Body.CanvasSize = UDim2.fromOffset(0, Total)

        -- scale-independent scroll position (works at any UI scale)
        local MaxLocal = math.max(0, Total - BodyHeight())
        local AbsMax = math.max(1, Body.AbsoluteCanvasSize.Y - Body.AbsoluteWindowSize.Y)
        local ScrollLocal = math.clamp(Body.CanvasPosition.Y / AbsMax, 0, 1) * MaxLocal

        local Count = #Pool
        local First = math.max(1, math.floor(ScrollLocal / RH) + 1)
        local Used = {}
        for Index = First, math.min(#View, First + Count - 1) do
            local P = Pool[(Index - 1) % Count + 1]
            Used[P] = true
            local Item = View[Index]
            P.Item, P.Index = Item, Index
            P.Frame.Visible = true
            P.Frame.Position = UDim2.fromOffset(0, (Index - 1) * RH)

            for CI, Col in TB.Columns do
                local Cell = P.Cells[CI]
                if Cell then
                    local V = CellOf(Item.Data, Col)
                    local Txt = CellText(V, Col, Item.Data)
                    local Left, TextColor = 10, Library.Scheme.Text
                    Cell.Swatch.Visible, Cell.Icon.Visible = false, false
                    if typeof(V) == "Color3" then
                        Cell.Swatch.Visible = true
                        Cell.Swatch.BackgroundColor3 = V
                        Left = 28
                    elseif typeof(V) == "table" then
                        if typeof(V.Color) == "Color3" then TextColor = V.Color end
                        if V.Icon then
                            local D = Library:GetCustomIcon(V.Icon)
                            if D then
                                Library:ApplyIcon(Cell.Icon, D)
                                Cell.Icon.Visible = true
                                Left = 30
                            end
                        end
                    elseif typeof(V) == "boolean" and not V then
                        TextColor = Library.Scheme.SubText
                    end
                    Cell.Pad.PaddingLeft = UDim.new(0, Left)
                    Cell.Text.TextColor3 = TextColor
                    Cell.Text.Text = Library:HasRich(Txt) and Library:ToRichText(Txt) or Esc(Txt)
                end
            end
            StyleRow(P, false)
        end
        for _, P in Pool do
            if not Used[P] then
                P.Frame.Visible = false
                P.Item = nil
            end
        end

        Empty.Visible = #View == 0
        if Info.ShowCount then
            local Sel = 0
            for _ in TB.Selected do Sel += 1 end
            local Txt = #View == #TB.Items and string.format("%d rows", #TB.Items) or string.format("%d of %d rows", #View, #TB.Items)
            if Sel > 0 then Txt ..= string.format("  ·  %d selected", Sel) end
            Footer.Text = Txt
        end
        for _, C in TB.Columns do
            if C.Arrow then C.Arrow.Text = (TB.SortColumn == C and TB.SortDir ~= 0) and (TB.SortDir == 1 and "▲" or "▼") or "" end
        end
    end
    TB.Display = TB.Render

    function TB:Refresh()
        BuildView()
        TB:Render()
    end

    function TB:SetColumns(Cols)
        TB.Columns = NormCols(Cols)
        TB.SortColumn, TB.SortDir = nil, 0
        BuildHeader()
        BuildPool()
        TB:Refresh()
    end

    --// public api
    local function AddItem(Row, Pos)
        TB.Counter += 1
        local Item = { Data = Row, Order = TB.Counter }
        if Pos then table.insert(TB.Items, math.clamp(Pos, 1, #TB.Items + 1), Item) else table.insert(TB.Items, Item) end
        return Item
    end
    function TB:SetRows(Rows)
        TB.Items, TB.Selected, TB.Counter = {}, {}, 0
        for _, R in Rows or {} do AddItem(R) end
        TB:Refresh()
    end
    function TB:AddRow(Row, Pos) AddItem(Row, Pos); TB:Refresh(); return Row end
    function TB:AddRows(Rows) for _, R in Rows do AddItem(R) end; TB:Refresh() end
    function TB:RemoveRow(RowOrIndex)
        local Data, I = ResolveRow(RowOrIndex)
        if not I then return false end
        table.remove(TB.Items, I)
        TB.Selected[Data] = nil
        TB:Refresh()
        return true
    end
    function TB:UpdateRow(RowOrIndex, NewData)
        local Data, I = ResolveRow(RowOrIndex)
        if not I then return false end
        if NewData ~= nil and NewData ~= Data then
            TB.Items[I].Data = NewData
            if TB.Selected[Data] then TB.Selected[Data] = nil; TB.Selected[NewData] = true end
        end
        TB:Refresh()
        return true
    end
    function TB:Clear() TB:SetRows({}) end
    function TB:GetRows()
        local Out = {}
        for _, It in TB.Items do table.insert(Out, It.Data) end
        return Out
    end
    function TB:GetSelectedRows()
        local Out = {}
        for _, It in TB.Items do
            if TB.Selected[It.Data] then table.insert(Out, It.Data) end
        end
        return Out
    end
    function TB:GetSelected()
        local Rows = TB:GetSelectedRows()
        if TB.Multi then return Rows end
        return Rows[1]
    end
    function TB:SetSelected(Target)
        TB.Selected = {}
        local Targets = { Target }
        if typeof(Target) == "table" and not ResolveRow(Target) and IsArray(Target) then Targets = Target end
        for _, T in Targets do
            local Data = ResolveRow(T)
            if Data then
                TB.Selected[Data] = true
                if not TB.Multi then break end
            end
        end
        TB:Render()
        Library:SafeCallback(TB.Changed, TB:GetSelected())
    end
    function TB:Sort(Column, Dir)
        local Found
        for _, C in TB.Columns do
            if C == Column or C.Name == Column or C.Index == Column then Found = C break end
        end
        TB.SortColumn = Found
        TB.SortDir = (Found == nil or Dir == nil) and 0 or ((tostring(Dir):lower() == "desc" or Dir == -1) and -1 or 1)
        TB:Refresh()
    end
    function TB:SetSearch(Text)
        TB.Search = tostring(Text or "")
        if SearchBox and SearchBox.Text ~= TB.Search then SearchBox.Text = TB.Search end
        TB:Refresh()
    end
    function TB:SetHeight(H)
        Info.Height = H
        Frame.Size = UDim2.new(1, 0, 0, H)
        BuildPool()
        TB:Render()
    end
    function TB:OnChanged(F) TB.Changed = F end
    function TB:SetDisabled(D)
        TB.Disabled = D
        Frame.Active = not D
        Label.TextTransparency = D and 0.55 or 0
        TB:Render()
    end
    function TB:SetText(T)
        TB.Text = T
        Label.Text = Library:ToRichText(T or "")
        Label.Visible = T ~= nil
        Top.Visible = T ~= nil or Info.Searchable
    end

    if SearchBox then
        table.insert(TB.Connections, SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if SearchBox.Text ~= TB.Search then
                TB.Search = SearchBox.Text
                Body.CanvasPosition = Vector2.zero
                TB:Refresh()
            end
        end))
    end
    table.insert(TB.Connections, Body:GetPropertyChangedSignal("CanvasPosition"):Connect(function() TB:Render() end))
    table.insert(TB.Connections, Body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() TB:Render() end))

    TB.Columns = NormCols(Info.Columns)
    BuildHeader()
    BuildPool()
    for _, R in Info.Rows do AddItem(R) end
    TB:Refresh()

    Finalize(Group, TB, Holder, Options, Idx, Info)
    return TB
end

--// Skeleton loader (placeholder shimmer rows) \\--
function Funcs:AddSkeleton(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" then Info = Idx; Idx = nil end
    Info = Library:Validate(Info or {}, Templates.Skeleton)
    local Group = self

    local Sk = {
        Type = "Skeleton", Rows = Info.Rows, Height = Info.Height, Gap = Info.Gap,
        Visible = Info.Visible, Connections = {}, Bars = {},
    }

    local Holder = New("Frame", {
        BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0),
        Visible = Sk.Visible, Parent = Group.Container,
    })
    List(Holder, Sk.Gap)

    local function MakeBar(WidthScale)
        local Bar = New("Frame", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0.15,
            Size = UDim2.new(WidthScale or 1, 0, 0, Sk.Height), Parent = Holder,
        })
        Corner(Bar, 6)
        local Shine = New("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.85,
            Size = UDim2.new(0.35, 0, 1, 0), Position = UDim2.fromScale(-0.35, 0), Parent = Bar,
        })
        local GradObj = New("UIGradient", {
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.5, 0.4),
                NumberSequenceKeypoint.new(1, 1),
            }),
            Parent = Shine,
        })
        table.insert(Sk.Bars, { Bar = Bar, Shine = Shine })
        return Bar
    end

    local Widths = { 1, 0.72, 0.88, 0.55, 0.94 }
    for I = 1, Sk.Rows do
        MakeBar(Widths[((I - 1) % #Widths) + 1])
    end

    local AnimToken = 0
    function Sk:Play()
        AnimToken += 1
        local Token = AnimToken
        task.spawn(function()
            while Token == AnimToken and not Sk.Destroyed and Holder.Parent do
                for _, B in Sk.Bars do
                    if B.Shine and B.Shine.Parent then
                        B.Shine.Position = UDim2.fromScale(-0.4, 0)
                        local T = TweenService:Create(B.Shine, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Position = UDim2.fromScale(1.1, 0) })
                        T:Play()
                    end
                end
                task.wait(1.25)
            end
        end)
    end
    function Sk:Stop() AnimToken += 1 end
    function Sk:SetRows(N)
        N = math.max(1, tonumber(N) or 1)
        Sk.Rows = N
        for _, C in Holder:GetChildren() do
            if C:IsA("Frame") then C:Destroy() end
        end
        Sk.Bars = {}
        for I = 1, N do MakeBar(Widths[((I - 1) % #Widths) + 1]) end
        if Holder.Visible then Sk:Play() end
    end

    Sk:Play()
    Finalize(Group, Sk, Holder, nil, Idx, Info)
    local OldDestroy = Sk.Destroy
    function Sk:Destroy()
        Sk:Stop()
        if OldDestroy then OldDestroy(Sk) end
    end
    return Sk
end

--// Dropdown (macOS pop-up button + extended grid modal) \\--
-- Values accept: { "A", "B" }  |  { Key = "Display" }  |  { { Name, Value, Icon }, { Name = "", Value = "", Icon = id } }
-- Icon can be an asset id, a lucide name, a ViewportFrame, or a Model / BasePart (rendered in a viewport).
local function MakeIconInstance(Parent, Icon)
    if Icon == nil or Icon == "" then return nil end
    if typeof(Icon) == "Instance" then
        local Was = Icon.Archivable
        Icon.Archivable = true
        local Clone = Icon:Clone()
        Icon.Archivable = Was
        if not Clone then return nil end

        if Icon:IsA("ViewportFrame") then
            Clone.AnchorPoint, Clone.Position, Clone.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), UDim2.fromScale(1, 1)
            Clone.BackgroundTransparency = 1
            Clone.Parent = Parent
            local Cam = Clone:FindFirstChildOfClass("Camera")
            if Cam then Clone.CurrentCamera = Cam end
            return Clone
        elseif Icon:IsA("Model") or Icon:IsA("BasePart") then
            local VF = New("ViewportFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = Parent })
            Clone.Parent = VF
            local Cam = Instance.new("Camera")
            Cam.Parent = VF
            VF.CurrentCamera = Cam
            local Pivot = Clone:GetPivot().Position
            local Ext = Clone:IsA("Model") and select(2, Clone:GetBoundingBox()) or Clone.Size
            local M = math.max(Ext.X, Ext.Y, Ext.Z, 0.5)
            Cam.CFrame = CFrame.new(Pivot + Vector3.new(M * 0.7, M * 0.55, M * 1.7), Pivot)
            return VF
        elseif Icon:IsA("GuiObject") then
            Clone.Parent = Parent
            return Clone
        end
        Clone:Destroy()
        return nil
    end

    local Data = Library:GetCustomIcon(Icon)
    if not Data then return nil end
    local Img = New("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
        ScaleType = Enum.ScaleType.Fit, ImageColor3 = Data.Custom and Color3.new(1, 1, 1) or "Text", Parent = Parent,
    })
    Library:ApplyIcon(Img, Data)
    return Img
end
function Library:MakeIcon(Parent, Icon) return MakeIconInstance(Parent, Icon) end

function Funcs:AddRowBox(Info, Builder)
    if self.Destroyed then return end
    if typeof(Info) == "function" then Builder, Info = Info, {} end
    if typeof(Info) == "number" then Info = { Cols = Info } end
    Info = (typeof(Info) == "table" and Info) or {}
    local Group = self
    local Cols = math.clamp(math.floor(tonumber(Info.Cols) or 2), 1, 6)
    local Gap = tonumber(Info.Gap) or 8
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Info.Visible ~= false, Parent = Group.Container })
    List(Holder, Gap, Enum.FillDirection.Horizontal)
    local Row = {
        Type = "RowBox", Name = Info.Name or Info.Text, Text = Info.Text, Visible = true,
        Holder = Holder, Container = Holder, Elements = {}, DependencyBoxes = {},
        Tab = Group.Tab, Connections = {}, ParentGroup = Group,
    }
    setmetatable(Row, Group)
    for K, F in pairs(Funcs) do
        if typeof(F) == "function" and K:sub(1, 3) == "Add" and K ~= "AddRowBox" then
            Row[K] = function(Self, ...)
                local Seen = {}
                for _, C in Holder:GetChildren() do Seen[C] = true end
                local El = F(Self, ...)
                for _, C in Holder:GetChildren() do
                    if not Seen[C] and C:IsA("GuiObject") then
                        C.Size = UDim2.new(1 / Cols, -(Gap * (Cols - 1)) / Cols, C.Size.Y.Scale, C.Size.Y.Offset)
                    end
                end
                return El
            end
        end
    end
    if typeof(Builder) == "function" then Builder(Row) end
    return Row
end

function Funcs:AddPriorityDropdown(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Idx, Info = First, Second
    if typeof(First) == "table" and Second == nil then Info, Idx = First, nil end
    Info = Library:Validate(Info, Templates.Dropdown)
    local Group = self

    local PD = {
        Type = "Dropdown", SubType = "Priority", Text = Info.Text, Value = Info.Default,
        Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible ~= false, Connections = {}, Items = {},
    }
    PD.Extended = Info.Extended == true

    for I, V in Info.Values or {} do
        local It
        if typeof(V) == "table" then
            local Val = V.Value ~= nil and V.Value or (V.Name or V.Display)
            It = { Name = tostring(V.Name or V.Display or Val), Value = Val, Priority = tonumber(V.Priority), Icon = V.Icon, Disabled = V.Disabled }
        else
            It = { Name = tostring(V), Value = V, Priority = tonumber(I) }
        end
        It._i = I
        if It.Priority == nil then It.Priority = I end
        table.insert(PD.Items, It)
    end
    table.sort(PD.Items, function(A, B)
        if A.Priority == B.Priority then return A._i < B._i end
        return A.Priority < B.Priority
    end)

    function PD:GetOrdered()
        local Out = {}
        for _, It in PD.Items do table.insert(Out, It) end
        return Out
    end
    local function FindItem(V)
        for _, It in PD.Items do
            if It.Value == V or It.Name == V then return It end
        end
        return nil
    end

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = PD.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Library:ToRichText(PD.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = PD.Text ~= nil, Parent = Holder })
    PD.LabelObj = Label
    local Button = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    Corner(Button, 7)
    Stroke(Button, "Outline", 1, 0.55)
    local Display = New("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, PD.Extended and -58 or -34, 1, 0), Text = "---", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Button })
    Glyph(Button, "chevrons-up-down", "⌃⌄", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14) })
    local ExpandBtn = New("TextButton", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -30, 0.5, 0), Size = UDim2.fromOffset(20, 20), Visible = PD.Extended, Parent = Button })
    Glyph(ExpandBtn, "maximize-2", "⤢", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13) })

    local Popup = Library:CreatePopup(Button, { Width = Info.Width or 210, AutoY = true })
    local Scroll = New("ScrollingFrame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0, math.min(#PD.Items, 8) * 28 + 6), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, Parent = Popup.Frame })
    New("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Scroll })

    local Rows = {}
    local Modal

    local function Select(It)
        if It.Disabled or PD.Disabled then return end
        PD.Value = It.Value
        Display.Text = It.Name
        Library:SafeCallback(PD.Callback, PD.Value)
        Library:SafeCallback(PD.Changed, PD.Value)
        if Modal then PD:CloseModal() end
        if Popup.Active then Popup:Close() end
    end

    local function BuildRows(Container)
        Container = Container or Scroll
        for _, C in Container:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end
        table.clear(Rows)

        for J, It in ipairs(PD.Items) do
            local Row = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0.4, Size = UDim2.new(1, -8, 0, 26), LayoutOrder = J, Parent = Container })
            Corner(Row, 6)
            table.insert(Rows, { Btn = Row, It = It })

            local Handle = New("TextButton", { BackgroundTransparency = 1, Size = UDim2.new(0, 20, 1, 0), Parent = Row })
            Glyph(Handle, "grip-vertical", "≡", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 12), Color = "SubText" })

            New("TextLabel", { Position = UDim2.fromOffset(24, 0), Size = UDim2.new(1, -76, 1, 0), Text = Library:ToRichText(It.Name), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, TextSize = 12, TextTransparency = It.Disabled and 0.5 or 0, Parent = Row })

            local Num = New("TextBox", {
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(38, 20),
                BackgroundColor3 = "ControlHover", Text = tostring(It.Priority), TextSize = 11,
                ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Center, Parent = Row,
            })
            Corner(Num, 5)
            local SelDot = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -50, 0.5, 0), Size = UDim2.fromOffset(7, 7), Visible = PD.Value == It.Value, Parent = Row })
            Corner(SelDot, 99)

            Num.FocusLost:Connect(function()
                local N = tonumber(Num.Text)
                if not N then
                    Num.Text = tostring(It.Priority)
                    return
                end
                It.Priority = math.floor(math.clamp(N, -9999, 9999))
                Num.Text = tostring(It.Priority)
                table.sort(PD.Items, function(A, B)
                    if A.Priority == B.Priority then return A._i < B._i end
                    return A.Priority < B.Priority
                end)
                BuildRows()
            end)

            local Dragging, StartY = false, 0
            local MoveConn, EndConn
            Handle.InputBegan:Connect(function(Input)
                if PD.Disabled then return end
                if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                Dragging = true
                StartY = Input.Position.Y
                Tween(Row, { BackgroundTransparency = 0.1 }, Library.TweenInfo)
                MoveConn = UserInputService.InputChanged:Connect(function(Ch)
                    if not Dragging then return end
                    if Ch.UserInputType ~= Enum.UserInputType.MouseMovement and Ch.UserInputType ~= Enum.UserInputType.Touch then return end
                    local Top = Container.AbsolutePosition.Y + 4
                    local Target = math.clamp(math.floor((Ch.Position.Y - Top) / 28) + 1, 1, #PD.Items)
                    local Cur = table.find(PD.Items, It)
                    if Cur and Target ~= Cur then
                        table.remove(PD.Items, Cur)
                        table.insert(PD.Items, Target, It)
                        for J2, It2 in ipairs(PD.Items) do
                            for _, R in Rows do
                                if R.It == It2 then R.Btn.LayoutOrder = J2 end
                            end
                        end
                    end
                end)
                EndConn = UserInputService.InputEnded:Connect(function(En)
                    if not Dragging then return end
                    if En.UserInputType ~= Enum.UserInputType.MouseButton1 and En.UserInputType ~= Enum.UserInputType.Touch then return end
                    Dragging = false
                    if MoveConn then MoveConn:Disconnect(); MoveConn = nil end
                    if EndConn then EndConn:Disconnect(); EndConn = nil end
                    for I2, It2 in ipairs(PD.Items) do It2.Priority = I2 end
                    Tween(Row, { BackgroundTransparency = 0.4 }, Library.TweenInfo)
                    BuildRows(Container)
                end)
            end)

            Row.MouseButton1Click:Connect(function() Select(It) end)
        end
    end

    function PD:Display()
        local It = FindItem(PD.Value)
        Display.Text = It and It.Name or "---"
    end

    function PD:SetValue(V)
        local It = FindItem(V)
        if It then PD.Value = It.Value elseif V == nil then PD.Value = nil end
        PD:Display()
        if Popup and Popup.Active then BuildRows(Scroll) end
        if Modal then BuildRows(Modal.Scroll) end
        if not PD.Disabled then Library:UpdateDependencyBoxes() end
        Library:SafeCallback(PD.Changed, PD.Value)
    end

    function PD:SetDisabled(D)
        PD.Disabled = D == true
        Label.TextTransparency = PD.Disabled and 0.55 or 0
        Display.TextTransparency = PD.Disabled and 0.55 or 0
        Button.BackgroundTransparency = PD.Disabled and 0.5 or 0
    end

    function PD:SetText(T)
        PD.Text = T
        Label.Text = Library:ToRichText(T or "")
        Label.Visible = T ~= nil and T ~= ""
    end

    function PD:CloseModal()
        if not Modal then return end
        local M = Modal
        Modal = nil
        if Library.CurrentModal == PD then Library.CurrentModal = nil end
        Tween(M.Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
        Tween(M.Scale, { Scale = 0.95 }, Library.TweenInfo)
        task.delay(0.16, function() M.Dim:Destroy() end)
    end

    function PD:Close() PD:CloseModal() end

    function PD:OpenModal()
        if PD.Disabled or Modal then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if Library.CurrentModal and Library.CurrentModal ~= PD then Library.CurrentModal:Close() end

        local Win = Library.Window
        local Host = Win and Win.MainFrame or Overlay
        local Real = Host.AbsoluteSize / (Host == Overlay and 1 or Library.DPIScale)
        local PW = math.clamp(Real.X - 160, 260, 400)
        local RowH = #PD.Items * 28
        local PH = math.max(130, math.min(RowH + 66, math.clamp(Real.Y - 90, 200, 520)))

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = Host })
        if Win then Corner(Dim, Win.Info.CornerRadius) end
        Tween(Dim, { BackgroundTransparency = 0.45 }, Library.SlowTween)

        local Panel = New("Frame", { BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(PW, PH), ZIndex = 81, Parent = Dim })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        Library:AddGlass(Panel)
        local PScale = New("UIScale", { Scale = 0.95, Parent = Panel })
        Tween(PScale, { Scale = 1 }, Library.SlowTween)

        New("TextLabel", { Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -110, 0, 22), Text = Library:ToRichText(PD.Text or "Order"), FontFace = "FontBold", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Panel })
        local Done = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(64, 24), Text = "Close", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Panel })
        Corner(Done, 99)
        Done.MouseButton1Click:Connect(function() PD:CloseModal() end)

        local MScroll = New("ScrollingFrame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 44), Size = UDim2.new(1, -24, 1, -56), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, ZIndex = 82, Parent = Panel })
        New("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = MScroll })

        Modal = { Dim = Dim, Scale = PScale, Scroll = MScroll }
        Library.CurrentModal = PD
        BuildRows(MScroll)
    end

    Button.MouseButton1Click:Connect(function()
        if PD.Disabled then return end
        if Modal then PD:CloseModal() end
        Popup:Toggle()
        if Popup.Active then BuildRows(Scroll) end
    end)
    table.insert(PD.Connections, ExpandBtn.MouseButton1Click:Connect(function() PD:OpenModal() end))

    PD:Display()
    PD:SetDisabled(PD.Disabled)
    if typeof(Info.Tooltip) == "string" then Library:AddTooltip(Info.Tooltip, Button) end
    Finalize(Group, PD, Holder, Options, Idx, Info)
    return PD
end

function Funcs:AddDropdown(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.Dropdown)
    local Group = self

    if Info.SpecialType == "Player" then
        Info.Values = GetPlayers(Info.ExcludeLocalPlayer); Info.AllowNull = true
    elseif Info.SpecialType == "Team" then
        Info.Values = GetTeams(); Info.AllowNull = true
    end

    local DD = {
        Type = "Dropdown", Text = typeof(Info.Text) == "string" and Info.Text or nil, Values = Info.Values,
        DisabledValues = Info.DisabledValues, Multi = Info.Multi, AllowNull = Info.AllowNull,
        SpecialType = Info.SpecialType, ExcludeLocalPlayer = Info.ExcludeLocalPlayer,
        Callback = Info.Callback, Changed = Info.Changed, Disabled = Info.Disabled, Visible = Info.Visible,
        Value = Info.Multi and {} or nil, Connections = {},
    }

    --// item normalisation
    local function GetItems()
        local Out = {}
        local Arr = IsArray(DD.Values)
        for K, Raw in DD.Values do
            local Item
            if typeof(Raw) == "table" and (Raw.Name ~= nil or Raw[1] ~= nil) then
                local Name = Raw.Name ~= nil and Raw.Name or Raw[1]
                local Val = Raw.Value ~= nil and Raw.Value or Raw[2]
                if Val == nil then Val = Name end
                Item = { Value = Val, Display = tostring(Name), Icon = Raw.Icon ~= nil and Raw.Icon or Raw[3] }
            else
                local Disp = tostring(Info.FormatListValue and Info.FormatListValue(Raw) or Raw)
                Item = { Value = Arr and Raw or K, Display = Disp }
            end
            Item.Disabled = table.find(DD.DisabledValues, Item.Value) ~= nil
            table.insert(Out, Item)
        end
        if not Arr then table.sort(Out, function(A, B) return A.Display < B.Display end) end
        return Out
    end

    local function Lookup(Val)
        for _, It in GetItems() do
            if It.Value == Val then return It end
        end
        return nil
    end
    local function HasIcons()
        for _, It in GetItems() do
            if It.Icon ~= nil then return true end
        end
        return false
    end
    local function IsSelected(Val)
        if DD.Multi then return DD.Value[Val] == true end
        return DD.Value == Val
    end

    DD.Extended = Info.Extended
    if DD.Extended == nil then DD.Extended = HasIcons() end
    DD.ModalOnly = Info.ModalOnly == true

    --// ui
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = DD.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Library:ToRichText(DD.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = DD.Text ~= nil, Parent = Holder })
    DD.LabelObj = Label
    local Button = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    Corner(Button, 7)
    Stroke(Button, "Outline", 1, 0.55)
    local Display = New("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), Text = "---", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Button })
    local Chevron = Glyph(Button, "chevrons-up-down", "⌃⌄", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14) })

    local ExpandBtn = New("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -28, 0.5, 0), Size = UDim2.fromOffset(20, 20), Visible = DD.Extended, Parent = Button })
    local ExpandIcon = Glyph(ExpandBtn, "maximize-2", "⤢", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13) })

    local function LayoutButton()
        ExpandBtn.Visible = DD.Extended
        Display.Size = UDim2.new(1, DD.Extended and -56 or -34, 1, 0)
    end
    LayoutButton()

    local SearchBox, Popup, Scroll

    local function Entries()
        local Out = {}
        local Q = SearchBox and NormalizeSearch(SearchBox.Text) or ""
        for _, It in GetItems() do
            if Q == "" or Fuzzy(It.Display, Q) then table.insert(Out, It) end
        end
        return Out
    end

    local function DisplayOf(Val)
        local It = Lookup(Val)
        local D = It and It.Display or tostring(Val)
        if Info.FormatDisplayValue then D = tostring(Info.FormatDisplayValue(D)) end
        return D
    end

    function DD:GetActiveValues()
        local T = {}
        if DD.Multi then
            for V in DD.Value do table.insert(T, V) end
        elseif DD.Value ~= nil then
            table.insert(T, DD.Value)
        end
        return T
    end

    function DD:Display()
        if Library.Unloaded then return end
        local Str = ""
        if DD.Multi then
            local Parts = {}
            for V in DD.Value do table.insert(Parts, DisplayOf(V)) end
            table.sort(Parts)
            Str = table.concat(Parts, ", ")
        elseif DD.Value ~= nil then
            Str = DisplayOf(DD.Value)
        end
        Display.Text = Str == "" and "---" or Str
        local D = DD.Disabled and 0.55 or 0
        Display.TextTransparency = D
        Label.TextTransparency = D
        GlyphTransparency(Chevron, DD.Disabled and 0.7 or 0.2)
        GlyphTransparency(ExpandIcon, DD.Disabled and 0.7 or 0.35)
    end

    function DD:OnChanged(F) DD.Changed = F end
    function DD:RunChanged()
        if DD.Disabled then return end
        Library:SafeCallback(DD.Callback, DD.Value)
        Library:SafeCallback(DD.Changed, DD.Value)
    end

    -- shared selection logic; returns true when the menu should close
    local function Select(It)
        if It.Disabled then return false end
        local Sel = IsSelected(It.Value)
        if DD.Multi then
            if Sel and #DD:GetActiveValues() == 1 and not DD.AllowNull then return false end
            DD.Value[It.Value] = (not Sel) or nil
        else
            if Sel then
                if not DD.AllowNull then return true end
                DD.Value = nil
            else
                DD.Value = It.Value
            end
        end
        DD:Display()
        Library:UpdateDependencyBoxes()
        DD:RunChanged()
        return not DD.Multi
    end

    --// popup list
    function DD:BuildList()
        if not Scroll then return end
        for _, C in Scroll:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end

        local Ents = Entries()
        for I, E in Ents do
            local Row = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = I, Parent = Scroll })
            Corner(Row, 5)
            local Selected = IsSelected(E.Value)
            local Check = Glyph(Row, "check", "✓", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(12, 12), Color = "Text", Visible = Selected })
            local TextX = 26
            if E.Icon ~= nil then
                local IconBox = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 26, 0.5, 0), Size = UDim2.fromOffset(18, 18), Parent = Row })
                MakeIconInstance(IconBox, E.Icon)
                TextX = 50
            end
            local Txt = New("TextLabel", {
                Position = UDim2.fromOffset(TextX, 0), Size = UDim2.new(1, -TextX - 4, 1, 0), Text = E.Display, TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = E.Disabled and 0.6 or 0, Parent = Row,
            })

            Row.MouseEnter:Connect(function()
                if E.Disabled then return end
                Row.BackgroundTransparency = 0
                Txt.TextColor3 = Library.Scheme.AccentText
                if Check:IsA("ImageLabel") then Check.ImageColor3 = Library.Scheme.AccentText else Check.TextColor3 = Library.Scheme.AccentText end
            end)
            Row.MouseLeave:Connect(function()
                Row.BackgroundTransparency = 1
                Txt.TextColor3 = Library.Scheme.Text
                if Check:IsA("ImageLabel") then Check.ImageColor3 = Library.Scheme.Text else Check.TextColor3 = Library.Scheme.Text end
            end)
            Row.MouseButton1Click:Connect(function()
                if Select(E) then Popup:Close() else DD:BuildList() end
            end)
        end

        local SearchH = SearchBox and 34 or 0
        local H = math.clamp(#Ents, 1, Info.MaxVisibleDropdownItems) * 24 + 8
        Scroll.CanvasSize = UDim2.fromOffset(0, #Ents * 24 + 8)
        Popup:SetSize(UDim2.fromOffset(Button.AbsoluteSize.X / Library.DPIScale, H + SearchH))
    end

    Popup = Library:CreatePopup(Button, {
        Width = 200, Height = 100,
        OnOpen = function() DD:BuildList() end,
        OnToggle = function(Active) if SearchBox then SearchBox.Text = "" end end,
    })
    DD.Popup = Popup

    Scroll = New("ScrollingFrame", {
        Position = UDim2.fromOffset(0, Info.Searchable and 34 or 0), Size = UDim2.new(1, 0, 1, Info.Searchable and -34 or 0),
        CanvasSize = UDim2.new(), ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Popup.Frame,
    })
    List(Scroll, 1)
    Pad(Scroll, 4, 4, 4, 4)

    if Info.Searchable then
        SearchBox = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search", Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 24), TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Popup.Frame })
        Corner(SearchBox, 12)
        Pad(SearchBox, 0, 10, 0, 10)
        table.insert(DD.Connections, SearchBox:GetPropertyChangedSignal("Text"):Connect(function() DD:BuildList() end))
    end

    --// extended modal (grid with icon + name under it)
    local Modal
    function DD:CloseModal()
        if not Modal then return end
        local M = Modal
        Modal = nil
        Library.CurrentModal = nil
        Tween(M.Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
        Tween(M.Scale, { Scale = 0.95 }, Library.TweenInfo)
        task.delay(0.16, function() M.Dim:Destroy() end)
    end

    function DD:OpenModal()
        if DD.Disabled or Modal then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if Library.CurrentModal then Library.CurrentModal:Close() end

        local Win = Library.Window
        local Host = Win and Win.MainFrame or Overlay
        local Real = Host.AbsoluteSize / (Host == Overlay and 1 or Library.DPIScale)
        local PW = math.clamp(Real.X - 70, 320, 660)
        local PH = math.clamp(Real.Y - 70, 280, 480)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = Host })
        if Win then Corner(Dim, Win.Info.CornerRadius) end
        Tween(Dim, { BackgroundTransparency = 0.45 }, Library.SlowTween)

        local Panel = New("Frame", { BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(PW, PH), ZIndex = 81, Parent = Dim })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        Library:AddGlass(Panel)
        local PScale = New("UIScale", { Scale = 0.95, Parent = Panel })
        Tween(PScale, { Scale = 1 }, Library.SlowTween)

        New("TextLabel", { Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -110, 0, 22), Text = Library:ToRichText(DD.Text or "Select"), FontFace = "FontBold", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Panel })
        local Done = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(64, 24), Text = DD.Multi and "Done" or "Close", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Panel })
        Corner(Done, 99)

        local Search = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search", Position = UDim2.fromOffset(16, 46), Size = UDim2.new(1, -32, 0, 30), TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Panel })
        Corner(Search, 99)
        Pad(Search, 0, 12, 0, 14)

        local Grid = New("ScrollingFrame", { Position = UDim2.fromOffset(0, 86), Size = UDim2.new(1, 0, 1, -86), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Panel })
        New("UIGridLayout", { CellSize = UDim2.fromOffset(100, 118), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Grid })
        Pad(Grid, 4, 12, 16, 12)

        Modal = { Dim = Dim, Scale = PScale, Close = function() DD:CloseModal() end }
        Library.CurrentModal = Modal

        local Cells = {}
        local function Build()
            for _, C in Grid:GetChildren() do
                if C:IsA("TextButton") then C:Destroy() end
            end
            table.clear(Cells)
            local Q = NormalizeSearch(Search.Text)
            local N = 0
            for _, It in GetItems() do
                if Q == "" or Fuzzy(It.Display, Q) then
                    N += 1
                    local Cell = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, LayoutOrder = N, Parent = Grid })
                    Corner(Cell, 12)
                    local CStroke = Stroke(Cell, "Accent", 2, 1)
                    local IconBox = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.fromOffset(66, 66), Parent = Cell })
                    if not MakeIconInstance(IconBox, It.Icon) then
                        New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = It.Display:sub(1, 1):upper(), FontFace = "FontBold", TextSize = 30, TextColor3 = "SubText", Parent = IconBox })
                    end
                    New("TextLabel", {
                        Position = UDim2.fromOffset(6, 80), Size = UDim2.new(1, -12, 0, 32), Text = It.Display, TextSize = 11, TextWrapped = true,
                        TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = It.Disabled and 0.6 or 0, Parent = Cell,
                    })
                    local Badge = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(18, 18), Parent = Cell })
                    Corner(Badge, 99)
                    Glyph(Badge, "check", "✓", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(11, 11), Color = "AccentText" })

                    local function Update()
                        local Sel = IsSelected(It.Value)
                        Badge.Visible = Sel
                        CStroke.Transparency = Sel and 0 or 1
                    end
                    Update()
                    table.insert(Cells, Update)

                    Cell.MouseEnter:Connect(function() if not It.Disabled then Tween(Cell, { BackgroundColor3 = Library.Scheme.ControlHover }) end end)
                    Cell.MouseLeave:Connect(function() Tween(Cell, { BackgroundColor3 = Library.Scheme.Control }) end)
                    Cell.MouseButton1Click:Connect(function()
                        local Close = Select(It)
                        for _, U in Cells do U() end
                        if Close then DD:CloseModal() end
                    end)
                end
            end
        end
        Build()
        local BuildToken = 0
        Search:GetPropertyChangedSignal("Text"):Connect(function()
            BuildToken += 1
            local Tok = BuildToken
            task.delay(0.1, function() if Tok == BuildToken then Build() end end)
        end)
        Done.MouseButton1Click:Connect(function() DD:CloseModal() end)
        Dim.MouseButton1Click:Connect(function()
            if not IsOver(Panel, MousePos()) then DD:CloseModal() end
        end)
    end

    --// value api
    local function ValueExists(V) return Lookup(V) ~= nil end

    function DD:SetValue(V)
        if DD.Multi then
            if typeof(V) == "string" or typeof(V) == "number" then V = { [V] = true } end
            local T = {}
            if typeof(V) == "table" then
                if IsArray(V) then
                    for _, Val in V do if ValueExists(Val) then T[Val] = true end end
                else
                    for Val, On in V do if On and ValueExists(Val) then T[Val] = true end end
                end
            end
            DD.Value = T
        else
            if V ~= nil and ValueExists(V) then DD.Value = V elseif V == nil then DD.Value = nil end
        end
        DD:Display()
        if Popup.Active then DD:BuildList() end
        if not DD.Disabled then Library:UpdateDependencyBoxes() end
        DD:RunChanged()
    end

    function DD:SetValues(Values)
        DD.Values = Values
        local Changed = false
        if DD.Multi then
            for V in DD.Value do if not ValueExists(V) then DD.Value[V] = nil; Changed = true end end
        elseif DD.Value ~= nil and not ValueExists(DD.Value) then
            DD.Value = nil; Changed = true
        end
        if Info.Extended == nil then DD.Extended = HasIcons() end
        LayoutButton()
        DD:Display()
        if Popup.Active then DD:BuildList() end
        if Changed then
            Library:UpdateDependencyBoxes()
            DD:RunChanged()
        end
    end
    function DD:AddValues(V)
        if typeof(V) == "table" and V.Name == nil and V.Value == nil then
            for _, X in V do table.insert(DD.Values, X) end
        else
            table.insert(DD.Values, V)
        end
        if Info.Extended == nil then DD.Extended = HasIcons() end
        LayoutButton()
        if Popup.Active then DD:BuildList() end
    end
    function DD:SetDisabledValues(V) DD.DisabledValues = V; if Popup.Active then DD:BuildList() end end
    function DD:SetDisabled(D) DD.Disabled = D; Popup:Close(); DD:CloseModal(); Button.Active = not D; DD:Display(); Library:UpdateDependencyBoxes() end
    function DD:SetText(T) DD.Text = T; Label.Text = Library:ToRichText(T or ""); Label.Visible = T ~= nil end

    table.insert(DD.Connections, Button.MouseButton1Click:Connect(function()
        if DD.Disabled then return end
        if DD.ModalOnly then DD:OpenModal() else Popup:Toggle() end
    end))
    table.insert(DD.Connections, ExpandBtn.MouseButton1Click:Connect(function() DD:OpenModal() end))
    table.insert(DD.Connections, Button.MouseEnter:Connect(function() if not DD.Disabled then Tween(Button, { BackgroundColor3 = Library.Scheme.ControlHover }) end end))
    table.insert(DD.Connections, Button.MouseLeave:Connect(function() Tween(Button, { BackgroundColor3 = Library.Scheme.Control }) end))

    --// defaults (value, name, index, or list of those)
    local Resolved = {}
    local function Find(Cand)
        local Items0 = GetItems()
        for _, It in Items0 do if It.Value == Cand then return It.Value end end
        for _, It in Items0 do if It.Display == Cand then return It.Value end end
        if typeof(Cand) == "number" and IsArray(DD.Values) and Items0[Cand] then return Items0[Cand].Value end
        return nil
    end
    local Def = Info.Default
    if typeof(Def) == "table" then
        for K, V in Def do
            local Cand
            if typeof(K) == "number" then Cand = V elseif V then Cand = K end
            local F = Cand ~= nil and Find(Cand)
            if F ~= nil and F ~= false then table.insert(Resolved, F) end
        end
    elseif Def ~= nil then
        local F = Find(Def)
        if F ~= nil then table.insert(Resolved, F) end
    end
    for _, V in Resolved do
        if DD.Multi then DD.Value[V] = true else DD.Value = V break end
    end
    DD.Default = Resolved

    DD:Display()
    Finalize(Group, DD, Holder, Options, Idx, Info)
    local BaseDestroy = DD.Destroy
    function DD:Destroy() Popup:Destroy(); DD:CloseModal(); BaseDestroy(DD) end
    return DD
end

--// Image / UIPassthrough \\--
function Funcs:AddImage(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.Image)
    local Group = self
    local Img = { Type = "Image", Height = Info.Height, Visible = Info.Visible, Connections = {} }
    local Holder = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, Info.Height), Visible = Img.Visible, Parent = Group.Container })
    Corner(Holder, 8)
    local Label = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = Info.Color, ImageTransparency = Info.Transparency, ScaleType = Info.ScaleType, Parent = Holder })
    function Img:SetImage(I)
        local Icon = Library:GetCustomIcon(I)
        assert(Icon, "Invalid image.")
        Library:ApplyIcon(Label, Icon)
    end
    function Img:SetHeight(H) Holder.Size = UDim2.new(1, 0, 0, H) end
    if Info.Image ~= "" then Img:SetImage(Info.Image) end
    Finalize(Group, Img, Holder, Options, Idx)
    return Img
end

function Funcs:AddUIPassthrough(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.UIPassthrough)
    assert(typeof(Info.Instance) == "Instance" and Info.Instance:IsA("GuiBase2d"), "Instance must inherit from GuiBase2d.")
    local Group = self
    local PT = { Type = "UIPassthrough", Instance = Info.Instance, Visible = Info.Visible, Connections = {} }
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Info.Height), Visible = PT.Visible, Parent = Group.Container })
    Info.Instance.Parent = Holder
    function PT:SetHeight(H) Holder.Size = UDim2.new(1, 0, 0, H) end
    Finalize(Group, PT, Holder, Options, Idx)
    return PT
end

--// Dependency box \\--
function Library:UpdateDependencyBoxes()
    for _, D in Library.DependencyBoxes do D:Update(true) end
    if Library.Searching then Library:UpdateSearch(Library.SearchText) end
end

function Library:UpdateAddons(Parent)
    if Parent and Parent.Addons then
        for _, A in Parent.Addons do if A.Update then A:Update() end end
    end
end

function Funcs:AddDependencyBox()
    if self.Destroyed then return end
    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = false, Parent = Group.Container })
    List(Holder, 10)

    local Depbox = {
        Type = "DependencyBox", Visible = false, Dependencies = {}, Holder = Holder, Container = Holder,
        Elements = {}, DependencyBoxes = {}, Tab = Group.Tab, Connections = {},
    }

    function Depbox:Update(NoSearch)
        for _, Dep in Depbox.Dependencies do
            local E, V = Dep[1], Dep[2]
            local Ok = not E.Disabled
            if Ok and E.Type == "Toggle" then Ok = E.Value == V
            elseif Ok and E.Type == "Dropdown" then
                if typeof(E.Value) == "table" then Ok = E.Value[V] == true else Ok = E.Value == V end
            end
            if not Ok then
                Holder.Visible, Depbox.Visible = false, false
                return
            end
        end
        Depbox.Visible, Holder.Visible = true, true
        if Library.Searching and not NoSearch then Library:UpdateSearch(Library.SearchText) end
    end

    function Depbox:SetupDependencies(Deps)
        for _, D in Deps do
            assert(typeof(D) == "table" and D[1] ~= nil and D[2] ~= nil, "Dependency must be { Element, ExpectedValue }")
        end
        Depbox.Dependencies = Deps
        Depbox:Update()
    end

    function Depbox:Destroy()
        Depbox.Destroyed = true
        for I = #Depbox.Elements, 1, -1 do Depbox.Elements[I]:Destroy() end
        Holder:Destroy()
        for _, L in { Group.DependencyBoxes, Library.DependencyBoxes } do
            local I = table.find(L, Depbox)
            if I then table.remove(L, I) end
        end
    end

    setmetatable(Depbox, BaseGroupbox)
    table.insert(Group.DependencyBoxes, Depbox)
    table.insert(Library.DependencyBoxes, Depbox)
    return Depbox
end

--// KeyPicker addon \\--
local SpecialKeys = { MB1 = Enum.UserInputType.MouseButton1, MB2 = Enum.UserInputType.MouseButton2, MB3 = Enum.UserInputType.MouseButton3 }
local SpecialKeysInput = { [Enum.UserInputType.MouseButton1] = "MB1", [Enum.UserInputType.MouseButton2] = "MB2", [Enum.UserInputType.MouseButton3] = "MB3" }

function AddonFuncs:AddKeyPicker(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.KeyPicker)
    local Parent = self
    local IsButton = Parent.Type == "Button" or Parent.Type == "SubButton"
    if IsButton then Info.Mode = "Press" end

    local KP = {
        Type = "KeyPicker", ParentObj = Parent, Text = Info.Text ~= "Keybind" and Info.Text or (Parent.Text or "Keybind"),
        Value = Info.Default, Mode = Info.Mode, Modes = Info.Modes, SyncToggleState = Info.SyncToggleState,
        Toggled = false, NoUI = Info.NoUI, Callback = Info.Callback, ChangedCallback = Info.ChangedCallback,
        Changed = Info.Changed, Clicked = Info.Clicked, Connections = {},
    }
    if KP.Mode == "Press" then KP.Modes = { "Press" }; KP.SyncToggleState = false end
    if KP.SyncToggleState and Parent.Type == "Toggle" then
        KP.Modes = { "Toggle", "Hold" }
        if not table.find(KP.Modes, KP.Mode) then KP.Mode = "Toggle" end
    end

    local Picking = false
    Parent.Addons = Parent.Addons or {}

    local Pill = New("TextButton", {
        BackgroundColor3 = "Control", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20),
        Text = KP.Value, TextSize = 11, TextColor3 = "SubText", LayoutOrder = #Parent.Addons + 2, Parent = Parent.AddonHolder,
    })
    Corner(Pill, 6)
    Pad(Pill, 0, 8, 0, 8)

    -- keybind list row
    if not KP.NoUI then
        KP.Row = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 16), Text = "", TextSize = 12, TextColor3 = "SubText", Visible = false, Parent = KeybindContainer })
        table.insert(Library.KeybindPickers, KP)
    end

    -- mode menu
    local Menu = Library:CreatePopup(Pill, { Width = 90, AutoY = true })
    List(Menu.Frame, 1)
    Pad(Menu.Frame, 4, 4, 4, 4)
    local ModeButtons = {}
    for _, M in KP.Modes do
        local B = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), Text = M, TextTransparency = 0.3, Parent = Menu.Frame })
        Corner(B, 5)
        B.MouseEnter:Connect(function() Tween(B, { BackgroundTransparency = 0.7 }) end)
        B.MouseLeave:Connect(function() Tween(B, { BackgroundTransparency = KP.Mode == M and 0.4 or 1 }) end)
        B.MouseButton1Click:Connect(function()
            KP.Mode = M
            Menu:Close()
            KP:Update()
        end)
        ModeButtons[M] = B
    end

    function KP:GetState()
        if KP.Mode == "Always" then return true end
        return KP.Toggled
    end

    function KP:Update()
        local Disabled = Parent.Disabled == true
        local DisplayText = KP.Value
        Pill.Text = Picking and "..." or DisplayText
        Pill.TextTransparency = Disabled and 0.6 or 0
        for M, B in ModeButtons do B.BackgroundTransparency = KP.Mode == M and 0.4 or 1 end

        local State = KP:GetState()
        if KP.SyncToggleState and Parent.Value ~= nil and Parent.Value ~= State and Parent.Type == "Toggle" then
            Parent:SetValue(State)
        end
        if KP.Row then
            KP.Row.Text = string.format("[%s]  %s", KP.Value, KP.Text)
            KP.Row.TextColor3 = State and Library.Scheme.Accent or Library.Scheme.SubText
            KP.Row.Visible = KP.Value ~= "None" and not Disabled
            Library:UpdateKeybindList()
        end
    end

    function KP:OnChanged(F) KP.Changed = F end
    function KP:OnClick(F) KP.Clicked = F end

    function KP:DoClick()
        if Picking or Parent.Disabled then return end
        Library:SafeCallback(KP.Callback, KP.Toggled)
        Library:SafeCallback(KP.Clicked, KP.Toggled)
        if IsButton then Library:SafeCallback(Parent.Func, KP.Toggled) end
        if Library.ToggleKeybind == KP then Library:Toggle() end
    end

    function KP:SetValue(Data)
        local Key, Mode = Data[1], Data[2]
        local Valid = Key == "None" or SpecialKeys[Key] ~= nil or pcall(function() return Enum.KeyCode[Key] end)
        KP.Value = (Key == nil or Key == "None") and "None" or (Valid and Key or "Unknown")
        if Mode and ModeButtons[Mode] then KP.Mode = Mode end
        KP:Update()
        local Code
        if KP.Value ~= "None" and KP.Value ~= "Unknown" then
            Code = SpecialKeys[KP.Value] or Enum.KeyCode[KP.Value]
        end
        Library:SafeCallback(KP.ChangedCallback, Code, {})
        Library:SafeCallback(KP.Changed, Code, {})
    end

    function KP:SetText(T) KP.Text = T; KP:Update() end
    function KP:SetMenuVisibility(V) if KP.Row then KP.Row.Visible = V; Library:UpdateKeybindList() end end

    table.insert(KP.Connections, Pill.MouseButton1Click:Connect(function()
        if Picking or Library.IsPicking or Parent.Disabled then return end
        Picking, Library.IsPicking = true, true
        Parent.AnyKeyPickerPicking = true
        KP:Update()
        local Conn
        Conn = UserInputService.InputBegan:Connect(function(Input)
            local Key
            if Input.UserInputType == Enum.UserInputType.Keyboard then
                Key = Input.KeyCode == Enum.KeyCode.Escape and "None" or Input.KeyCode.Name
            elseif SpecialKeysInput[Input.UserInputType] then
                Key = SpecialKeysInput[Input.UserInputType]
            else
                return
            end
            Conn:Disconnect()
            task.defer(function()
                Picking, Library.IsPicking = false, false
                Parent.AnyKeyPickerPicking = false
                KP.Toggled = Parent.Type == "Toggle" and Parent.Value or false
                KP:SetValue({ Key, KP.Mode })
            end)
        end)
        table.insert(KP.Connections, Conn)
    end))
    table.insert(KP.Connections, Pill.MouseButton2Click:Connect(function()
        if not Parent.Disabled and #KP.Modes > 1 then Menu:Toggle() end
    end))

    table.insert(KP.Connections, UserInputService.InputBegan:Connect(function(Input)
        if Library.Unloaded or Picking or Library.IsPicking or Parent.Disabled or KP.Mode == "Always" then return end
        if KP.Value == "None" or KP.Value == "Unknown" or UserInputService:GetFocusedTextBox() then return end
        local Hit = (SpecialKeysInput[Input.UserInputType] == KP.Value and not Library.Toggled)
            or (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == KP.Value)
        if not Hit then return end

        if KP.Mode == "Toggle" then
            KP.Toggled = not KP.Toggled
            KP:DoClick()
        elseif KP.Mode == "Press" then
            KP:DoClick()
        elseif KP.Mode == "Hold" then
            KP.Toggled = true
            KP:DoClick()
        end
        KP:Update()
    end))
    table.insert(KP.Connections, UserInputService.InputEnded:Connect(function(Input)
        if KP.Mode ~= "Hold" or not KP.Toggled then return end
        if (SpecialKeysInput[Input.UserInputType] == KP.Value) or (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == KP.Value) then
            KP.Toggled = false
            KP:DoClick()
            KP:Update()
        end
    end))

    function KP:Destroy()
        KP.Destroyed = true
        Library.ThemeHooks[KP] = nil
        for _, C in KP.Connections do C:Disconnect() end
        Menu:Destroy()
        Pill:Destroy()
        if KP.Row then
            KP.Row:Destroy()
            local I = table.find(Library.KeybindPickers, KP)
            if I then table.remove(Library.KeybindPickers, I) end
            Library:UpdateKeybindList()
        end
        local I = table.find(Parent.Addons, KP)
        if I then table.remove(Parent.Addons, I) end
        Options[Idx] = nil
    end

    KP:Update()
    Library.ThemeHooks[KP] = function() KP:Update() end
    KP.Default = KP.Value
    table.insert(Parent.Addons, KP)
    Options[Idx] = KP
    return self
end

--// ColorPicker addon \\--
function AddonFuncs:AddColorPicker(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
    Info = Library:Validate(Info, Templates.ColorPicker)
    local Parent = self
    Parent.Addons = Parent.Addons or {}

    local CP = {
        Type = "ColorPicker", ParentObj = Parent, Value = Info.Default, Transparency = Info.Transparency or 0,
        HasAlpha = Info.Transparency ~= nil, Title = Info.Title, Callback = Info.Callback, Changed = Info.Changed, Connections = {},
    }
    CP.Hue, CP.Sat, CP.Val = CP.Value:ToHSV()

    local Swatch = New("TextButton", { BackgroundColor3 = CP.Value, BackgroundTransparency = 0, Size = UDim2.fromOffset(18, 18), LayoutOrder = #Parent.Addons + 2, Parent = Parent.AddonHolder })
    Corner(Swatch, 99)
    Stroke(Swatch, "Text", 1, 0.75)

    local Popup = Library:CreatePopup(Swatch, { Width = 214, AutoY = true, AlignRight = true })
    local Content = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Popup.Frame })
    List(Content, 8)
    Pad(Content, 12, 12, 12, 12)

    if typeof(CP.Title) == "string" then
        New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = CP.Title, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, Parent = Content })
    end

    local SV = New("TextButton", { BackgroundColor3 = Color3.fromHSV(CP.Hue, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 120), ClipsDescendants = true, Parent = Content })
    Corner(SV, 6)
    local WhiteOverlay = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = SV })
    New("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }), Parent = WhiteOverlay })
    local BlackOverlay = New("Frame", { BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Parent = SV })
    New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }), Parent = BlackOverlay })
    local SVCursor = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(12, 12), Parent = SV })
    Corner(SVCursor, 99)
    Stroke(SVCursor, Color3.new(1, 1, 1), 2, 0)

    local function MakeBar(Height)
        local Bar = New("TextButton", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, Height), Parent = Content })
        Corner(Bar, 99)
        local Cur = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(Height + 2, Height + 2), Parent = Bar })
        Corner(Cur, 99)
        Stroke(Cur, Color3.new(0, 0, 0), 1, 0.7)
        return Bar, Cur
    end

    local HueBar, HueCursor = MakeBar(12)
    local Seq = {}
    for I = 0, 6 do table.insert(Seq, ColorSequenceKeypoint.new(I / 6, Color3.fromHSV(I / 6, 1, 1))) end
    New("UIGradient", { Color = ColorSequence.new(Seq), Parent = HueBar })

    local AlphaBar, AlphaCursor, AlphaGradient
    if CP.HasAlpha then
        AlphaBar, AlphaCursor = MakeBar(12)
        AlphaBar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        local Over = New("Frame", { BackgroundColor3 = CP.Value, Size = UDim2.fromScale(1, 1), Parent = AlphaBar })
        Corner(Over, 99)
        AlphaGradient = New("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }), Parent = Over })
        CP.AlphaOverlay = Over
        AlphaCursor.ZIndex = 5
    end

    local Hex = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 24), ClearTextOnFocus = false, Text = "", Parent = Content })
    Corner(Hex, 6)

    function CP:Display()
        if Library.Unloaded then return end
        CP.Value = Color3.fromHSV(CP.Hue, CP.Sat, CP.Val)
        Swatch.BackgroundColor3 = CP.Value
        Swatch.BackgroundTransparency = CP.HasAlpha and CP.Transparency * 0.8 or 0
        SV.BackgroundColor3 = Color3.fromHSV(CP.Hue, 1, 1)
        SVCursor.Position = UDim2.fromScale(CP.Sat, 1 - CP.Val)
        HueCursor.Position = UDim2.fromScale(CP.Hue, 0.5)
        if CP.HasAlpha then
            CP.AlphaOverlay.BackgroundColor3 = CP.Value
            AlphaCursor.Position = UDim2.fromScale(1 - CP.Transparency, 0.5)
        end
        Hex.Text = "#" .. CP.Value:ToHex():upper()
    end

    function CP:RunChanged()
        if Parent.Disabled then return end
        Library:SafeCallback(CP.Callback, CP.Value)
        Library:SafeCallback(CP.Changed, CP.Value)
    end
    function CP:Update() CP:Display(); CP:RunChanged() end
    function CP:OnChanged(F) CP.Changed = F end
    function CP:SetValueRGB(Color, Transparency)
        CP.Transparency = CP.HasAlpha and math.clamp(tonumber(Transparency) or 0, 0, 1) or 0
        CP.Hue, CP.Sat, CP.Val = Color:ToHSV()
        CP:Update()
    end
    function CP:SetValue(HSV, Transparency)
        if typeof(HSV) == "Color3" then return CP:SetValueRGB(HSV, Transparency) end
        CP:SetValueRGB(Color3.fromHSV(HSV[1], HSV[2], HSV[3]), Transparency)
    end

    local function Drag(Gui, Fn)
        table.insert(CP.Connections, Gui.InputBegan:Connect(function(Input)
            if not IsPress(Input) then return end
            while Input.UserInputState ~= Enum.UserInputState.End
                and Input.UserInputState ~= Enum.UserInputState.Cancel and not CP.Destroyed do
                Fn(MousePos())
                RunService.RenderStepped:Wait()
            end
        end))
    end
    Drag(SV, function(M)
        CP.Sat = math.clamp((M.X - SV.AbsolutePosition.X) / math.max(SV.AbsoluteSize.X, 1), 0, 1)
        CP.Val = 1 - math.clamp((M.Y - SV.AbsolutePosition.Y) / math.max(SV.AbsoluteSize.Y, 1), 0, 1)
        CP:Update()
    end)
    Drag(HueBar, function(M)
        CP.Hue = math.clamp((M.X - HueBar.AbsolutePosition.X) / math.max(HueBar.AbsoluteSize.X, 1), 0, 1)
        CP:Update()
    end)
    if AlphaBar then
        Drag(AlphaBar, function(M)
            CP.Transparency = 1 - math.clamp((M.X - AlphaBar.AbsolutePosition.X) / math.max(AlphaBar.AbsoluteSize.X, 1), 0, 1)
            CP:Update()
        end)
    end
    table.insert(CP.Connections, Hex.FocusLost:Connect(function()
        local Ok, C = pcall(Color3.fromHex, Hex.Text)
        if Ok and typeof(C) == "Color3" then CP.Hue, CP.Sat, CP.Val = C:ToHSV() end
        CP:Update()
    end))
    table.insert(CP.Connections, Swatch.MouseButton1Click:Connect(function()
        if not Parent.Disabled then Popup:Toggle() end
    end))

    function CP:Destroy()
        CP.Destroyed = true
        for _, C in CP.Connections do C:Disconnect() end
        Popup:Destroy()
        Swatch:Destroy()
        local I = table.find(Parent.Addons, CP)
        if I then table.remove(Parent.Addons, I) end
        Options[Idx] = nil
    end

    CP:Display()
    CP.Default = CP.Value
    table.insert(Parent.Addons, CP)
    Options[Idx] = CP
    return self
end

--// Search \\--
local function ElementMatches(El, S)
    if Fuzzy(Library:StripRich(El.Text), S) or Fuzzy(El.Tooltip, S) then return true end
    if El.SubButton and Fuzzy(El.SubButton.Text, S) then return true end
    if El.Type == "Dropdown" and typeof(El.Values) == "table" then
        local N = 0
        for _, V in El.Values do
            N += 1
            if N > 150 then break end
            if Fuzzy(tostring(V), S) then return true end
        end
    end
    return false
end

local function SetHL(El, Query)
    for _, Target in { El, El.SubButton } do
        local L = Target.LabelObj
        if L and L.Parent and typeof(Target.Text) == "string" then
            L.Text = (Query and Query ~= "") and Library:HighlightText(Target.Text, Query) or Library:ToRichText(Target.Text)
        end
    end
end

local function ApplyBox(Box, S, Force)
    local Count = 0
    for _, El in Box.Elements do
        if El.Type == "Divider" then
            El.Holder.Visible = false
        else
            local Vis = El.Visible ~= false and (Force or ElementMatches(El, S))
            El.Holder.Visible = Vis
            SetHL(El, Vis and Library.SearchRaw or nil)
            if Vis then Count += 1 end
        end
    end
    for _, D in Box.DependencyBoxes do
        if D.Visible then
            local C = ApplyBox(D, S, Force)
            D.Holder.Visible = C > 0
            Count += C
        end
    end
    return Count
end

local function ResetBox(Box)
    for _, El in Box.Elements do
        El.Holder.Visible = El.Visible ~= false
        SetHL(El, nil)
    end
    for _, D in Box.DependencyBoxes do
        D.Holder.Visible = D.Visible
        ResetBox(D)
    end
end

function Library:BuildSearchIndex()
    local Index = {}
    local function Add(E) E.Order = #Index + 1; table.insert(Index, E) end
    local function Join(A, B, C, D)
        local P = {}
        for _, V in { A or false, B or false, C or false, D or false } do
            if V then table.insert(P, V) end
        end
        return table.concat(P, "  ›  ")
    end
    local function Walk(Box, Ctx)
        for _, El in Box.Elements do
            if El.Type ~= "Divider" and typeof(El.Text) == "string" and El.Text ~= "" then
                Add({ Tab = Ctx.Tab, Page = Ctx.Page, Group = Ctx.Group, SubTab = Ctx.SubTab, Element = El, Target = El.Holder,
                    Text = Library:StripRich(El.Text), Extra = El.Tooltip, Type = El.Type, Path = Ctx.Path })
            end
        end
        for _, D in Box.DependencyBoxes do Walk(D, Ctx) end
    end

    for _, Tab in Library.TabList do
        if not Tab.IsKeyTab then
            Add({ Tab = Tab, Text = Tab.Name, Type = "Tab", Path = "Tab", Extra = Tab.Description })
            local PageOf = {}
            for _, P in Tab.Pages do
                PageOf[P] = true
                Add({ Tab = Tab, Page = P, Text = P.Name, Type = "Page", Path = Tab.Name })
                for _, G in P.Groupboxes do PageOf[G] = P end
                for _, TB in P.Tabboxes do PageOf[TB] = P end
            end
            for _, G in Tab.Groupboxes do
                local P = PageOf[G]
                Add({ Tab = Tab, Page = P, Group = G, Target = G.BoxHolder, Text = G.Name, Type = "Group", Path = Join(Tab.Name, P and P.Name) })
                Walk(G, { Tab = Tab, Page = P, Group = G, Path = Join(Tab.Name, P and P.Name, G.Name) })
            end
            for _, TB in Tab.Tabboxes do
                local P = PageOf[TB]
                for SName, ST in TB.Tabs do
                    Add({ Tab = Tab, Page = P, Group = TB, SubTab = ST, Target = TB.BoxHolder, Text = tostring(SName), Type = "Tabbox", Path = Join(Tab.Name, P and P.Name) })
                    Walk(ST, { Tab = Tab, Page = P, Group = TB, SubTab = ST, Path = Join(Tab.Name, P and P.Name, tostring(SName)) })
                end
            end
        end
    end
    Library.SearchIndex = Index
    return Index
end

function Library:SearchEntries(Query, Limit)
    local Index = Library.SearchIndex or Library:BuildSearchIndex()
    local Q = Trim(tostring(Query or "")):lower()
    local N = NormalizeSearch(Q)
    local Scored = {}
    for _, E in Index do
        local Score = 0
        if N == "" then
            Score = 1
        else
            local Lo = E.Text:lower()
            local A = Lo:find(Q, 1, true)
            if A then Score = 1000 - A + (A == 1 and 200 or 0) - #Lo * 0.2
            elseif Fuzzy(E.Text, N) then Score = 100
            elseif E.Extra and Fuzzy(tostring(E.Extra), N) then Score = 50
            elseif Fuzzy(E.Path, N) then Score = 20 end
            if E.Type == "Tab" or E.Type == "Page" or E.Type == "Group" then Score *= 0.9 end
        end
        if Score > 0 then table.insert(Scored, { E = E, S = Score }) end
    end
    table.sort(Scored, function(A, B)
        if A.S ~= B.S then return A.S > B.S end
        return A.E.Order < B.E.Order
    end)
    local Out = {}
    for I = 1, math.min(#Scored, Limit or 40) do Out[I] = Scored[I].E end
    return Out
end

function Library:JumpTo(E)
    if not E or not E.Tab then return end
    E.Tab:Show()
    if E.Page then E.Page:Show() end
    if E.Group then local G = E.Group while G and G.Type ~= "Groupbox" and G.Type ~= "NestedGroupbox" do G = G.ParentGroup end if G and G.Collapsed then G:SetCollapsed(false) end end
    if E.SubTab then E.SubTab:Show() end
    local Target = E.Target
    if not Target then return end

    task.spawn(function()
        RunService.RenderStepped:Wait()
        RunService.RenderStepped:Wait()
        if not Target.Parent then return end
        local Side = Target:FindFirstAncestorOfClass("ScrollingFrame")
        if Side then
            local Y = Target.AbsolutePosition.Y - Side.AbsolutePosition.Y + Side.CanvasPosition.Y - 56
            Tween(Side, { CanvasPosition = Vector2.new(0, math.max(0, Y)) }, Library.SlowTween)
        end
        local L = E.Element and E.Element.LabelObj
        if L then
            local Orig = L.TextColor3
            local Reg = Library.Registry[L]
            local RegKey = Reg and Reg.TextColor3
            local function Restore()
                if typeof(RegKey) == "string" and Library.Scheme[RegKey] then
                    L.TextColor3 = Library.Scheme[RegKey]
                else
                    L.TextColor3 = Orig
                end
            end
            for _ = 1, 3 do
                if not L.Parent then return end
                L.TextColor3 = Library.Scheme.Accent
                task.wait(0.25)
                if not L.Parent then return end
                Restore()
                task.wait(0.2)
            end
            Restore()
        end
    end)
end

function Library:UpdateSearch(Text)
    Library.SearchText = Text
    Library.SearchRaw = Trim(Text)
    for _, Tab in Library.TabList do Tab:ResetSearch() end

    local S = NormalizeSearch(Text)
    if S == "" then
        Library.Searching = false
        return
    end
    Library.Searching = true

    local First, ActiveHas
    for _, Tab in Library.TabList do
        local Has = Tab:ApplySearch(S)
        Tab.Button.Visible = Has and Tab.TabVisible ~= false
        if Has then
            First = First or Tab
            if Tab == Library.ActiveTab then ActiveHas = true end
        end
    end
    if not ActiveHas and First then First:Show() end
end

--// Notifications \\--
local NotifyArea = New("Frame", {
    BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12),
    Size = UDim2.new(0, 330, 1, -24), ZIndex = 50, Parent = ScreenGui,
})
local NotifyList = List(NotifyArea, 8)
Library.DPIScales[New("UIScale", { Parent = NotifyArea })] = true

function Library:SetNotifySide(Side)
    Library.NotifySide = Side
    local Left = tostring(Side):lower() == "left"
    NotifyArea.AnchorPoint = Left and Vector2.new(0, 0) or Vector2.new(1, 0)
    NotifyArea.Position = Left and UDim2.new(0, 12, 0, 12) or UDim2.new(1, -12, 0, 12)
    NotifyList.HorizontalAlignment = Left and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right
end

function Library:KickScrolls()
    local T = Library.ActiveTab
    if not T then return end
    for _, S in (T.Sides or {}) do
        if typeof(S) == "Instance" and S:IsA("ScrollingFrame") then
            local CP = S.CanvasPosition
            S.AutomaticCanvasSize = Enum.AutomaticSize.None
            S.CanvasSize = UDim2.fromOffset(0, 0)
            S.AutomaticCanvasSize = Enum.AutomaticSize.Y
            S.CanvasPosition = CP
        end
    end
end

function Library:Notify(...)
    local Info = ...
    local Data = {}
    if typeof(Info) == "table" then
        Data.Title = Info.Title and tostring(Info.Title) or Library.AppName
        Data.Description = Info.Description and tostring(Info.Description) or ""
        Data.Time = Info.Time or 5
        Data.Persist = Info.Persist
        Data.Icon = Info.Icon
        Data.IconColor = Info.IconColor
        Data.Callback = Info.Callback
        Data.OnClick, Data.OnDismiss = Info.OnClick, Info.OnDismiss
    else
        Data.Title = Library.AppName
        Data.Description = tostring(Info)
        Data.Time = select(2, ...) or 5
    end

    Data.StackKey = Data.Title .. "\n" .. Data.Description
    Data.BaseTitle = Data.Title
    Data.Count = 1
    Library.NotifyStack = Library.NotifyStack or {}
    local Existing = Library.NotifyStack[Data.StackKey]
    if Existing and not Existing.Destroyed then
        Existing.Count += 1
        Existing.Born = os.clock()
        Existing:ChangeTitle(Existing.BaseTitle .. (Existing.Count > 1 and "  x" .. Existing.Count or ""))
        if Existing.Timer then
            pcall(task.cancel, Existing.Timer)
            Existing.Timer = nil
        end
        if not Existing.Persist then
            Existing.Timer = task.delay(Existing.Time or 5, function() Existing:Destroy("timer") end)
        end
        return Existing
    end

    Data.Born = os.clock()
    local Count, Oldest = 0, nil
    for _, D in Library.Notifications do
        Count += 1
        if not Oldest or (D.Born or 0) < (Oldest.Born or math.huge) then Oldest = D end
    end
    if Count >= 6 and Oldest and Oldest.Destroy then Oldest:Destroy("overflow") end

    local Left = Library.NotifySide:lower() == "left"
    local Wrapper = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = NotifyArea })
    local Card = New("TextButton", {
        BackgroundColor3 = "Popup", BackgroundTransparency = 0.04, AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromOffset(Left and -360 or 360, 0), Size = UDim2.new(1, 0, 0, 0), Parent = Wrapper,
    })
    Corner(Card, 14)
    Library:AddSurface(Card, 0.04, 0.5)
    Library:AddGlass(Card)
    Stroke(Card, "Outline", 1, 0.3)
    Pad(Card, 10, 12, 10, 12)

    local Content = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 34), Parent = Card })
    local Badge = New("Frame", { BackgroundColor3 = Data.IconColor or "Accent", Size = UDim2.fromOffset(34, 34), Parent = Content })
    Corner(Badge, 9)
    local BadgeIcon = Library:GetCustomIcon(Data.Icon or "leaf")
    if BadgeIcon then
        local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(20, 20), ImageColor3 = "AccentText", Parent = Badge })
        Library:ApplyIcon(Img, BadgeIcon)
    else
        New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Data.Title:sub(1, 1):upper(), FontFace = "FontBold", TextSize = 16, TextColor3 = "AccentText", Parent = Badge })
    end

    local Texts = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(44, 0), Size = UDim2.new(1, -44, 0, 0), Parent = Content })
    List(Texts, 2)
    local TitleRich = Library:RenderRich(Texts, Data.Title, { Size = 13, Bold = true, LayoutOrder = 1 })
    local Desc
    if Data.Description ~= "" then
        Desc = Library:RenderRich(Texts, Data.Description, { Size = 12, Color = "SubText", LayoutOrder = 2 })
    end

    function Data:ChangeDescription(T) if Desc then Desc:SetText(tostring(T)) end end
    function Data:ChangeTitle(T) TitleRich:SetText(tostring(T)) end
    function Data:Destroy(Reason)
        if Data.Destroyed then return end
        Data.Destroyed = true
        Library.Notifications[Wrapper] = nil
        if Data.Timer then
            pcall(task.cancel, Data.Timer)
            Data.Timer = nil
        end
        if Library.NotifyStack and Library.NotifyStack[Data.StackKey] == Data then
            Library.NotifyStack[Data.StackKey] = nil
        end
        if typeof(Data.Callback) == "function" then pcall(Data.Callback, Reason or "script") end
        if typeof(Data.OnDismiss) == "function" then pcall(Data.OnDismiss, Reason or "script") end
        Tween(Card, { Position = UDim2.fromOffset(Left and -360 or 360, 0) }, Library.SlowTween)
        task.delay(0.3, function() Wrapper:Destroy() end)
    end

    Card.MouseButton1Click:Connect(function()
        if typeof(Data.OnClick) == "function" then pcall(Data.OnClick, Data) end
        Data:Destroy("user")
    end)
    Library.Notifications[Wrapper] = Data
    Library.NotifyStack = Library.NotifyStack or {}
    Library.NotifyStack[Data.StackKey] = Data
    Tween(Card, { Position = UDim2.fromOffset(0, 0) }, Library.SlowTween)

    if not Data.Persist then
        Data.Timer = task.delay(Data.Time, function() Data:Destroy("timer") end)
    end
    return Data
end

--// Window \\--
--// UI blur / glass / wallpaper \\--
local Lighting = GetService("Lighting")
local BlurEffect -- only used when GlassMode = "Full"
local GlassFolder, GlassDoF
local GlassDepth = 0.001

local function RandName() return string.sub(tostring({}), 8, 17) end

local function GlassShown(Frame)
    local Cur = Frame
    while Cur and Cur ~= ScreenGui do
        if Cur:IsA("GuiObject") and not Cur.Visible then return false end
        Cur = Cur.Parent
    end
    return Cur == ScreenGui
end

local function HideGlass()
    for _, G in Library.GlassFrames do
        if G.Part then G.Part.Parent = nil end
    end
    if GlassDoF then GlassDoF.Parent = nil end
end

-- Region blur: a near-transparent glass part sits right in front of the camera exactly over each UI frame, and a
-- DepthOfField that only blurs things closer than ~0.05 studs. Result: only the area behind the UI gets blurred.
local GlassActive = false
local function UpdateGlass()
    if Library.Unloaded then return end
    local Cam = workspace.CurrentCamera
    if not (Library.BlurEnabled and Library.GlassMode == "Region" and Cam and Library.Toggled)
        or next(Library.GlassFrames) == nil then
        if GlassActive then HideGlass(); GlassActive = false end
        return
    end
    GlassActive = true

    if not GlassFolder then
        GlassFolder = Instance.new("Folder")
        GlassFolder.Name = RandName()
    end
    if GlassFolder.Parent ~= Cam then GlassFolder.Parent = Cam end

    if not GlassDoF then
        GlassDoF = Instance.new("DepthOfFieldEffect")
        GlassDoF.Name = RandName()
        GlassDoF.FarIntensity = 0
        GlassDoF.FocusDistance = 0.05
        GlassDoF.InFocusRadius = 0.1
    end
    GlassDoF.NearIntensity = math.clamp(Library.BlurSize / 40, 0.05, 1)
    GlassDoF.Parent = Lighting

    local function ToWorld(P)
        local R = Cam:ScreenPointToRay(P.X, P.Y)
        return R.Origin + R.Direction * GlassDepth
    end

    for Frame, G in Library.GlassFrames do
        if Frame.Parent and GlassShown(Frame) then
            local Size = Frame.AbsoluteSize
            local Pos = Frame.AbsolutePosition
            if Size.X > 2 and Size.Y > 2 then
                if not G.Part then
                    local Part = Instance.new("Part")
                    Part.Name = RandName()
                    Part.Material = Enum.Material.Glass
                    Part.Color = Color3.new(0, 0, 0)
                    Part.Transparency = 0.98
                    Part.Anchored = true
                    Part.CanCollide = false
                    Part.CanQuery = false
                    Part.CanTouch = false
                    Part.CastShadow = false
                    Part.Locked = true
                    Part.Size = Vector3.new(1, 1, 0)
                    local Mesh = Instance.new("SpecialMesh")
                    Mesh.MeshType = Enum.MeshType.Brick
                    Mesh.Offset = Vector3.new(0, 0, -0.000001)
                    Mesh.Parent = Part
                    G.Part, G.Mesh = Part, Mesh
                    G.LastX = nil -- force first placement
                end
                if G.LastX ~= Pos.X or G.LastY ~= Pos.Y or G.LastW ~= Size.X or G.LastH ~= Size.Y
                    or G.LastFolder ~= GlassFolder then
                    G.LastX, G.LastY, G.LastW, G.LastH = Pos.X, Pos.Y, Size.X, Size.Y
                    G.LastFolder = GlassFolder
                    local TL, TR, BR = ToWorld(Pos), ToWorld(Pos + Vector2.new(Size.X, 0)), ToWorld(Pos + Size)
                    G.Part.CFrame = CFrame.fromMatrix((TL + BR) / 2, Cam.CFrame.XVector, Cam.CFrame.YVector, Cam.CFrame.ZVector)
                    G.Mesh.Scale = Vector3.new((TR - TL).Magnitude, (TR - BR).Magnitude, 0)
                    G.Part.Parent = GlassFolder
                elseif G.Part.Parent ~= GlassFolder then
                    G.Part.Parent = GlassFolder
                end
            elseif G.Part and G.Part.Parent then
                G.Part.Parent = nil
            end
        elseif G.Part and G.Part.Parent then
            G.Part.Parent = nil
        end
    end
end

local GlassBind = "Evergreen" .. RandName()
RunService:BindToRenderStep(GlassBind, Enum.RenderPriority.Last.Value, UpdateGlass)

-- "Full" mode keeps the classic whole-screen blur as a fallback
function Library:UpdateBlur(Instant)
    local Want = Library.GlassMode == "Full" and Library.BlurEnabled and Library.Toggled and not Library.Unloaded
    if not Want and not BlurEffect then return end
    if not BlurEffect or not BlurEffect.Parent then
        BlurEffect = Instance.new("BlurEffect")
        BlurEffect.Name = RandName()
        BlurEffect.Size = 0
        BlurEffect.Parent = Lighting
    end
    local Target = Want and Library.BlurSize or 0
    if Instant then BlurEffect.Size = Target else Tween(BlurEffect, { Size = Target }, Library.SlowTween) end
end

-- SetBlur(true, 18) / SetBlur(false) / SetBlur(18)   (blurs only behind the UI unless GlassMode = "Full")
function Library:SetBlur(Enabled, Size)
    if typeof(Enabled) == "number" then Size = Enabled; Enabled = Enabled > 0 end
    Library.BlurEnabled = Enabled == true
    if Size then Library.BlurSize = math.clamp(tonumber(Size) or 16, 0, 56) end
    Library:UpdateBlur()
end

function Library:SetGlassMode(Mode)
    Library.GlassMode = (Mode == "Full") and "Full" or "Region"
    Library:UpdateBlur()
end

Library.GlassEnabled = false
Library.GlassTransparency = 0.35
Library._PreGlassTransparency = nil
Library._PreGlassBlur = nil

-- Frosted glass: raises UI transparency and enables background blur.
function Library:SetGlass(Enabled, Transparency)
    Enabled = Enabled == true
    if Transparency then Library.GlassTransparency = math.clamp(tonumber(Transparency) or 0.35, 0.1, 0.7) end
    if Enabled and not Library.GlassEnabled then
        Library._PreGlassTransparency = Library.UITransparency
        Library._PreGlassBlur = Library.BlurEnabled
        Library.GlassEnabled = true
        Library:SetTransparency(math.max(Library.UITransparency, Library.GlassTransparency))
        Library:SetBlur(true, Library.BlurSize > 0 and Library.BlurSize or 18)
    elseif not Enabled and Library.GlassEnabled then
        Library.GlassEnabled = false
        Library:SetTransparency(Library._PreGlassTransparency or 0)
        if Library._PreGlassBlur == false then Library:SetBlur(false) end
        Library._PreGlassTransparency, Library._PreGlassBlur = nil, nil
    elseif Enabled then
        Library:SetTransparency(math.max(Library.UITransparency, Library.GlassTransparency))
        Library:SetBlur(true, Library.BlurSize > 0 and Library.BlurSize or 18)
    end
end

Library.WallpaperImage = nil
Library.WallpaperTransparency = 0.55

function Library:SetWallpaper(Image, Transparency)
    if Transparency ~= nil then
        Library.WallpaperTransparency = math.clamp(tonumber(Transparency) or 0.55, 0, 0.95)
    end
    if Image == false or Image == nil or Image == "" then
        Library.WallpaperImage = nil
    else
        local Url = tostring(Image)
        if tonumber(Url) then Url = "rbxassetid://" .. Url end
        Library.WallpaperImage = Url
    end
    local W = Library.Window
    if W and W.Wallpaper then
        if Library.WallpaperImage then
            W.Wallpaper.Image = Library.WallpaperImage
            W.Wallpaper.ImageTransparency = Library.WallpaperTransparency
            W.Wallpaper.Visible = true
        else
            W.Wallpaper.Visible = false
        end
    end
end

function Library:DestroyBlur()
    pcall(function() RunService:UnbindFromRenderStep(GlassBind) end)
    for _, G in Library.GlassFrames do
        if G.Part then G.Part:Destroy() G.Part = nil end
    end
    if GlassDoF then GlassDoF:Destroy() GlassDoF = nil end
    if GlassFolder then GlassFolder:Destroy() GlassFolder = nil end
    if BlurEffect then BlurEffect:Destroy() BlurEffect = nil end
end

--// Dock: floating top-center button bar (macOS dock style) \\--
-- Library:CreateDock({ Position = "Top", Draggable = true, Defaults = true, Tabs = false })
-- Dock:AddButton({ Name, Icon, Tooltip, Toggle, Default, Active = function() end, Color, Callback = function(State, Btn) end })
-- Dock:RemoveButton("Keybinds") / Dock:SetButtonIcon("Toggle UI", "sun") / Dock:SetCollapsed(true) or the chevron at the dock's right
-- CreateDock opts: ToggleIcon = "eye", KeybindButton = false skips the keybind-list button, Scale = 0.8 (smaller dock); set Dock.OnCollapseChanged = fn after creation
-- Dock:AddTab(Tab) / Dock:RemoveTab(Tab) — window tabs are NOT added automatically; add exactly the ones you want
--   manually (e.g. Dock:AddTab(Window.MainTab)). Pass Tabs = true to restore the old auto-sync of every window tab
--   (Dock:SyncTabs() also still works on demand either way).
function Library:CreateDock(Opt)
    if Library.Dock then return Library.Dock end
    Opt = Library:Validate(Opt, { Position = "Top", Offset = 12, Draggable = true, Defaults = true, Tabs = false, ToggleIcon = "eye", KeybindButton = true, Scale = 1 })
    local S = math.clamp(tonumber(Opt.Scale) or 1, 0.4, 2)
    local Bottom = Opt.Position == "Bottom"

    local Frame = New("Frame", {
        BackgroundColor3 = "Popup", AutomaticSize = Enum.AutomaticSize.X, AnchorPoint = Vector2.new(0.5, Bottom and 1 or 0),
        Position = UDim2.new(0.5, 0, Bottom and 1 or 0, Bottom and -Opt.Offset or Opt.Offset), Size = UDim2.fromOffset(0, math.floor(54 * S)), Parent = Floats,
    })
    Corner(Frame, math.floor(16 * S))
    Stroke(Frame, "Outline", 1, 0.3)
    Pad(Frame, math.floor(7 * S), math.floor(9 * S), math.floor(7 * S), math.floor(9 * S))
    List(Frame, 6 * S, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    Library:AddSurface(Frame, 0, 0.5)
    Library:AddGlass(Frame)
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Frame })] = true

    local Grip = New("TextButton", {
        BackgroundTransparency = 1, Size = UDim2.fromOffset(math.floor(14 * S), math.floor(40 * S)), LayoutOrder = -100,
        AutoButtonColor = false, Text = "", Parent = Frame,
    })
    local GripBar = New("Frame", {
        BackgroundColor3 = "Outline", BackgroundTransparency = 0.25,
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(math.max(1, math.floor(3 * S)), math.floor(22 * S)), Parent = Grip,
    })
    Corner(GripBar, 99)
    Library:AddTooltip("Drag dock", Grip)

    local Dock = { Frame = Frame, Buttons = {}, TabButtons = {}, Order = 0, Draggable = Opt.Draggable == true, AutoTabs = Opt.Tabs == true, Scale = S }
    local PopTween = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    if Dock.Draggable then
        local Dragging, DragMoved, StartPos, StartFrame = false, false, nil, nil
        Grip.InputBegan:Connect(function(Input)
            if not IsPress(Input) or not Dock.Draggable then return end
            Dragging, DragMoved = true, false
            StartPos, StartFrame = Input.Position, Frame.Position
            local Conn
            Conn = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End or Input.UserInputState == Enum.UserInputState.Cancel then
                    Dragging = false
                    if Conn then Conn:Disconnect() end
                end
            end)
        end)
        Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
            if not Dragging or not Dock.Draggable then return end
            if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
            local D = Input.Position - StartPos
            if not DragMoved and (math.abs(D.X) > 4 or math.abs(D.Y) > 4) then DragMoved = true end
            if not DragMoved then return end
            Frame.Position = UDim2.new(StartFrame.X.Scale, StartFrame.X.Offset + D.X, StartFrame.Y.Scale, StartFrame.Y.Offset + D.Y)
        end))
    end

    function Dock:AddButton(Info)
        Info = Library:Validate(Info, { Name = "Button", Icon = "circle", Toggle = false, Default = false, Callback = function() end })
        Dock.Order += 1

        local B = { Name = Info.Name, Info = Info, Active = Info.Default == true, Visible = true, IsTab = Info.IsTab == true, Tab = Info.Tab }
        local Btn = New("TextButton", { BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.fromOffset(math.floor(40 * S), math.floor(40 * S)), LayoutOrder = Dock.Order, Parent = Frame })
        Corner(Btn, math.floor(11 * S))
        local Scale = New("UIScale", { Parent = Btn })

        local Data = Library:GetCustomIcon(Info.Icon)
        local Glyphe
        if Data then
            Glyphe = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(math.floor(22 * S), math.floor(22 * S)), ImageColor3 = Data.Custom and Color3.new(1, 1, 1) or "SubText", Parent = Btn })
            Library:ApplyIcon(Glyphe, Data)
        else
            Glyphe = Glyph(Btn, Info.Icon, "●", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(math.floor(22 * S), math.floor(22 * S)), Color = "SubText" })
        end
        local Tint = not (Data and Data.Custom)

        function B:SetIcon(IconName)
            if typeof(IconName) ~= "string" or IconName == "" then return false end
            Info.Icon = IconName
            Data = Library:GetCustomIcon(IconName)
            if Glyphe then Glyphe:Destroy() end
            if Data then
                Glyphe = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(math.floor(22 * S), math.floor(22 * S)), ImageColor3 = Data.Custom and Color3.new(1, 1, 1) or "SubText", Parent = Btn })
                Library:ApplyIcon(Glyphe, Data)
            else
                Glyphe = Glyph(Btn, IconName, "●", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(math.floor(22 * S), math.floor(22 * S)), Color = "SubText" })
            end
            Tint = not (Data and Data.Custom)
            B:Refresh()
            return true
        end

        local Dot = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -2), Size = UDim2.fromOffset(math.max(2, math.floor(4 * S)), math.max(2, math.floor(4 * S))), Visible = false, Parent = Btn })
        Corner(Dot, 99)
        local Badge = New("TextLabel", { BackgroundColor3 = "Red", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -1, 0, 1), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 14), Text = "", TextSize = 9, TextColor3 = Color3.new(1, 1, 1), FontFace = "FontBold", Visible = false, Parent = Btn })
        Corner(Badge, 99)
        Pad(Badge, 0, 4, 0, 4)

        function B:IsActive()
            if typeof(Info.Active) == "function" then
                local Ok, R = pcall(Info.Active)
                return Ok and R == true
            end
            return B.Active
        end

        local Hover = false
        function B:Refresh()
            local On = B:IsActive()
            local C = typeof(Info.Color) == "Color3" and Info.Color or Library.Scheme.Accent
            local Col = On and C or (Hover and Library.Scheme.Text or Library.Scheme.SubText)
            if Tint then
                if Glyphe:IsA("ImageLabel") then Glyphe.ImageColor3 = Col else Glyphe.TextColor3 = Col end
            end
            Dot.Visible = On
            Dot.BackgroundColor3 = C
            Tween(Btn, { BackgroundTransparency = Hover and 0.55 or 1 })
            Tween(Scale, { Scale = Hover and 1.16 or 1 }, PopTween)
        end

        function B:SetActive(V) B.Active = V == true; B:Refresh() end
        function B:SetBadge(T)
            Badge.Visible = T ~= nil and tostring(T) ~= ""
            Badge.Text = tostring(T or "")
        end
        function B:SetVisible(V) B.Visible = V; Btn.Visible = V end
        function B:Destroy()
            Library.ThemeHooks[B] = nil
            local I = table.find(Dock.Buttons, B)
            if I then table.remove(Dock.Buttons, I) end
            local TI = table.find(Dock.TabButtons, B)
            if TI then table.remove(Dock.TabButtons, TI) end
            Btn:Destroy()
        end

        Btn.MouseEnter:Connect(function() Hover = true; B:Refresh() end)
        Btn.MouseLeave:Connect(function() Hover = false; B:Refresh() end)
        Btn.MouseButton1Down:Connect(function() Tween(Scale, { Scale = 0.92 }, Library.TweenInfo) end)
        Btn.MouseButton1Click:Connect(function()
            if Info.Toggle then B.Active = not B.Active end
            Library:SafeCallback(Info.Callback, B:IsActive(), B)
            Dock:Refresh()
        end)
        Library:AddTooltip(Info.Tooltip or Info.Name, Btn)
        Library.ThemeHooks[B] = function() B:Refresh() end

        B:Refresh()
        table.insert(Dock.Buttons, B)
        if B.IsTab then table.insert(Dock.TabButtons, B) end
        return B
    end

    function Dock:AddSeparator()
        Dock.Order += 1
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, Size = UDim2.fromOffset(math.max(1, math.floor(S)), math.floor(26 * S)), LayoutOrder = Dock.Order, Parent = Frame })
    end

    function Dock:AddTab(Tab, IconOverride)
        if typeof(Tab) ~= "table" or not Tab.Show then return end
        for _, B in Dock.TabButtons do
            if B.Tab == Tab then return B end
        end
        local Icon = IconOverride or Tab.Icon or "file"
        return Dock:AddButton({
            Name = Tab.Name or "Tab",
            Icon = Icon,
            Tooltip = Tab.Description or Tab.Name or "Open tab",
            IsTab = true,
            Tab = Tab,
            Active = function() return Library.ActiveTab == Tab end,
            Callback = function()
                if not Library.Toggled then Library:Toggle() end
                Tab:Show()
                Dock:Refresh()
            end,
        })
    end

    function Dock:SyncTabs()
        local Seen = {}
        for _, Tab in Library.Tabs do
            if Tab and Tab.Show and Tab.Visible ~= false then
                Seen[Tab] = true
                local Found
                for _, B in Dock.TabButtons do
                    if B.Tab == Tab then Found = B break end
                end
                if not Found then Dock:AddTab(Tab) end
            end
        end
        for I = #Dock.TabButtons, 1, -1 do
            local B = Dock.TabButtons[I]
            if not Seen[B.Tab] then B:Destroy() end
        end
        Dock:Refresh()
    end

    -- Manual counterpart of SyncTabs: removes only the dock button belonging to this tab.
    function Dock:RemoveTab(Tab)
        for I = #Dock.TabButtons, 1, -1 do
            local B = Dock.TabButtons[I]
            if B.Tab == Tab then B:Destroy() end
        end
        Dock:Refresh()
    end

    function Dock:SetDraggable(V)
        Dock.Draggable = V == true
        Grip.Visible = Dock.Draggable
    end

    function Dock:Refresh() for _, B in Dock.Buttons do B:Refresh() end end
    function Dock:SetVisible(V) local Vis = V == true; Frame.Visible = Vis and not Dock.Collapsed; if Dock.Chevron then Dock.Chevron.Visible = Vis end end
    function Dock:Destroy()
        for I = #Dock.Buttons, 1, -1 do Dock.Buttons[I]:Destroy() end
        if Dock.CB then Library.ThemeHooks[Dock.CB] = nil end
        if Dock.Chevron then Dock.Chevron:Destroy(); Dock.Chevron = nil end
        Frame:Destroy()
        Library.Dock = nil
    end

    if Opt.Defaults then
        Dock:AddButton({ Name = "Toggle UI", Icon = Opt.ToggleIcon or "eye", Tooltip = "Show / hide the UI",
            Active = function() return Library.Toggled end,
            Callback = function() Library:Toggle() end })
        if Opt.KeybindButton ~= false then
            Dock:AddButton({ Name = "Keybinds", Icon = "keyboard", Tooltip = "Keybind list",
                Active = function() return Library.KeybindListEnabled end,
                Callback = function() Library:SetKeybindListVisible(not Library.KeybindListEnabled) end })
        end
    end

    if Opt.Tabs then
        Dock:AddSeparator()
        task.defer(function()
            Dock:SyncTabs()
        end)
    end

    function Dock:RemoveButton(Target)
        if typeof(Target) == "string" then
            for _, B in Dock.Buttons do
                if B.Name == Target then Target = B break end
            end
        end
        if typeof(Target) == "table" and typeof(Target.Destroy) == "function" then
            Target:Destroy()
            Dock:Refresh()
            return true
        end
        return false
    end

    function Dock:SetButtonIcon(Target, IconName)
        if typeof(Target) == "string" then
            for _, B in Dock.Buttons do
                if B.Name == Target then Target = B break end
            end
        end
        if typeof(Target) == "table" and typeof(Target.SetIcon) == "function" then
            return Target:SetIcon(IconName)
        end
        return false
    end

    local CollapseScale = New("UIScale", { Scale = 1, Parent = Frame })
    local ChevronBtn = New("TextButton", {
        BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.fromOffset(math.floor(26 * S), math.floor(38 * S)),
        AutoButtonColor = false, Text = "", Parent = Floats,
    })
    Corner(ChevronBtn, 99)
    local ChevronStroke = Stroke(ChevronBtn, "Outline", 1, 1)
    local ChevronGlyph = Glyph(ChevronBtn, "chevron-left", "<", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(math.floor(16 * S), math.floor(16 * S)), Color = "SubText",
    })
    Dock.Chevron = ChevronBtn
    Dock.Collapsed = false
    Library:AddTooltip("Collapse dock", ChevronBtn)

    local CBHover = false
    local CB = { Glyph = ChevronGlyph }
    function CB:Refresh()
        local C = CBHover and Library.Scheme.Text or Library.Scheme.SubText
        if ChevronGlyph:IsA("ImageLabel") then ChevronGlyph.ImageColor3 = C else ChevronGlyph.TextColor3 = C end
        Tween(ChevronBtn, { BackgroundTransparency = Dock.Collapsed and (CBHover and 0 or 0.15) or (CBHover and 0.55 or 1) }, Library.TweenInfo)
    end
    Dock.CB = CB
    Library.ThemeHooks[CB] = function() CB:Refresh() end
    ChevronBtn.MouseEnter:Connect(function() CBHover = true; CB:Refresh() end)
    ChevronBtn.MouseLeave:Connect(function() CBHover = false; CB:Refresh() end)

    function Dock:SetCollapsed(V)
        V = V == true
        if Dock.Collapsed == V then return end
        Dock.Collapsed = V
        Tween(ChevronBtn, { Size = V and UDim2.fromOffset(math.floor(44 * S), math.floor(44 * S)) or UDim2.fromOffset(math.floor(26 * S), math.floor(38 * S)), Rotation = V and 180 or 0 }, Library.SlowTween)
        Tween(ChevronStroke, { Transparency = V and 0.3 or 1 }, Library.SlowTween)
        CB:Refresh()
        if V then
            Tween(CollapseScale, { Scale = 0 }, Library.SlowTween)
            task.delay(0.2, function() if Dock.Collapsed then Frame.Visible = false end end)
        else
            Frame.Visible = true
            Tween(CollapseScale, { Scale = 1 }, Library.SlowTween)
        end
        Library:SafeCallback(Dock.OnCollapseChanged, V)
    end
    function Dock:ToggleCollapse() Dock:SetCollapsed(not Dock.Collapsed) end
    ChevronBtn.MouseButton1Click:Connect(function() Dock:ToggleCollapse() end)

    Library:GiveSignal(RunService.Heartbeat:Connect(function()
        if not Frame.Parent or not ChevronBtn.Parent then return end
        local FP, FS = Frame.AbsolutePosition, Frame.AbsoluteSize
        local FA = Floats.AbsolutePosition
        local W = Dock.Collapsed and math.floor(44 * S) or math.floor(26 * S)
        local H = Dock.Collapsed and math.floor(44 * S) or math.floor(38 * S)
        local X = FP.X - FA.X + (Dock.Collapsed and (FS.X - W) / 2 or FS.X + math.max(4, math.floor(6 * S)))
        local Y = FP.Y - FA.Y + (FS.Y - H) / 2
        ChevronBtn.Position = UDim2.fromOffset(math.floor(X + 0.5), math.floor(Y + 0.5))
    end))

    Library.Dock = Dock
    return Dock
end

function Library:SetDPIScale(Percent)
    Percent = math.clamp(tonumber(Percent) or 100, 50, 150)
    local Old, NewScale = Library.DPIScale, Percent / 100
    if Library.CurrentPopup then Library.CurrentPopup:Close() end

    local Root = Library.Window and Library.Window.Root
    if Root then -- keep the window centered on the same point
        local Half = Vector2.new(Root.Size.X.Offset, Root.Size.Y.Offset) * (Old - NewScale) / 2
        Root.Position = Root.Position + UDim2.fromOffset(Half.X, Half.Y)
    end

    Library.DPIScale = NewScale
    for S in Library.DPIScales do
        if S.Parent then S.Scale = NewScale end
    end
    NotifyArea.Size = UDim2.new(0, 330, 1 / NewScale, -24 / NewScale)
end

function Library:Toggle(Value)
    if Library.Window then Library.Window:Toggle(Value) end
end

function Library:CreateWindow(WindowInfo)
    local RawTheme = typeof(WindowInfo) == "table" and WindowInfo.Theme or nil
    WindowInfo = Library:Validate(WindowInfo, Templates.Window)
    if Library.Window then warn("[Evergreen] A window already exists.") return Library.Window end

    local Camera = workspace.CurrentCamera
    local View = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
    WindowInfo.Size = UDim2.fromOffset(
        math.clamp(WindowInfo.Size.X.Offset, WindowInfo.MinSize.X, math.max(WindowInfo.MinSize.X, View.X - 40)),
        math.clamp(WindowInfo.Size.Y.Offset, WindowInfo.MinSize.Y, math.max(WindowInfo.MinSize.Y, View.Y - 40))
    )

    -- An explicit Theme always wins; otherwise the active skin's suggested theme is used.
    -- Only an explicit choice pins the theme, so skins can keep suggesting palettes later.
    local SkinTheme = Library.Skin and Library.Skin.DefaultTheme
    Library.ApplyingSkin = RawTheme == nil
    Library:SetTheme(RawTheme or SkinTheme or WindowInfo.Theme)
    Library.ApplyingSkin = false
    if RawTheme ~= nil then Library.ThemePinned = true end
    if WindowInfo.Accent then Library:SetAccent(WindowInfo.Accent) end
    Library:SetNotifySide(WindowInfo.NotifySide)
    Library.ToggleKeybind = WindowInfo.ToggleKeybind

    local Window = { Info = WindowInfo }
    local Skin = Library.Skin
    local SkinBar = (Skin.Tabs.Style == "Bar")
    local SidebarWidth = WindowInfo.SidebarWidth
    local TitleH = Skin.Titlebar.Height or 40
    local TabH = SkinBar and (Skin.Tabs.Height or 38) or 0

    --// Root + shadow + main
    local Root = New("Frame", {
        BackgroundTransparency = 1, Size = WindowInfo.Size, Visible = false, Parent = ScreenGui,
        Position = WindowInfo.Center and UDim2.new(0.5, -WindowInfo.Size.X.Offset / 2, 0.5, -WindowInfo.Size.Y.Offset / 2) or WindowInfo.Position,
    })
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Root })] = true
    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = Root })
    Corner(Main, WindowInfo.CornerRadius)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    Library:AddSurface(Main, 0, 1)
    Library:AddGlass(Main)
    local MainScale = New("UIScale", { Parent = Main })

    -- Wallpaper sits behind all chrome (title/sidebar/content)
    local Wallpaper = New("ImageLabel", {
        BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop,
        ImageTransparency = WindowInfo.WallpaperTransparency or 0.55, Visible = false, ZIndex = 0, Parent = Main,
    })
    Corner(Wallpaper, WindowInfo.CornerRadius)
    Window.Wallpaper = Wallpaper
    if WindowInfo.Wallpaper then
        local Url = tostring(WindowInfo.Wallpaper)
        if tonumber(Url) then Url = "rbxassetid://" .. Url end
        Wallpaper.Image = Url
        Wallpaper.Visible = true
        Library.WallpaperImage = Url
        Library.WallpaperTransparency = WindowInfo.WallpaperTransparency or 0.55
    end

    Window.Root, Window.MainFrame = Root, Main

    --// Title bar
    local TitleBar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, TitleH), ZIndex = 3, Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.3, Parent = TitleBar })
    New("UICorner", { TopLeftRadius = UDim.new(0, WindowInfo.CornerRadius), TopRightRadius = UDim.new(0, WindowInfo.CornerRadius), BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), Parent = TitleBar })
    Library:AddSurface(TitleBar, 0, 1)
    Grad(TitleBar, Two("Titlebar", 0.07, -0.025), 90)
    Library:MakeDraggable(Root, TitleBar, true)

    local Minimized, Maximized = false, false
    local PreMinSize, PreMaxState

    -- traffic lights
    if WindowInfo.ShowTrafficLights and Skin.Titlebar.TrafficLights ~= false then
        local Lights = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(64, 16), Parent = TitleBar })
        Window.Lights = Lights
        List(Lights, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
        local Glyphs, Hover = {}, 0
        local function Refresh()
            for _, G in Glyphs do Tween(G, { TextTransparency = Hover > 0 and 0.25 or 1 }) end
        end
        local function MakeLight(Color, Char, Func)
            local B = New("TextButton", { BackgroundColor3 = Color, BackgroundTransparency = 0, Size = UDim2.fromOffset(13, 13), Parent = Lights })
            Corner(B, 99)
            Stroke(B, Color3.new(0, 0, 0), 1, 0.82)
            local G = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Char, TextSize = 12, FontFace = "FontBold", TextColor3 = Color3.fromRGB(45, 25, 20), TextTransparency = 1, Parent = B })
            table.insert(Glyphs, G)
            B.MouseEnter:Connect(function() Hover += 1; Refresh() end)
            B.MouseLeave:Connect(function() Hover = math.max(0, Hover - 1); task.defer(Refresh) end)
            B.MouseButton1Click:Connect(Func)
        end
        MakeLight(Color3.fromRGB(255, 95, 87), "×", function()
            if typeof(WindowInfo.OnClose) == "function" then Library:SafeCallback(WindowInfo.OnClose) end
            if WindowInfo.CloseUnloads then Library:Unload() else Window:Toggle(false) end
        end)
        MakeLight(Color3.fromRGB(254, 188, 46), "–", function() Window:SetMinimized(not Minimized) end)
        MakeLight(Color3.fromRGB(40, 200, 64), "+", function() Window:SetMaximized(not Maximized) end)
    end

    -- title: centered by default, left-aligned (with an optional wordmark icon) for bar skins
    local LeftTitle = Skin.Titlebar.Align == "Left"
    local TitleHolder = New("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = LeftTitle and Vector2.new(0, 0.5) or Vector2.new(0.5, 0.5),
        Position = LeftTitle and UDim2.new(0, 16, 0.5, 0) or UDim2.fromScale(0.5, 0.5),
        Size = LeftTitle and UDim2.new(1, -260, 1, 0) or UDim2.new(1, -400, 1, 0), Parent = TitleBar,
    })
    local TitleList = List(TitleHolder, LeftTitle and 8 or 0,
        LeftTitle and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
        LeftTitle and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Center,
        Enum.VerticalAlignment.Center)

    local Wordmark
    local WordmarkIcon = Skin.Titlebar.Icon
    if WordmarkIcon then
        Wordmark = Glyph(TitleHolder, WordmarkIcon, "✳", {
            AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromOffset(16, 16), Color = "Accent", LayoutOrder = 0,
        })
    end

    Window.Wordmark = Wordmark

    local TitleRich = Library:RenderRich(TitleHolder, WindowInfo.Title, {
        Size = 14, Bold = true, Align = LeftTitle and "Left" or "Center", LayoutOrder = 1,
        Visible = WindowInfo.Title ~= "",
    })
    local SubtitleRich = Library:RenderRich(TitleHolder, WindowInfo.Subtitle or "", { Size = 10, Color = "SubText", Align = LeftTitle and "Left" or "Center", LayoutOrder = 2, Visible = WindowInfo.Subtitle ~= nil })

    if Window.SidebarVisible == nil then Window.SidebarVisible = true end
    local SidebarBtn = New("TextButton", {
        BackgroundColor3 = "Control", BackgroundTransparency = 0.25, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -46, 0.5, 0),
        Size = UDim2.fromOffset(28, 26), Visible = Skin.Titlebar.SidebarButton ~= false and not SkinBar, Parent = TitleBar,
    })
    Corner(SidebarBtn, 99)
    local SidebarBtnStroke = Stroke(SidebarBtn, "Outline", 1, 0.5)
    local SidebarGlyph = Glyph(SidebarBtn, "panel-left", "◫", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14) })
    local function RefreshSidebarBtn()
        local On = Window.SidebarVisible ~= false
        local C = On and Library.Scheme.Accent or Library.Scheme.SubText
        if SidebarGlyph:IsA("ImageLabel") then SidebarGlyph.ImageColor3 = C else SidebarGlyph.TextColor3 = C end
        SidebarBtnStroke.Transparency = On and 0 or 0.5
    end
    Window.RefreshSidebarBtn = RefreshSidebarBtn
    RefreshSidebarBtn()
    SidebarBtn.MouseButton1Click:Connect(function() Window:SetSidebarVisible(Window.SidebarVisible == false) end)
    Library.ThemeHooks[SidebarGlyph] = function() RefreshSidebarBtn() end

    --// Search: style 1 = collapsible bar on the title bar (filters + highlights), style 2 = spotlight (jump to results)
    local SearchStyle = WindowInfo.SearchStyle == 2 and 2 or 1
    Window.SearchStyle = SearchStyle
    local SearchHolder, SearchBox
    local Expanded, LastCollapse, SearchToken = false, 0, 0
    local ExpandSearch, CollapseSearch
    local Spot = { Open = false }

    if not WindowInfo.DisableSearch then
        SearchHolder = New("Frame", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0.25, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(28, 26), ClipsDescendants = true, Parent = TitleBar,
        })
        Corner(SearchHolder, 99)
        local SStroke = Stroke(SearchHolder, "Outline", 1, 0.5)
        local SBtn = New("TextButton", { Size = UDim2.fromOffset(28, 26), Parent = SearchHolder })
        Glyph(SBtn, "search", "⌕", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14) })
        SearchBox = New("TextBox", { Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -36, 1, 0), PlaceholderText = "Search", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Visible = false, Parent = SearchHolder })

        ExpandSearch = function()
            if Expanded or SearchStyle ~= 1 then return end
            Expanded = true
            SearchBox.Visible = true
            Bind(SStroke, "Color", "Accent")
            Tween(SStroke, { Color = Library.Scheme.Accent, Transparency = 0 })
            Tween(SearchHolder, { Size = UDim2.fromOffset(230, 26) }, Library.SlowTween)
            task.defer(function() SearchBox:CaptureFocus() end)
        end
        CollapseSearch = function(Clear)
            if not Expanded then return end
            Expanded = false
            LastCollapse = os.clock()
            if Clear then SearchBox.Text = "" end
            Bind(SStroke, "Color", "Outline")
            Tween(SStroke, { Color = Library.Scheme.Outline, Transparency = 0.5 })
            Tween(SearchHolder, { Size = UDim2.fromOffset(28, 26) }, Library.SlowTween)
            task.delay(0.3, function() if not Expanded then SearchBox.Visible = false end end)
        end

        SearchBox.FocusLost:Connect(function()
            if SearchBox.Text == "" then CollapseSearch(false) end
        end)
        Library:GiveSignal(SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if SearchStyle ~= 1 then return end
            local Text = SearchBox.Text
            SearchToken += 1
            local Tok = SearchToken
            task.delay(0.1, function()
                if Tok == SearchToken then Library:UpdateSearch(Text) end
            end)
        end))

        --// spotlight (style 2)
        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 70, Visible = false, Parent = Main })
        Corner(Dim, WindowInfo.CornerRadius)
        local Panel = New("Frame", { BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(520, 380), ZIndex = 71, Parent = Dim })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        Library:AddGlass(Panel)
        local PScale = New("UIScale", { Parent = Panel })
        Glyph(Panel, "search", "⌕", { Position = UDim2.fromOffset(18, 19), Size = UDim2.fromOffset(18, 18) })
        local Input = New("TextBox", { Position = UDim2.fromOffset(46, 12), Size = UDim2.new(1, -62, 0, 34), PlaceholderText = "Search tabs, pages, groups and features...", TextSize = 15, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = Panel })
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, Position = UDim2.fromOffset(0, 54), Size = UDim2.new(1, 0, 0, 1), Parent = Panel })
        local Results = New("ScrollingFrame", { Position = UDim2.fromOffset(0, 56), Size = UDim2.new(1, 0, 1, -84), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = Panel })
        List(Results, 2)
        Pad(Results, 6, 8, 6, 8)
        New("TextLabel", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 26), Text = "↑↓ navigate      ↵ open      esc close", TextSize = 11, TextColor3 = "SubText", Parent = Panel })

        local Rows, Sel, Found = {}, 1, {}
        local function SetSel(I)
            if #Rows == 0 then Sel = 1 return end
            Sel = math.clamp(I, 1, #Rows)
            for K, R in Rows do R.BackgroundTransparency = K == Sel and 0 or 1 end
            local R = Rows[Sel]
            local Top = R.AbsolutePosition.Y - Results.AbsolutePosition.Y + Results.CanvasPosition.Y
            if Top < Results.CanvasPosition.Y then
                Results.CanvasPosition = Vector2.new(0, Top)
            elseif Top + R.AbsoluteSize.Y > Results.CanvasPosition.Y + Results.AbsoluteSize.Y then
                Results.CanvasPosition = Vector2.new(0, Top + R.AbsoluteSize.Y - Results.AbsoluteSize.Y)
            end
        end

        local function Rebuild(Query)
            for _, C in Results:GetChildren() do
                if C:IsA("GuiObject") then C:Destroy() end
            end
            table.clear(Rows)
            Found = Library:SearchEntries(Query, 40)
            if #Found == 0 then
                New("TextLabel", { Size = UDim2.new(1, 0, 0, 60), Text = "No results", TextColor3 = "SubText", Parent = Results })
                return
            end
            for I, E in Found do
                local Row = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = I, Parent = Results })
                Corner(Row, 8)
                New("TextLabel", { Position = UDim2.fromOffset(12, 5), Size = UDim2.new(1, -110, 0, 18), Text = Library:HighlightText(E.Text, Query), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row })
                New("TextLabel", { Position = UDim2.fromOffset(12, 24), Size = UDim2.new(1, -110, 0, 16), Text = Esc(E.Path), TextSize = 11, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row })
                local Badge = New("TextLabel", { BackgroundColor3 = "Segment", BackgroundTransparency = 0.5, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18), Text = E.Type, TextSize = 10, TextColor3 = "SubText", Parent = Row })
                Corner(Badge, 5)
                Pad(Badge, 0, 7, 0, 7)
                Row.MouseEnter:Connect(function() SetSel(I) end)
                Row.MouseButton1Click:Connect(function()
                    Spot.Hide()
                    Library:JumpTo(E)
                end)
                Rows[I] = Row
            end
            SetSel(1)
        end

        Spot.Show = function()
            if Spot.Open then return end
            Spot.Open = true
            local Real = Main.AbsoluteSize / Library.DPIScale
            Panel.Size = UDim2.fromOffset(math.clamp(Real.X - 80, 320, 560), math.clamp(Real.Y - 80, 260, 420))
            Library:BuildSearchIndex()
            Dim.Visible = true
            Dim.BackgroundTransparency = 1
            Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)
            PScale.Scale = 0.95
            Tween(PScale, { Scale = 1 }, Library.SlowTween)
            Input.Text = ""
            Rebuild("")
            task.defer(function() Input:CaptureFocus() end)
        end
        Spot.Hide = function()
            if not Spot.Open then return end
            Spot.Open = false
            Input:ReleaseFocus()
            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
            task.delay(0.16, function() if not Spot.Open then Dim.Visible = false end end)
        end

        local SpotToken = 0
        Input:GetPropertyChangedSignal("Text"):Connect(function()
            if not Spot.Open then return end
            local Q = Input.Text
            SpotToken += 1
            local Tok = SpotToken
            task.delay(0.1, function()
                if Tok == SpotToken and Spot.Open then Rebuild(Q) end
            end)
        end)
        Input.FocusLost:Connect(function(Enter)
            if Enter and Found[Sel] then
                local E = Found[Sel]
                Spot.Hide()
                Library:JumpTo(E)
            end
        end)
        Dim.MouseButton1Click:Connect(function()
            if not IsOver(Panel, MousePos()) then Spot.Hide() end
        end)
        Library:GiveSignal(UserInputService.InputBegan:Connect(function(In)
            if not Spot.Open then return end
            if In.KeyCode == Enum.KeyCode.Escape then Spot.Hide()
            elseif In.KeyCode == Enum.KeyCode.Down then SetSel(Sel + 1)
            elseif In.KeyCode == Enum.KeyCode.Up then SetSel(Sel - 1) end
        end))

        SBtn.MouseButton1Click:Connect(function()
            if SearchStyle == 2 then Spot.Show() return end
            if os.clock() - LastCollapse < 0.2 then return end
            if Expanded then CollapseSearch(true) else ExpandSearch() end
        end)
    end

    function Window:SetSearchStyle(Style)
        SearchStyle = Style == 2 and 2 or 1
        Window.SearchStyle = SearchStyle
        if SearchBox then
            if CollapseSearch then CollapseSearch(true) end
            SearchBox.Text = ""
        end
        if Spot.Open then Spot.Hide() end
        Library:UpdateSearch("")
    end

    --// Tab bar: the horizontal chrome used by "Bar" skins (hidden otherwise)
    local TabBar = New("Frame", {
        BackgroundColor3 = "Titlebar", BackgroundTransparency = 0, Position = UDim2.fromOffset(0, TitleH),
        Size = UDim2.new(1, 0, 0, TabH), Visible = SkinBar, ZIndex = 2, Parent = Main,
    })
    Library:AddSurface(TabBar, 0, 1)
    local TabBarLine = New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = TabBar })

    --// Sidebar
    local Sidebar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Position = UDim2.fromOffset(0, TitleH), Size = UDim2.new(0, SidebarWidth, 1, -TitleH), Visible = not SkinBar, Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.3, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 1, 1, 0), Parent = Sidebar })

    New("UICorner", { TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0), BottomLeftRadius = UDim.new(0, WindowInfo.CornerRadius), BottomRightRadius = UDim.new(0, 0), Parent = Sidebar })
    Library:AddSurface(Sidebar, 0, 1)
    Grad(Sidebar, Two("Sidebar", 0.04, -0.02), 90)
    local ChipH = WindowInfo.ShowUserChip and 52 or 0
    local TabsList = New("ScrollingFrame", {
        Size = if SkinBar then UDim2.fromScale(1, 1) else UDim2.new(1, -1, 1, -ChipH), CanvasSize = UDim2.new(),
        AutomaticCanvasSize = if SkinBar then Enum.AutomaticSize.None else Enum.AutomaticSize.Y,
        ScrollBarThickness = 0, Parent = if SkinBar then TabBar else Sidebar,
    })
    local TabsLayout = List(TabsList, SkinBar and (Skin.Tabs.Gap or 0) or 2,
        SkinBar and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
        Enum.HorizontalAlignment.Left, SkinBar and Enum.VerticalAlignment.Center or Enum.VerticalAlignment.Top)
    local TabsPad = if SkinBar
        then Pad(TabsList, 0, 0, 0, 0)
        else Pad(TabsList, Skin.Tabs.Pad or 10, 8, 8, 8)

    local FooterLabel
    if WindowInfo.ShowUserChip then
        local Chip = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, -1, 0, ChipH), Parent = Sidebar })
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, Size = UDim2.new(1, -16, 0, 1), Position = UDim2.fromOffset(8, 0), Parent = Chip })
        local Avatar = New("ImageLabel", { BackgroundColor3 = "Control", BackgroundTransparency = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 1), Size = UDim2.fromOffset(30, 30), Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", LocalPlayer.UserId), Parent = Chip })
        Corner(Avatar, 99)
        New("TextLabel", { Position = UDim2.fromOffset(50, 9), Size = UDim2.new(1, -58, 0, 16), Text = LocalPlayer.DisplayName, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Chip })
        FooterLabel = New("TextLabel", { Position = UDim2.fromOffset(50, 26), Size = UDim2.new(1, -58, 0, 14), Text = Library:ToRichText(WindowInfo.Footer), TextSize = 11, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Chip })
    end

    --// Content
    local ChromeH = TitleH + TabH
    local HeaderH = if Skin.Content.ShowHeader ~= false then (Skin.Content.HeaderHeight or 54) else 0
    local SidebarX = if SkinBar then 0 else SidebarWidth
    local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(SidebarX, ChromeH), Size = UDim2.new(1, -SidebarX, 1, -ChromeH), ClipsDescendants = true, Parent = Main })
    local Header = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HeaderH), Visible = HeaderH > 0, Parent = Content })
    List(Header, 1, nil, nil, Enum.VerticalAlignment.Center)
    Pad(Header, 0, Skin.Content.PadX or 16, 0, (Skin.Content.PadX or 16) + 4)
    local PageTitle = New("TextLabel", { Size = UDim2.new(1, 0, 0, 24), Text = "", FontFace = "FontBold", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, Parent = Header })
    local PageDesc = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = "", TextSize = 12, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, Visible = false, Parent = Header })
    local Pages = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, HeaderH), Size = UDim2.new(1, 0, 1, -HeaderH), Parent = Content })

    local ScrollArrow = Glyph(Content, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -12), Size = UDim2.fromOffset(16, 16), Color = "SubText", Visible = false })
    local ScrollArrowShown = false
    local ScrollArrowUp = false
    Library:GiveSignal(RunService.Heartbeat:Connect(function()
        if not Root.Visible then
            if ScrollArrowShown then ScrollArrowShown = false; GlyphTransparency(ScrollArrow, 1) end
            return
        end
        local More, Up = false, false
        local T = Library.ActiveTab
        if T and T.Sides then
            for _, S in T.Sides do
                if typeof(S) == "Instance" and S:IsA("ScrollingFrame") and S.Visible then
                    local CV, VP, CY = S.CanvasSize.Y.Offset, S.AbsoluteSize.Y, S.CanvasPosition.Y
                    if CV > VP + 4 then
                        if CY + VP < CV - 4 then More = true end
                        if CY > 4 then Up = true end
                    end
                end
            end
        end
        local Want = More or Up
        local WantUp = Want and Up and not More
        if Want ~= ScrollArrowShown or WantUp ~= ScrollArrowUp then
            ScrollArrowShown, ScrollArrowUp = Want, WantUp
            ScrollArrow.Visible = Want
            ScrollArrow.Rotation = WantUp and 180 or 0
            if Want then
                if ScrollArrow:IsA("ImageLabel") then ScrollArrow.ImageTransparency = 0 else ScrollArrow.TextTransparency = 0 end
            end
        end
    end))

    --// Resize grip
    if WindowInfo.Resizable then
        local Grip = New("TextButton", { AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1), Size = UDim2.fromOffset(18, 18), ZIndex = 6, Parent = Main })
        local GripIcon = Glyph(Grip, "move-diagonal-2", "◢", { Size = UDim2.fromOffset(12, 12), Position = UDim2.fromOffset(2, 2) })
        GlyphTransparency(GripIcon, 1)
        local function FadeGrip(T)
            Tween(GripIcon, GripIcon:IsA("ImageLabel") and { ImageTransparency = T } or { TextTransparency = T }, Library.SlowTween)
        end
        Grip.MouseEnter:Connect(function() FadeGrip(0) end)
        Grip.MouseLeave:Connect(function() FadeGrip(1) end)
        Window.Grip = Grip
        local Resizing, StartPos, StartSize = false, nil, nil
        Grip.InputBegan:Connect(function(Input)
            if not IsPress(Input) or Minimized then return end
            Resizing, StartPos, StartSize = true, Input.Position, Root.Size
            Library.CantDragForced = true
            local C; C = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End or Input.UserInputState == Enum.UserInputState.Cancel then
                    Resizing = false
                    Library.CantDragForced = false
                    C:Disconnect()
                end
            end)
        end)
        Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
            if not Resizing then return end
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                local D = (Input.Position - StartPos) / Library.DPIScale
                Root.Size = UDim2.fromOffset(
                    math.max(WindowInfo.MinSize.X, StartSize.X.Offset + D.X),
                    math.max(WindowInfo.MinSize.Y, StartSize.Y.Offset + D.Y)
                )
                if SkinBar and Window.RefreshTabBar then Window.RefreshTabBar() end
            end
        end))
    end

    --// Window API
    function Window:ChangeTitle(T) TitleRich:SetText(T); WindowInfo.Title = T end
    function Window:SetSubtitle(T) SubtitleRich:SetText(T or ""); SubtitleRich.Host.Visible = T ~= nil end
    function Window:SetFooter(T) WindowInfo.Footer = T; if FooterLabel then FooterLabel.Text = Library:ToRichText(T) end end

    function Window:SetSidebarVisible(V)
        V = V ~= false
        if Window.SidebarVisible == V then return end
        Window.SidebarVisible = V
        if V then Sidebar.Visible = true end
        Tween(Sidebar, { Position = UDim2.fromOffset(V and 0 or -SidebarWidth, TitleH) }, Library.SlowTween)
        Tween(Content, { Position = UDim2.fromOffset(V and SidebarWidth or 0, TitleH), Size = UDim2.new(1, V and -SidebarWidth or 0, 1, -TitleH) }, Library.SlowTween)
        if not V then
            task.delay(0.3, function() if Window.SidebarVisible == false then Sidebar.Visible = false end end)
        end
        if Window.RefreshSidebarBtn then Window.RefreshSidebarBtn() end
    end

    -- Restructures the whole chrome for a new skin without rebuilding the window
    function Window:ApplySkin()
        local S = Library.Skin
        local Bar = S.Tabs.Style == "Bar"
        SkinBar = Bar
        TitleH = S.Titlebar.Height or 40
        TabH = Bar and (S.Tabs.Height or 38) or 0
        HeaderH = if S.Content.ShowHeader ~= false then (S.Content.HeaderHeight or 54) else 0
        local ChromeH = TitleH + TabH
        SidebarX = if Bar then 0 else SidebarWidth

        TitleBar.Size = UDim2.new(1, 0, 0, TitleH)
        TabBar.Position = UDim2.fromOffset(0, TitleH)
        TabBar.Size = UDim2.new(1, 0, 0, TabH)
        TabBar.Visible = Bar

        Sidebar.Position = UDim2.fromOffset(0, TitleH)
        Sidebar.Size = UDim2.new(0, SidebarWidth, 1, -TitleH)
        Sidebar.Visible = (not Bar) and Window.SidebarVisible ~= false

        Content.Position = UDim2.fromOffset(SidebarX, ChromeH)
        Content.Size = UDim2.new(1, -SidebarX, 1, -ChromeH)
        Header.Size = UDim2.new(1, 0, 0, HeaderH)
        Header.Visible = HeaderH > 0 and Window.TabTitleVisible ~= false
        Pages.Position = UDim2.fromOffset(0, Window.TabTitleVisible ~= false and HeaderH or 0)
        Pages.Size = UDim2.new(1, 0, 1, -(Window.TabTitleVisible ~= false and HeaderH or 0))

        -- the tab strip moves between the sidebar and the bar above the content
        TabsList.Parent = Bar and TabBar or Sidebar
        TabsList.Size = if Bar then UDim2.fromScale(1, 1) else UDim2.new(1, -1, 1, -ChipH)
        TabsList.AutomaticCanvasSize = if Bar then Enum.AutomaticSize.None else Enum.AutomaticSize.Y
        TabsLayout.FillDirection = Bar and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical
        TabsLayout.VerticalAlignment = Bar and Enum.VerticalAlignment.Center or Enum.VerticalAlignment.Top
        TabsLayout.Padding = UDim.new(0, if Bar then (S.Tabs.Gap or 0) else Library:SkinGap(2))
        TabsPad.PaddingTop = UDim.new(0, if Bar then 0 else (S.Tabs.Pad or 10))
        TabsPad.PaddingLeft = UDim.new(0, if Bar then 0 else 8)
        TabsPad.PaddingRight = UDim.new(0, if Bar then 0 else 8)
        TabsPad.PaddingBottom = UDim.new(0, if Bar then 0 else 8)

        -- title: centered by default, left-aligned wordmark for bar skins
        local LeftTitle = S.Titlebar.Align == "Left"
        TitleHolder.AnchorPoint = LeftTitle and Vector2.new(0, 0.5) or Vector2.new(0.5, 0.5)
        TitleHolder.Position = LeftTitle and UDim2.new(0, 46, 0.5, 0) or UDim2.fromScale(0.5, 0.5)
        TitleHolder.Size = LeftTitle and UDim2.new(1, -260, 1, 0) or UDim2.new(1, -400, 1, 0)
        TitleList.FillDirection = LeftTitle and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical
        TitleList.HorizontalAlignment = LeftTitle and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Center
        TitleList.Padding = UDim.new(0, LeftTitle and 0 or 8)

        if S.Titlebar.TrafficLights ~= false and Window.Lights then Window.Lights.Visible = true end
        if Window.Lights then Window.Lights.Visible = S.Titlebar.TrafficLights ~= false end
        if Window.Wordmark then Window.Wordmark.Visible = S.Titlebar.Icon ~= nil end

        SidebarBtn.Visible = (not Bar) and S.Titlebar.SidebarButton ~= false

        for _, Sec in Window.Sections do
            if Sec.Head then Sec.Head.Visible = not Bar end
        end
        for _, T in Library.TabList do
            if T.Window == Window and T.ApplySkin then pcall(T.ApplySkin, T) end
        end
    end

    function Window:SetTabTitleVisible(V)
        V = V ~= false
        Window.TabTitleVisible = V
        Header.Visible = V
        Pages.Position = UDim2.fromOffset(0, V and HeaderH or 0)
        Pages.Size = UDim2.new(1, 0, 1, V and -HeaderH or 0)
    end
    Window.TabTitleVisible = WindowInfo.ShowTabTitle ~= false
    if not Window.TabTitleVisible then
        Header.Visible = false
        Pages.Position = UDim2.fromOffset(0, 0)
        Pages.Size = UDim2.new(1, 0, 1, 0)
    end

    function Window:SetSidebarWidth(W)
        W = math.clamp(tonumber(W) or 190, 100, 320)
        SidebarWidth = W
        WindowInfo.SidebarWidth = W
        Sidebar.Size = UDim2.new(0, W, 1, -TitleH)
        Content.Position = UDim2.fromOffset(W, TitleH)
        Content.Size = UDim2.new(1, -W, 1, -TitleH)
        if Window.SidebarVisible == false then
            Sidebar.Position = UDim2.fromOffset(W, TitleH)
            Content.Position = UDim2.fromOffset(0, TitleH)
            Content.Size = UDim2.new(1, 0, 1, -TitleH)
            Sidebar.Visible = false
        end
    end

    function Window:SetCornerRadius(R)
        R = math.clamp(tonumber(R) or 12, 0, 28)
        WindowInfo.CornerRadius = R
        local function ApplyCorners(Inst, TL, TR, BL, BR)
            if not Inst then return end
            local C = Inst:FindFirstChildOfClass("UICorner")
            if not C then return end
            if TL ~= nil then
                C.TopLeftRadius = UDim.new(0, TL)
                C.TopRightRadius = UDim.new(0, TR)
                C.BottomLeftRadius = UDim.new(0, BL)
                C.BottomRightRadius = UDim.new(0, BR)
            else
                C.CornerRadius = UDim.new(0, R)
            end
        end
        ApplyCorners(Main)
        ApplyCorners(Wallpaper)
        ApplyCorners(TitleBar, R, R, 0, 0)
        ApplyCorners(Sidebar, 0, 0, R, 0)
    end

    function Window:SetMinimized(V)
        if Maximized then Window:SetMaximized(false) end
        Minimized = V
        if V then
            PreMinSize = Root.Size
            Tween(Root, { Size = UDim2.fromOffset(Root.Size.X.Offset, TitleH) }, Library.SlowTween)
        elseif PreMinSize then
            Tween(Root, { Size = PreMinSize }, Library.SlowTween)
        end
        if Window.Grip then Window.Grip.Visible = not V end
    end

    function Window:SetMaximized(V)
        if Minimized then Window:SetMinimized(false) end
        Maximized = V
        if V then
            PreMaxState = { Root.Size, Root.Position }
            local VS = ScreenGui.AbsoluteSize
            Tween(Root, { Size = UDim2.fromOffset((VS.X - 24) / Library.DPIScale, (VS.Y - 24) / Library.DPIScale), Position = UDim2.fromOffset(12, 12) }, Library.SlowTween)
        elseif PreMaxState then
            Tween(Root, { Size = PreMaxState[1], Position = PreMaxState[2] }, Library.SlowTween)
        end
    end

    function Window:Toggle(Value)
        if Library.Unloaded then return end
        if typeof(Value) == "boolean" then Library.Toggled = Value else Library.Toggled = not Library.Toggled end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if not Library.Toggled and Spot.Open then Spot.Hide() end
        Library:UpdateBlur()
        if Library.Dock then Library.Dock:Refresh() end

        if Library.Toggled then
            Root.Visible = true
            MainScale.Scale = 0.94
            Tween(MainScale, { Scale = 1 }, Library.SlowTween)
        else
            TooltipLabel.Visible = false
            Tween(MainScale, { Scale = 0.94 }, Library.PopTween)
            task.delay(0.12, function()
                if not Library.Toggled then Root.Visible = false end
            end)
        end
        if WindowInfo.UnlockMouseWhileOpen then ModalElement.Modal = Library.Toggled end
    end

    --// Sections / Tabs
    local NextOrder = 0
    local CurrentSection
    Window.Sections = {}

    -- Window:AddSection("Name", { Collapsed = false, Collapsible = true }) -> tabs added after it belong to it
    function Window:AddSection(Name, Opt)
        Opt = Opt or {}
        NextOrder += 1
        local Section = { Name = Name, Tabs = {}, Collapsed = Opt.Collapsed == true, Collapsible = Opt.Collapsible ~= false }

        local Head = New("TextButton", { Size = UDim2.new(1, 0, 0, 26), LayoutOrder = NextOrder, Visible = not SkinBar, Parent = TabsList })
        local Lbl = New("TextLabel", {
            Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -34, 1, -6), Text = tostring(Name):upper(), TextSize = 10, FontFace = "FontBold",
            TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, Parent = Head,
        })
        local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 2), Size = UDim2.fromOffset(12, 12), Visible = Section.Collapsible })
        if Section.Collapsed then Arrow.Rotation = -90 end

        function Section:Apply()
            for _, T in Section.Tabs do T:RefreshButton() end
        end
        function Section:SetCollapsed(V)
            if not Section.Collapsible then return end
            Section.Collapsed = V == true
            Tween(Arrow, { Rotation = Section.Collapsed and -90 or 0 }, Library.SlowTween)
            Section:Apply()
        end
        function Section:Toggle() Section:SetCollapsed(not Section.Collapsed) end

        if Section.Collapsible then
            Head.MouseEnter:Connect(function() Tween(Lbl, { TextColor3 = Library.Scheme.Text }) end)
            Head.MouseLeave:Connect(function() Tween(Lbl, { TextColor3 = Library.Scheme.SubText }) end)
            Head.MouseButton1Click:Connect(function() Section:Toggle() end)
        end

        Section.Head, Section.Arrow = Head, Arrow
        CurrentSection = Section
        table.insert(Window.Sections, Section)
        return Section
    end

    function Window:AddTab(...)
        local Name, IconName, Description, Tooltip
        if select("#", ...) == 1 and typeof(...) == "table" then
            local I = ...
            Name, IconName, Description, Tooltip = I.Name or "Tab", I.Icon, I.Description, I.Tooltip
        else
            Name, IconName, Description = ...
        end
        Name = Name or "Tab"

        NextOrder += 1
        local TabSkin = Library:SkinTabs()
        local BarMode = TabSkin.Style == "Bar"
        local BarTabWidth = 0
        if BarMode then
            -- equal segments across the bar, split by separator rules
            BarTabWidth = math.max(70, math.floor((WindowInfo.Size.X.Offset - (SkinBar and 0 or SidebarWidth) - 1) / math.max(NextOrder, 1)))
        end

        local Btn = New("TextButton", {
            BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, LayoutOrder = NextOrder, Parent = TabsList,
            Size = BarMode and UDim2.new(0, BarTabWidth, 1, 0) or UDim2.new(1, 0, 0, TabSkin.Height or 30),
        })
        Corner(Btn, 7)
        if BarMode then Flex(Btn) end
        local Icon = Library:GetCustomIcon(IconName)
        local IconImg
        if Icon then
            IconImg = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 9, 0.5, 0), Size = UDim2.fromOffset(16, 16), ImageColor3 = Icon.Custom and "AccentText" or "Accent", Visible = TabSkin.Icons ~= false, Parent = Btn })
            Library:ApplyIcon(IconImg, Icon)
        end
        local BtnLabel = New("TextLabel", {
            Position = UDim2.fromOffset(Icon and 34 or 12, 0), Size = UDim2.new(1, Icon and -40 or -16, 1, 0),
            Text = Name, TextXAlignment = BarMode and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, TextColor3 = "SubText", Parent = Btn,
        })
        local BarLine
        if BarMode and TabSkin.ActiveStyle == "Underline" then
            BarLine = New("Frame", {
                BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1),
                Size = UDim2.new(1, -20, 0, 2), Visible = false, Parent = Btn,
            })
        end
        if BarMode and TabSkin.Separator then
            New("Frame", {
                BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.new(0, 1, 0.58, 0), Parent = Btn,
            })
        end

        local Container = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = Pages })

        local function MakeSide(Left)
            local S = New("ScrollingFrame", {
                AnchorPoint = Vector2.new(Left and 0 or 1, 0), Position = UDim2.fromScale(Left and 0 or 1, 0), Size = UDim2.fromScale(0.5, 1),
                CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Container,
            })
            List(S, 12)
            Pad(S, 4, Left and 8 or 16, 18, Left and 16 or 8)
            return S
        end
        local SideLeft, SideRight = MakeSide(true), MakeSide(false)

        local Section = CurrentSection
        local Tab = {
            Name = Name, Icon = IconName, Section = Section, Description = Description, Button = Btn, Container = Container, Sides = { SideLeft, SideRight },
            Groupboxes = {}, Tabboxes = {}, TabVisible = true, Window = Window, BarLine = BarLine,
        }

        -- warning / info banner at the top of the page (Obsidian: Tab:UpdateWarningBox)
        local WarnHolder = New("Frame", { BackgroundColor3 = Color3.fromRGB(110, 20, 20), AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(16, 4), Size = UDim2.new(1, -32, 0, 0), Visible = false, Parent = Container })
        Corner(WarnHolder, 9)
        local WarnStroke = Stroke(WarnHolder, Color3.fromRGB(255, 69, 58), 1, 0.2)
        Pad(WarnHolder, 8, 12, 8, 12)
        List(WarnHolder, 2)
        local WarnTitle = New("TextLabel", { Size = UDim2.new(1, 0, 0, 16), Text = "", FontFace = "FontBold", TextColor3 = Color3.fromRGB(255, 120, 110), TextXAlignment = Enum.TextXAlignment.Left, Parent = WarnHolder })
        local WarnText = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = "", TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = WarnHolder })

        Tab.Pages = {}
        local PageBar

        -- A layout owns either two independent column scrolls, or (once a single groupbox is added)
        -- ONE shared scroll holding rows of two columns + full-width groupboxes.
        local function MakeLayout(L, R)
            local Layout = { L = L, R = R, Unified = false, Shown = true, Order = 0 }

            function Layout:GetScrolls()
                if Layout.Unified then return { Layout.Scroll } end
                return { L, R }
            end
            function Layout:SetVisible(V)
                Layout.Shown = V
                if Layout.Unified then Layout.Scroll.Visible = V else L.Visible = V; R.Visible = V end
            end
            function Layout:Place(Offset)
                if Layout.Unified then
                    Layout.Scroll.Position = UDim2.fromOffset(0, Offset)
                    Layout.Scroll.Size = UDim2.new(1, 0, 1, -Offset)
                else
                    L.Position = UDim2.fromOffset(0, Offset)
                    L.Size = UDim2.new(0.5, 0, 1, -Offset)
                    R.Position = UDim2.new(1, 0, 0, Offset)
                    R.Size = UDim2.new(0.5, 0, 1, -Offset)
                end
            end
            function Layout:NewRow()
                Layout.Order += 1
                local Row = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = Layout.Order, Parent = Layout.Scroll })
                local CL = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0.5, -6, 0, 0), Parent = Row })
                List(CL, 12)
                local CR = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.5, -6, 0, 0), Parent = Row })
                List(CR, 12)
                Layout.Row = { CL, CR }
            end
            function Layout:Unify()
                if Layout.Unified then return end
                Layout.Unified = true
                local Scroll = New("ScrollingFrame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Visible = Layout.Shown, Parent = L.Parent })
                List(Scroll, 12)
                Pad(Scroll, 4, 16, 18, 16)
                Layout.Scroll = Scroll

                local Has = false
                for _, C in { L, R } do
                    for _, Child in C:GetChildren() do
                        if Child:IsA("GuiObject") then Has = true end
                    end
                end
                if Has then
                    Layout:NewRow()
                    for _, Child in L:GetChildren() do if Child:IsA("GuiObject") then Child.Parent = Layout.Row[1] end end
                    for _, Child in R:GetChildren() do if Child:IsA("GuiObject") then Child.Parent = Layout.Row[2] end end
                end
                L.Visible, R.Visible = false, false

                if (Layout == Tab.Layout and not Tab.ActivePage) or (Tab.ActivePage and Tab.ActivePage.Layout == Layout) then
                    Tab.Sides = Layout:GetScrolls()
                end
                Tab:RefreshSides()
            end
            function Layout:Parent(Side, Single)
                if Single then
                    Layout:Unify()
                    Layout.Row = nil
                    Layout.Order += 1
                    return Layout.Scroll, Layout.Order
                end
                if not Layout.Unified then return Side == 2 and R or L end
                if not Layout.Row then Layout:NewRow() end
                return Layout.Row[Side == 2 and 2 or 1]
            end
            function Layout:Destroy()
                if Layout.Scroll then Layout.Scroll:Destroy() end
                L:Destroy()
                R:Destroy()
            end
            return Layout
        end
        Tab.Layout = MakeLayout(SideLeft, SideRight)

        function Tab:RefreshSides()
            local Offset = WarnHolder.Visible and (WarnHolder.AbsoluteSize.Y + 12) or 0
            if PageBar then
                PageBar.Position = UDim2.fromOffset(16, Offset + 4)
                Offset += 44
            end
            Tab.Layout:Place(Offset)
            for _, P in Tab.Pages do P.Layout:Place(Offset) end
        end

        function Tab:UpdateWarningBox(WInfo)
            WInfo = WInfo or {}
            if typeof(WInfo.Visible) == "boolean" then WarnHolder.Visible = WInfo.Visible end
            if typeof(WInfo.Title) == "string" then WarnTitle.Text = Library:ToRichText(WInfo.Title) end
            if typeof(WInfo.Text) == "string" then WarnText.Text = Library:ToRichText(WInfo.Text) end
            if typeof(WInfo.IsNormal) == "boolean" then
                WarnHolder.BackgroundColor3 = WInfo.IsNormal and Library.Scheme.Card or Color3.fromRGB(110, 20, 20)
                WarnStroke.Color = WInfo.IsNormal and Library.Scheme.Outline or Color3.fromRGB(255, 69, 58)
                WarnTitle.TextColor3 = WInfo.IsNormal and Library.Scheme.Text or Color3.fromRGB(255, 120, 110)
            end
            task.defer(function() Tab:RefreshSides() end)
        end

        -- Pages (sub tabs): Tab:AddPage("Name", "icon") returns an object with the same AddGroupbox / AddTabbox API
        function Tab:AddPage(PName, PIcon)
            if typeof(PName) == "table" then PIcon = PName.Icon; PName = PName.Name end
            PName = PName or "Page"

            if not PageBar then
                PageBar = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 30), Parent = Container })
                Corner(PageBar, 9)
                Pad(PageBar, 2, 2, 2, 2)
                List(PageBar, 2, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
                Tab.Layout:SetVisible(false)
            end

            local PL, PR = MakeSide(true), MakeSide(false)
            local PLayout = MakeLayout(PL, PR)
            PLayout:SetVisible(false)

            local PBtn = New("TextButton", { BackgroundColor3 = "Segment", BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Text = PName, TextColor3 = "SubText", LayoutOrder = #Tab.Pages + 1, Parent = PageBar })
            Corner(PBtn, 7)
            local PIconData = Library:GetCustomIcon(PIcon)
            local PIconImg
            if PIconData then
                Pad(PBtn, 0, 14, 0, 32)
                PIconImg = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -20, 0.5, 0), Size = UDim2.fromOffset(14, 14), ImageColor3 = "SubText", Parent = PBtn })
                Library:ApplyIcon(PIconImg, PIconData)
            else
                Pad(PBtn, 0, 14, 0, 14)
            end

            local Page = setmetatable({
                Type = "Page", Name = PName, Tab = Tab, Button = PBtn, PageSides = { PL, PR }, Layout = PLayout, Groupboxes = {}, Tabboxes = {},
            }, { __index = Tab })

            function Page:Show()
                if Tab.ActivePage == Page then return end
                if Tab.ActivePage then Tab.ActivePage:Hide() end
                Tab.ActivePage = Page
                PLayout:SetVisible(true)
                Tab.Sides = PLayout:GetScrolls()
                Tween(PBtn, { BackgroundTransparency = 0 })
                PBtn.TextColor3 = Library.Scheme.Text
                Bind(PBtn, "TextColor3", "Text")
                if PIconImg then PIconImg.ImageColor3 = Library.Scheme.Text; Bind(PIconImg, "ImageColor3", "Text") end
                Tab:RefreshSides()
            end
            function Page:Hide()
                PLayout:SetVisible(false)
                Tween(PBtn, { BackgroundTransparency = 1 })
                PBtn.TextColor3 = Library.Scheme.SubText
                Bind(PBtn, "TextColor3", "SubText")
                if PIconImg then PIconImg.ImageColor3 = Library.Scheme.SubText; Bind(PIconImg, "ImageColor3", "SubText") end
                if Tab.ActivePage == Page then Tab.ActivePage = nil end
            end
            function Page:SetVisible(V)
                PBtn.Visible = V
                if not V and Tab.ActivePage == Page then
                    Page:Hide()
                    for _, Other in Tab.Pages do
                        if Other ~= Page and Other.Button.Visible then Other:Show() break end
                    end
                end
            end
            function Page:Destroy()
                if Tab.ActivePage == Page then Tab.ActivePage = nil end
                for I = #Page.Groupboxes, 1, -1 do Page.Groupboxes[I]:Destroy() end
                for I = #Page.Tabboxes, 1, -1 do Page.Tabboxes[I]:Destroy() end
                PLayout:Destroy(); PBtn:Destroy()
                local I = table.find(Tab.Pages, Page)
                if I then table.remove(Tab.Pages, I) end
            end

            PBtn.MouseButton1Click:Connect(function() Page:Show() end)
            table.insert(Tab.Pages, Page)
            if not Tab.ActivePage then Page:Show() else Tab:RefreshSides() end
            return Page
        end

        function Tab:RefreshStyle(Hovering)
            local Sel = Library.ActiveTab == Tab
            local T = Library:SkinTabs()
            local Underline = T.ActiveStyle == "Underline"
            if Tab.BarLine then Tab.BarLine.Visible = Sel end

            if Sel then
                local Key = Underline and "Titlebar" or T.ActiveStyle == "Line" and "Titlebar" or "Accent"
                Tween(Btn, { BackgroundColor3 = Library.Scheme[Key], BackgroundTransparency = Underline and 1 or 0 })
                Bind(Btn, "BackgroundColor3", Key)
                local TextKey = Underline and "Accent" or (T.ActiveStyle == "Line" and "Text" or "AccentText")
                BtnLabel.TextColor3 = Library.Scheme[TextKey]
                Bind(BtnLabel, "TextColor3", TextKey)
                if IconImg then IconImg.ImageColor3 = Library.Scheme[TextKey]; Bind(IconImg, "ImageColor3", TextKey) end
            else
                Tween(Btn, { BackgroundColor3 = Library.Scheme.ControlHover, BackgroundTransparency = (Underline or true) and (Hovering and 0.6 or 1) })
                Bind(Btn, "BackgroundColor3", "ControlHover")
                BtnLabel.TextColor3 = Hovering and Library.Scheme.Text or Library.Scheme.SubText
                Bind(BtnLabel, "TextColor3", Hovering and "Text" or "SubText")
                if IconImg then
                    local K = Icon.Custom and "AccentText" or "Accent"
                    IconImg.ImageColor3 = Library.Scheme[K]; Bind(IconImg, "ImageColor3", K)
                end
            end
        end

        function Tab:Show()
            if Library.ActiveTab == Tab then return end
            local Prev = Library.ActiveTab
            if Prev then Prev:Hide() end
            Library.ActiveTab = Tab
            if Tab.Section and Tab.Section.Collapsed then Tab.Section:SetCollapsed(false) end

            PageTitle.Text = Library:ToRichText(Tab.Name)
            PageDesc.Text = Library:ToRichText(Tab.Description or "")
            PageDesc.Visible = Tab.Description ~= nil and Tab.Description ~= ""

            Container.Visible = true
            Container.Position = UDim2.fromOffset(0, 12)
            Tween(Container, { Position = UDim2.fromOffset(0, 0) }, Library.SlowTween)
            Tab:RefreshStyle()
            if Library.Searching then Library:UpdateSearch(Library.SearchText) end
            if Library.Dock then Library.Dock:Refresh() end
        end

        function Tab:Hide()
            Container.Visible = false
            if Library.ActiveTab == Tab then Library.ActiveTab = nil end
            Tab:RefreshStyle()
        end

        function Tab:RefreshButton()
            Btn.Visible = Tab.TabVisible ~= false and not (Tab.Section ~= nil and Tab.Section.Collapsed)
        end

        -- Restyles an existing tab button for the active skin (called by Library:SetSkin)
        function Tab:ApplySkin()
            local T = Library:SkinTabs()
            local Bar = T.Style == "Bar"
            if Bar and Window.Root then
                BarTabWidth = math.max(70, math.floor((Window.Root.Size.X.Offset / math.max(Library.DPIScale, 0.01) - (SkinBar and 0 or SidebarWidth)) / math.max(NextOrder, 1)))
            end
            Btn.Size = Bar and UDim2.new(0, BarTabWidth, 1, 0) or UDim2.new(1, 0, 0, T.Height or 30)
            Flex(Btn)
            BtnLabel.Size = if Icon then UDim2.new(1, -40, 1, 0) else UDim2.new(1, -16, 1, 0)
            BtnLabel.Position = UDim2.fromOffset(Icon and 34 or 12, 0)
            BtnLabel.TextXAlignment = Bar and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
            if IconImg then IconImg.Visible = T.Icons ~= false end
            Tab:RefreshStyle()
            if Bar and not Tab.BarLine then
                Tab.BarLine = New("Frame", {
                    BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1),
                    Size = UDim2.new(1, -20, 0, 2), Visible = Library.ActiveTab == Tab, Parent = Btn,
                })
            elseif Tab.BarLine and not Bar then
                Tab.BarLine:Destroy()
                Tab.BarLine = nil
            end
        end

        function Tab:SetVisible(V)
            Tab.TabVisible = V
            Tab:RefreshButton()
            if not V and Library.ActiveTab == Tab then Tab:Hide() end
        end

        function Tab:SetTooltip(T) if typeof(T) == "string" then Library:AddTooltip(T, Btn) end end

        function Tab:ResetSearch()
            Tab:RefreshButton()
            for _, G in Tab.Groupboxes do
                ResetBox(G)
                G.BoxHolder.Visible = G.Visible ~= false
            end
            for _, TB in Tab.Tabboxes do
                for _, ST in TB.Tabs do
                    ResetBox(ST)
                    ST.ButtonHolder.Visible = true
                end
                TB.BoxHolder.Visible = true
            end
            for _, P in Tab.Pages do P.Button.Visible = true end
        end

        function Tab:ApplySearch(S)
            local Any = false
            local TabMatch = Fuzzy(Tab.Name, S) or Fuzzy(Tab.Description, S)
            for _, G in Tab.Groupboxes do
                if G.Visible ~= false then
                    local Force = TabMatch or Fuzzy(G.Name, S) or Fuzzy(G.Description, S)
                    local C = ApplyBox(G, S, Force)
                    G.BoxHolder.Visible = C > 0
                    if C > 0 then Any = true end
                end
            end
            for _, TB in Tab.Tabboxes do
                local TotalVisible, FirstMatch, ActiveHas = 0, nil, false
                for _, ST in TB.Tabs do
                    local C = ApplyBox(ST, S, TabMatch or Fuzzy(ST.Name, S))
                    ST.ButtonHolder.Visible = C > 0
                    if C > 0 then
                        TotalVisible += 1
                        FirstMatch = FirstMatch or ST
                        if TB.ActiveTab == ST then ActiveHas = true end
                    end
                end
                TB.BoxHolder.Visible = TotalVisible > 0
                if TotalVisible > 0 then Any = true end
                if not ActiveHas and FirstMatch then FirstMatch:Show() end
            end
            if #Tab.Pages > 0 then
                local FirstP, ActiveHas
                for _, P in Tab.Pages do
                    local Has = false
                    for _, G in P.Groupboxes do
                        if G.BoxHolder.Visible then Has = true break end
                    end
                    if not Has then
                        for _, TB in P.Tabboxes do
                            if TB.BoxHolder.Visible then Has = true break end
                        end
                    end
                    P.Button.Visible = Has
                    if Has then
                        FirstP = FirstP or P
                        if Tab.ActivePage == P then ActiveHas = true end
                    end
                end
                if not ActiveHas and FirstP then FirstP:Show() end
            end
            return Any or TabMatch
        end

        --// Groupbox
        local function SideOf(Side, Owner)
            local Single = false
            if typeof(Side) == "string" then
                local L = Side:lower()
                if L == "single" or L == "full" or L == "both" then Single = true else Side = L == "right" and 2 or 1 end
            elseif Side == 0 or Side == 3 then
                Single = true
            end
            local Layout = (Owner and Owner.Layout) or Tab.Layout
            return Layout:Parent(Side, Single)
        end

        function Tab:AddGroupbox(Info)
            Info = Library:Validate(Info, Templates.Groupbox)

            local CardParent, CardOrder = SideOf(Info.Side, self)
            if CardOrder == nil then CardOrder = #CardParent:GetChildren() + 1 end
            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = CardOrder, Parent = CardParent })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
            Library:AddSurface(Card, 0, 0.85)
            Grad(Card, Two("Card", 0.035, -0.015), 90)
            List(Card, 0)

            local BoxSkin = Library:SkinGroupbox()
            local Head = New("TextButton", { Size = UDim2.new(1, 0, 0, BoxSkin.HeaderHeight or 36), LayoutOrder = 1, Parent = Card })
            local BoxIcon = Library:GetCustomIcon(Info.IconName)
            local ShowBoxIcon = BoxSkin.Icon ~= false
            local HeaderIcon
            if BoxIcon then
                HeaderIcon = New("ImageLabel", {
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(16, 16),
                    ImageColor3 = BoxIcon.Custom and "AccentText" or "Accent", Visible = ShowBoxIcon, Parent = Head,
                })
                Library:ApplyIcon(HeaderIcon, BoxIcon)
            end
            local HeaderText = New("TextLabel", {
                Position = UDim2.fromOffset(BoxIcon and ShowBoxIcon and 36 or 14, 0), Size = UDim2.new(1, -(BoxIcon and ShowBoxIcon and 60 or 40), 1, 0),
                Text = Info.Name, FontFace = "FontBold", TextSize = BoxSkin.HeaderSize or 13,
                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Head,
            })
            local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(14, 14), Visible = Info.DisableCollapsing ~= true })

            local Line = New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.5, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 2, Parent = Card })
            local Body = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3, Parent = Card })
            List(Body, BoxSkin.Gap or 10)
            local BoxPad = BoxSkin.Pad or 12
            local BodyPad = Pad(Body, BoxPad, BoxPad, BoxPad, BoxPad)

            local Groupbox = {
                Type = "Groupbox", Name = Info.Name, Description = Info.Description, Visible = true, Collapsed = false,
                BoxHolder = Card, Holder = Card, Container = Body, Tab = Tab, Elements = {}, DependencyBoxes = {}, Connections = {},
                Pinned = false, HomeParent = CardParent, HomeOrder = CardOrder,
            }

            -- Live skin change: header height, label size, icon visibility, body padding
            function Groupbox:ApplySkin()
                local BS = Library:SkinGroupbox()
                Head.Size = UDim2.new(1, 0, 0, BS.HeaderHeight or 36)
                HeaderText.TextSize = BS.HeaderSize or 13
                if HeaderIcon then HeaderIcon.Visible = BS.Icon ~= false end
                local P = BS.Pad or 12
                BodyPad.PaddingTop, BodyPad.PaddingBottom = UDim.new(0, P), UDim.new(0, P)
                BodyPad.PaddingLeft, BodyPad.PaddingRight = UDim.new(0, P), UDim.new(0, P)
                Placeholder.Size = UDim2.new(1, 0, 0, BS.HeaderHeight or 36)
            end

            local Placeholder = New("TextButton", {
                BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 0, 36),
                LayoutOrder = CardOrder, Visible = false, AutoButtonColor = false, Parent = CardParent,
            })
            Corner(Placeholder, 10)
            Stroke(Placeholder, "Outline", 1, 0.35)
            Library:AddSurface(Placeholder, 0, 0.85)
            Grad(Placeholder, Two("Card", 0.02, -0.01), 90)
            if BoxIcon then
                local PImg = New("ImageLabel", {
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0),
                    Size = UDim2.fromOffset(16, 16), ImageColor3 = BoxIcon.Custom and "AccentText" or "Accent",
                    ImageTransparency = 0.35, Parent = Placeholder,
                })
                Library:ApplyIcon(PImg, BoxIcon)
            end
            New("TextLabel", {
                Position = UDim2.fromOffset(BoxIcon and 36 or 14, 0), Size = UDim2.new(1, -(BoxIcon and 70 or 50), 1, 0),
                Text = Info.Name, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = 0.35, Parent = Placeholder,
            })
            local PinHint = Glyph(Placeholder, "pin", "📌", {
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.fromOffset(14, 14), Color = "SubText",
            })
            GlyphTransparency(PinHint, 0.35)
            Groupbox.Placeholder = Placeholder

            local FloatScale
            function Groupbox:SetCollapsed(C)
                if Info.DisableCollapsing then return end
                Groupbox.Collapsed = C
                Body.Visible, Line.Visible = not C, not C
                Tween(Arrow, { Rotation = C and -90 or 0 }, Library.SlowTween)
                if Library.KickScrolls then task.defer(Library.KickScrolls) end
            end
            function Groupbox:ToggleCollapsed() Groupbox:SetCollapsed(not Groupbox.Collapsed) end
            function Groupbox:SetVisible(V)
                Groupbox.Visible = V
                if Groupbox.Pinned then
                    Card.Visible = V
                    Placeholder.Visible = V
                else
                    Card.Visible = V
                end
                if V and Library.Searching then Library:UpdateSearch(Library.SearchText) end
                if V and Library.KickScrolls then task.defer(Library.KickScrolls) end
            end
            function Groupbox:Show() Groupbox:SetVisible(true) end
            function Groupbox:Hide() Groupbox:SetVisible(false) end
            function Groupbox:Resize() end

            function Groupbox:Pin(AtPos)
                if Groupbox.Pinned or Groupbox.Destroyed then return end
                Groupbox.Pinned = true
                Groupbox.HomeParent = Card.Parent
                Groupbox.HomeOrder = Card.LayoutOrder
                local AP = Card.AbsolutePosition
                local AS = Card.AbsoluteSize
                local Pos = AtPos or Vector2.new(AP.X, AP.Y)
                local W = math.max(AS.X, 260)

                Placeholder.LayoutOrder = Card.LayoutOrder
                Placeholder.Visible = true
                Card.Parent = Floats
                Card.Size = UDim2.fromOffset(W, 0)
                Card.AutomaticSize = Enum.AutomaticSize.Y
                Card.Position = UDim2.fromOffset(math.floor(Pos.X), math.floor(Pos.Y))
                Card.ZIndex = 40
                if not FloatScale then
                    FloatScale = New("UIScale", { Scale = Library.DPIScale, Parent = Card })
                    Library.DPIScales[FloatScale] = true
                end
                FloatScale.Scale = Library.DPIScale
                Library:Notify({ Title = Info.Name, Description = "Pinned — click the placeholder to restore", Time = 2.5, Icon = "pin" })
            end

            function Groupbox:Unpin()
                if not Groupbox.Pinned or Groupbox.Destroyed then return end
                Groupbox.Pinned = false
                Placeholder.Visible = false
                Card.Parent = Groupbox.HomeParent
                Card.LayoutOrder = Groupbox.HomeOrder
                Card.Size = UDim2.new(1, 0, 0, 0)
                Card.AutomaticSize = Enum.AutomaticSize.Y
                Card.Position = UDim2.new()
                Card.ZIndex = 1
                if FloatScale then
                    Library.DPIScales[FloatScale] = nil
                    FloatScale:Destroy()
                    FloatScale = nil
                end
            end

            function Groupbox:TogglePin()
                if Groupbox.Pinned then Groupbox:Unpin() else Groupbox:Pin() end
            end

            function Groupbox:Destroy()
                Groupbox.Destroyed = true
                if Groupbox.Pinned then Groupbox:Unpin() end
                for I = #Groupbox.Elements, 1, -1 do Groupbox.Elements[I]:Destroy() end
                Placeholder:Destroy()
                Card:Destroy()
                local I = table.find(Tab.Groupboxes, Groupbox)
                if I then table.remove(Tab.Groupboxes, I) end
            end

            local Dragging, DragMoved, DragStart, CardStart, DidPinDrag = false, false, nil, nil, false
            Head.InputBegan:Connect(function(Input)
                if not IsPress(Input) or Groupbox.Destroyed then return end
                if not Library.GroupboxDragEnabled and not Groupbox.Pinned then
                    Groupbox:ToggleCollapsed()
                    return
                end
                Dragging, DragMoved, DidPinDrag = true, false, false
                DragStart = Input.Position
                CardStart = Groupbox.Pinned and Card.Position or nil
                local Conn
                Conn = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End or Input.UserInputState == Enum.UserInputState.Cancel then
                        Dragging = false
                        if Conn then Conn:Disconnect() end
                        if not DragMoved then
                            Groupbox:ToggleCollapsed()
                        end
                    end
                end)
            end)
            Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
                if not Dragging or Groupbox.Destroyed then return end
                if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                local Delta = Input.Position - DragStart
                local Threshold = Groupbox.Pinned and 8 or 16
                if not DragMoved and (math.abs(Delta.X) > Threshold or math.abs(Delta.Y) > Threshold) then
                    DragMoved = true
                end
                if not DragMoved then return end

                if Groupbox.Pinned then
                    if not Library.GroupboxDragEnabled then return end
                    Card.Position = UDim2.fromOffset(CardStart.X.Offset + Delta.X, CardStart.Y.Offset + Delta.Y)
                elseif Library.GroupboxDragEnabled then
                    local Win = Library.Window and Library.Window.MainFrame
                    local OverWin = Win and IsOver(Win, Vector2.new(Input.Position.X, Input.Position.Y))
                    if not OverWin and (math.abs(Delta.X) > 28 or math.abs(Delta.Y) > 28) then
                        DidPinDrag = true
                        if not Groupbox.Pinned then
                            local AP = Card.AbsolutePosition
                            Groupbox:Pin(Vector2.new(AP.X + Delta.X, AP.Y + Delta.Y))
                            CardStart = Card.Position
                            DragStart = Input.Position
                        end
                    end
                end
            end))

            Placeholder.MouseButton1Click:Connect(function()
                Groupbox:Unpin()
            end)
            Library:AddTooltip("Click to restore groupbox", Placeholder)

            setmetatable(Groupbox, BaseGroupbox)
            table.insert(Tab.Groupboxes, Groupbox)
            if self.PageSides then table.insert(self.Groupboxes, Groupbox) end

            if Info.Visible == false then Groupbox:Hide() end
            if Info.Collapsed then Groupbox:SetCollapsed(true) end
            return Groupbox
        end

        function Tab:AddLeftGroupbox(Name, IconName, Visible, Collapsed)
            if typeof(Name) == "table" then
                local T = Name
                Name, IconName, Visible, Collapsed = T.Name, T.Icon or T.IconName, T.Visible, T.Collapsed
            end
            return self:AddGroupbox({ Side = 1, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end
        function Tab:AddRightGroupbox(Name, IconName, Visible, Collapsed)
            if typeof(Name) == "table" then
                local T = Name
                Name, IconName, Visible, Collapsed = T.Name, T.Icon or T.IconName, T.Visible, T.Collapsed
            end
            return self:AddGroupbox({ Side = 2, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end

        function Tab:AddSingleGroupbox(Name, IconName, Visible, Collapsed)
            if typeof(Name) == "table" then
                local T = Name
                Name, IconName, Visible, Collapsed = T.Name, T.Icon or T.IconName, T.Visible, T.Collapsed
            end
            return self:AddGroupbox({ Side = "Single", Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end

        --// Tabbox (macOS segmented control)
        function Tab:AddTabbox(Info)
            Info = Library:Validate(Info, Templates.Tabbox)
            local CardParent, CardOrder = SideOf(Info.Side, self)
            if CardOrder == nil then CardOrder = #CardParent:GetChildren() + 1 end
            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = CardOrder, Parent = CardParent })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
            Library:AddSurface(Card, 0, 0.85)
            Grad(Card, Two("Card", 0.035, -0.015), 90)
            List(Card, 0)

            local SegWrap = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44), LayoutOrder = 1, Parent = Card })
            Pad(SegWrap, 9, 10, 9, 10)
            local Track = New("Frame", { BackgroundColor3 = "Control", Size = UDim2.fromScale(1, 1), Parent = SegWrap })
            Corner(Track, 8)
            Pad(Track, 2, 2, 2, 2)
            List(Track, 2, Enum.FillDirection.Horizontal)

            local Pagesbox = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2, Parent = Card })
            List(Pagesbox, 0)

            local Tabbox = { Type = "Tabbox", BoxHolder = Card, Holder = Card, Tabs = {}, ActiveTab = nil, Visible = true, Destroyed = false }
            local Count = 0

            function Tabbox:AddTab(Name, IconName)
                Count += 1
                local Seg = New("TextButton", { BackgroundColor3 = "Segment", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), Parent = Track })
                Flex(Seg)
                Corner(Seg, 6)
                local Content_ = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 16), Parent = Seg })
                List(Content_, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
                local SegIcon = Library:GetCustomIcon(IconName)
                local SegIconImg
                if SegIcon then
                    SegIconImg = New("ImageLabel", { Size = UDim2.fromOffset(14, 14), ImageColor3 = "SubText", Parent = Content_ })
                    Library:ApplyIcon(SegIconImg, SegIcon)
                end
                local SegLabel
                if Name and Trim(Name) ~= "" then
                    SegLabel = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 16), Text = Name, TextSize = 12, TextColor3 = "SubText", Parent = Content_ })
                end

                local Page = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = false, Parent = Pagesbox })
                List(Page, 10)
                Pad(Page, 4, 12, 12, 12)

                local SubTab = {
                    Type = "SubTab", Name = Name, ButtonHolder = Seg, Container = Page, Tab = Tab, Tabbox = Tabbox,
                    Elements = {}, DependencyBoxes = {}, Connections = {},
                }

                function SubTab:Show()
                    if Tabbox.ActiveTab then Tabbox.ActiveTab:Hide() end
                    Tabbox.ActiveTab = SubTab
                    Page.Visible = true
                    Tween(Seg, { BackgroundTransparency = 0 })
                    if SegLabel then Tween(SegLabel, { TextColor3 = Library.Scheme.Text }) end
                    if SegIconImg then Tween(SegIconImg, { ImageColor3 = Library.Scheme.Text }) end
                end
                function SubTab:Hide()
                    Page.Visible = false
                    Tween(Seg, { BackgroundTransparency = 1 })
                    if SegLabel then Tween(SegLabel, { TextColor3 = Library.Scheme.SubText }) end
                    if SegIconImg then Tween(SegIconImg, { ImageColor3 = Library.Scheme.SubText }) end
                    if Tabbox.ActiveTab == SubTab then Tabbox.ActiveTab = nil end
                end
                function SubTab:Resize() end
                function SubTab:Destroy()
                    Library.ThemeHooks[SubTab] = nil
                    for I = #SubTab.Elements, 1, -1 do SubTab.Elements[I]:Destroy() end
                    Page:Destroy()
                    Seg:Destroy()
                end

                Library.ThemeHooks[SubTab] = function()
                    local C = Tabbox.ActiveTab == SubTab and Library.Scheme.Text or Library.Scheme.SubText
                    if SegLabel then SegLabel.TextColor3 = C end
                    if SegIconImg then SegIconImg.ImageColor3 = C end
                end
                Seg.MouseButton1Click:Connect(function() SubTab:Show() end)
                setmetatable(SubTab, BaseGroupbox)
                local Key = (Name and Trim(Name) ~= "") and Name or tostring(Count)
                Tabbox.Tabs[Key] = SubTab
                if not Tabbox.ActiveTab then SubTab:Show() end
                return SubTab, Key
            end

            function Tabbox:Resize() end
            function Tabbox:SetVisible(V) Tabbox.Visible = V; Card.Visible = V end
            function Tabbox:Destroy()
                Tabbox.Destroyed = true
                for _, ST in Tabbox.Tabs do ST:Destroy() end
                Card:Destroy()
            end

            if Info.Name then Tab.Tabboxes[Info.Name] = Tabbox else table.insert(Tab.Tabboxes, Tabbox) end
            if self.PageSides then table.insert(self.Tabboxes, Tabbox) end
            return Tabbox
        end
        function Tab:AddLeftTabbox(Name) return self:AddTabbox({ Side = 1, Name = Name }) end
        function Tab:AddRightTabbox(Name) return self:AddTabbox({ Side = 2, Name = Name }) end

        function Tab:Destroy()
            for _, G in Tab.Groupboxes do G:Destroy() end
            for _, TB in Tab.Tabboxes do TB:Destroy() end
            if Library.ActiveTab == Tab then Library.ActiveTab = nil end
            if Library.Dock and Library.Dock.RemoveTab then Library.Dock:RemoveTab(Tab) end
            Container:Destroy()
            Btn:Destroy()
            Library.Tabs[Name] = nil
            local I = table.find(Library.TabList, Tab)
            if I then table.remove(Library.TabList, I) end
        end

        Btn.MouseEnter:Connect(function() if Library.ActiveTab ~= Tab then Tab:RefreshStyle(true) end end)
        Btn.MouseLeave:Connect(function() if Library.ActiveTab ~= Tab then Tab:RefreshStyle(false) end end)
        Btn.MouseButton1Click:Connect(function() Tab:Show() end)
        if typeof(Tooltip) == "string" then Tab:SetTooltip(Tooltip) end

        Library.Tabs[Name] = Tab
        table.insert(Library.TabList, Tab)
        if Section then table.insert(Section.Tabs, Tab) end
        Tab:RefreshButton()
        Tab:RefreshStyle()
        if not Library.ActiveTab then Tab:Show() end
        if Library.Dock and Library.Dock.AutoTabs and Library.Dock.SyncTabs then
            task.defer(function() Library.Dock:SyncTabs() end)
        end
        return Tab
    end

    --// Key tab (centered page with a key box, like Obsidian)
    function Window:AddKeyTab(...)
        local Info = ...
        local Name, IconName, Description
        if typeof(Info) == "table" then
            Name, IconName, Description = Info.Name or "Key", Info.Icon, Info.Description
        else
            Name, IconName, Description = ...
        end
        local Tab = Window:AddTab({ Name = Name or "Key", Icon = IconName or "key", Description = Description })
        Tab.IsKeyTab = true
        Tab.Layout:SetVisible(false)

        local Body = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0.7, 0, 0, 0), Parent = Tab.Container })
        List(Body, 10)
        Tab.Container = Body
        Tab.Elements, Tab.DependencyBoxes, Tab.Tab = {}, {}, Tab

        function Tab:AddKeyBox(Callback)
            local Row = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Parent = Body })
            List(Row, 8, Enum.FillDirection.Horizontal)
            local Box = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), PlaceholderText = "Key", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = Row })
            Flex(Box)
            Corner(Box, 7)
            Pad(Box, 0, 10, 0, 10)
            Stroke(Box, "Outline", 1, 0.4)
            local Btn = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 0, Size = UDim2.fromOffset(80, 30), Text = "Submit", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Row })
            Corner(Btn, 7)
            Btn.MouseButton1Click:Connect(function() Library:SafeCallback(Callback, Box.Text) end)
            return Box
        end

        setmetatable(Tab, BaseGroupbox)
        return Tab
    end

    --// Sheet dialog (macOS alert sheet attached to the window)
    function Window:AddDialog(Idx, Info)
        if typeof(Idx) == "table" and Info == nil then Info, Idx = Idx, nil end
        -- unnamed dialogs still need a key; Library.Dialogues[nil] would throw
        if Idx == nil then
            Library.DialogCounter = (Library.DialogCounter or 0) + 1
            Idx = "Dialog" .. Library.DialogCounter
        end
        Info = Library:Validate(Info, Templates.Dialog)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 50, Parent = Main })
        Corner(Dim, WindowInfo.CornerRadius)
        Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)

        local Sheet = New("Frame", {
            BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0.5, 0, 0, TitleH - 24), Size = UDim2.fromOffset(340, 0), ZIndex = 51, Parent = Dim,
        })
        Corner(Sheet, 12)
        Library:AddSurface(Sheet, 0, 0.5)
        Library:AddGlass(Sheet)
        Stroke(Sheet, "Outline", 1, 0.2)
        Tween(Sheet, { Position = UDim2.new(0.5, 0, 0, TitleH + 8) }, Library.SlowTween)

        local Inner = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), ZIndex = 52, Parent = Sheet })
        List(Inner, 10, nil, Enum.HorizontalAlignment.Center)
        Pad(Inner, 18, 18, 16, 18)

        local Badge = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromOffset(48, 48), LayoutOrder = 1, ZIndex = 52, Parent = Inner })
        Corner(Badge, 12)
        local DIcon = Library:GetCustomIcon(Info.Icon or "leaf")
        if DIcon then
            local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(28, 28), ImageColor3 = "AccentText", ZIndex = 53, Parent = Badge })
            Library:ApplyIcon(Img, DIcon)
        end
        local DTitle = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Library:ToRichText(Info.Title), FontFace = "FontBold", TextSize = 15, TextWrapped = true, LayoutOrder = 2, ZIndex = 52, Parent = Inner })
        local DDesc = Library:RenderRich(Inner, Info.Description, { Size = 12, Color = "SubText", Align = "Center", LayoutOrder = 3, Visible = Info.Description ~= "" })
        local DContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4, ZIndex = 52, Parent = Inner })
        List(DContainer, 8)
        local BtnRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 5, ZIndex = 52, Parent = Inner })
        List(BtnRow, 8, Enum.FillDirection.Horizontal)

        local Dialog = { Destroyed = false, Container = DContainer, Elements = {}, DependencyBoxes = {}, OutsideClickDismiss = Info.OutsideClickDismiss }

        function Dialog:SetTitle(T) DTitle.Text = Library:ToRichText(T) end
        function Dialog:SetDescription(T) DDesc:SetText(T); DDesc.Host.Visible = T ~= "" end
        function Dialog:Show()
            if Dialog.Destroyed or not Dim.Parent then return end
            if Library.ActiveDialog and Library.ActiveDialog ~= Dialog then
                pcall(function() Library.ActiveDialog:Dismiss() end)
            end
            Dim.Visible = true
            Library.ActiveDialog = Dialog
        end
        function Dialog:Hide()
            if Dialog.Destroyed then return end
            Dim.Visible = false
            if Library.ActiveDialog == Dialog then Library.ActiveDialog = nil end
        end
        function Dialog:Dismiss()
            if Dialog.Destroyed then return end
            Dialog.Destroyed = true
            if Library.ActiveDialog == Dialog then Library.ActiveDialog = nil end
            for I = #Dialog.Elements, 1, -1 do Dialog.Elements[I]:Destroy() end
            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
            Tween(Sheet, { Position = UDim2.new(0.5, 0, 0, TitleH - 24) }, Library.TweenInfo)
            task.delay(0.2, function() Dim:Destroy() end)
            Library.Dialogues = Library.Dialogues or {}
            Library.Dialogues[Idx] = nil
        end
        function Dialog:AddFooterButton(_, BInfo)
            local Variant = BInfo.Variant or "Secondary"
            local Key = Variant == "Primary" and "Accent" or Variant == "Destructive" and "Red" or "Control"
            local B = New("TextButton", { BackgroundColor3 = Key, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Text = BInfo.Title or "OK", TextColor3 = (Variant == "Secondary") and "Text" or "AccentText", FontFace = Variant == "Primary" and "FontBold" or "Font", LayoutOrder = BInfo.Order or 0, ZIndex = 53, Parent = BtnRow })
            Flex(B)
            Corner(B, 7)
            New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B })
            B.MouseEnter:Connect(function() Tween(B, { BackgroundColor3 = Lighten(Library.Scheme[Key], Variant == "Secondary" and 0.04 or 0.07) }) end)
            B.MouseLeave:Connect(function() Tween(B, { BackgroundColor3 = Library.Scheme[Key] }) end)
            B.MouseButton1Click:Connect(function()
                if BInfo.Callback then Library:SafeCallback(BInfo.Callback, Dialog) end
                if Info.AutoDismiss then Dialog:Dismiss() end
            end)
        end

        Dim.MouseButton1Click:Connect(function()
            if Info.OutsideClickDismiss and not IsOver(Sheet, MousePos()) then Dialog:Dismiss() end
        end)

        for I, BInfo in Info.FooterButtons do Dialog:AddFooterButton(BInfo.Id or I, BInfo) end
        BtnRow.Visible = #Info.FooterButtons > 0

        setmetatable(Dialog, BaseGroupbox)
        Library.Dialogues = Library.Dialogues or {}
        Library.Dialogues[Idx] = Dialog
        if Library.ActiveDialog and Library.ActiveDialog ~= Dialog then
            pcall(function() Library.ActiveDialog:Dismiss() end)
        end
        if Info.Hidden then
            Dim.Visible = false
        else
            Library.ActiveDialog = Dialog
        end
        return Dialog
    end

    --// Input / toggle keybind
    Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input)
        if Library.Unloaded then return end
        if Input.KeyCode == Enum.KeyCode.Escape then
            if UserInputService:GetFocusedTextBox() then return end
            if Library.CurrentPopup or Library.CurrentModal then return end
            if Library.ActiveDialog and Library.ActiveDialog.OutsideClickDismiss ~= false then
                Library.ActiveDialog:Dismiss()
            end
            return
        end
        if UserInputService:GetFocusedTextBox() or Library.IsPicking then return end
        if typeof(Library.ToggleKeybind) == "EnumItem" and Input.KeyCode == Library.ToggleKeybind then
            Window:Toggle()
        end
    end))

    --// Mobile toggle button
    if Library.IsMobile and WindowInfo.ShowMobileButton then
        local MB = New("TextButton", { BackgroundColor3 = "Card", BackgroundTransparency = 0, Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(88, 34), Text = "Evergreen", Parent = Floats })
        Corner(MB, 99)
        Stroke(MB, "Accent", 1.5, 0)
        Library:MakeDraggable(MB, MB)
        MB.MouseButton1Click:Connect(function() Window:Toggle() end)
    end

    -- Bar skins distribute tabs evenly; keep them even while the window is resized
    if SkinBar then
        function Window:RefreshTabBar()
            for _, T in Library.TabList do
                if T.Window == Window and T.ApplySkin then pcall(T.ApplySkin, T) end
            end
        end
    end

    Library.Window = Window
    if WindowInfo.DPIScale ~= 100 then Library:SetDPIScale(WindowInfo.DPIScale) end
    if WindowInfo.Transparency > 0 then Library:SetTransparency(WindowInfo.Transparency) end
    if WindowInfo.Blur then Library:SetBlur(true, WindowInfo.BlurSize) end
    if WindowInfo.Glass then Library:SetGlass(true) end
    if WindowInfo.Dock then Library:CreateDock(typeof(WindowInfo.Dock) == "table" and WindowInfo.Dock or nil) end
    if WindowInfo.AutoShow then task.defer(function() Window:Toggle(true) end) end
    return Window
end

--// Draggable label (watermark / FPS pill) \\--
Library.DraggableLabels = {}
function Library:AddDraggableLabel(Text)
    local Holder = New("Frame", {
        BackgroundColor3 = "Popup", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 28),
        Position = UDim2.fromOffset(12, 12 + #Library.DraggableLabels * 36), Parent = Floats,
    })
    Corner(Holder, 99)
    Stroke(Holder, "Outline", 1, 0.25)
    Pad(Holder, 0, 14, 0, 28)
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Holder })] = true
    local Dot = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -16, 0.5, 0), Size = UDim2.fromOffset(8, 8), Parent = Holder })
    Corner(Dot, 99)
    local Label = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 28), Text = Text or "", TextSize = 12, Parent = Holder })
    Library:MakeDraggable(Holder, Holder)

    local Obj = { Holder = Holder, Label = Label }
    table.insert(Library.DraggableLabels, Obj)
    function Obj:SetText(T) Label.Text = tostring(T) end
    function Obj:SetVisible(V) Holder.Visible = V end
    function Obj:Destroy()
        local I = table.find(Library.DraggableLabels, Obj)
        if I then table.remove(Library.DraggableLabels, I) end
        Holder:Destroy()
    end
    return Obj
end

--// Loading screen (macOS-style progress window) \\--
function Library:CreateLoading(Info)
    if Library.ActiveLoading then return Library.ActiveLoading end
    Info = Library:Validate(Info, { Title = "Evergreen", Icon = "leaf", Message = "Loading...", Description = "", CurrentStep = 0, TotalSteps = 10 })

    local Gui = New("ScreenGui", { Name = "EvergreenLoading", DisplayOrder = 999, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
    pcall(protectgui, Gui)
    if not pcall(function() Gui.Parent = gethui() end) or not Gui.Parent then
        Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local Loading = { Destroyed = false, CurrentStep = Info.CurrentStep, TotalSteps = math.max(1, Info.TotalSteps), ScreenGui = Gui }
    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(380, 230), Parent = Gui })
    Corner(Main, 14)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    Library:MakeDraggable(Main, Main, true)

    New("TextLabel", { Size = UDim2.new(1, 0, 0, 32), Text = Info.Title, FontFace = "FontBold", TextSize = 12, TextColor3 = "SubText", Parent = Main })

    local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 1, -32), Parent = Main })
    List(Content, 8, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

    local Badge = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromOffset(54, 54), LayoutOrder = 1, Parent = Content })
    Corner(Badge, 14)
    local Spin
    local SpinIcon = Library:GetIcon("loader-circle") or Library:GetIcon("loader")
    if SpinIcon then
        Spin = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(30, 30), ImageColor3 = "AccentText", Parent = Badge })
        Library:ApplyIcon(Spin, SpinIcon)
    else
        Spin = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = "◐", TextSize = 28, TextColor3 = "AccentText", Parent = Badge })
    end
    local SpinTween = TweenService:Create(Spin, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Rotation = 360 })
    SpinTween:Play()

    local Message = New("TextLabel", { Size = UDim2.new(1, -40, 0, 20), Text = Info.Message, FontFace = "FontBold", TextSize = 15, LayoutOrder = 2, Parent = Content })
    local Desc = New("TextLabel", { Size = UDim2.new(1, -40, 0, 16), Text = Info.Description, TextSize = 12, TextColor3 = "SubText", LayoutOrder = 3, Parent = Content })
    local Bar = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, Size = UDim2.new(0.8, 0, 0, 8), LayoutOrder = 4, Parent = Content })
    Corner(Bar, 99)
    local FillBar = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromScale(0, 1), Parent = Bar })
    Corner(FillBar, 99)
    local StepLabel = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = "", TextSize = 11, TextColor3 = "SubText", LayoutOrder = 5, Parent = Content })

    local ErrorFrame = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 1, -32), Visible = false, Parent = Main })
    List(ErrorFrame, 8, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    New("TextLabel", { Size = UDim2.new(1, -40, 0, 20), Text = "Something went wrong", FontFace = "FontBold", TextSize = 15, TextColor3 = "Red", LayoutOrder = 1, Parent = ErrorFrame })
    local ErrorText = New("TextLabel", { Size = UDim2.new(1, -40, 0, 70), Text = "", TextSize = 12, TextColor3 = "SubText", TextWrapped = true, LayoutOrder = 2, Parent = ErrorFrame })
    local ErrorButtons = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, -40, 0, 30), LayoutOrder = 3, Parent = ErrorFrame })
    List(ErrorButtons, 8, Enum.FillDirection.Horizontal)

    function Loading:SetMessage(T) Message.Text = tostring(T) end
    function Loading:SetDescription(T) Desc.Text = tostring(T) end
    function Loading:SetCurrentStep(N)
        Loading.CurrentStep = math.clamp(N, 0, Loading.TotalSteps)
        Tween(FillBar, { Size = UDim2.fromScale(Loading.CurrentStep / Loading.TotalSteps, 1) }, Library.SlowTween)
        StepLabel.Text = string.format("%d / %d", Loading.CurrentStep, Loading.TotalSteps)
    end
    function Loading:SetTotalSteps(N) Loading.TotalSteps = math.max(1, N); Loading:SetCurrentStep(Loading.CurrentStep) end

    function Loading:ShowError(Text, Buttons)
        Content.Visible, ErrorFrame.Visible = false, true
        ErrorText.Text = tostring(Text)
        for _, C in ErrorButtons:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end
        for _, B in Buttons or { { Title = "Close", Variant = "Secondary", Callback = function() Loading:Destroy() end } } do
            local Variant = B.Variant or "Secondary"
            local Key = Variant == "Primary" and "Accent" or Variant == "Destructive" and "Red" or "Control"
            local Btn = New("TextButton", { BackgroundColor3 = Key, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Text = B.Title or "OK", TextColor3 = Variant == "Secondary" and "Text" or "AccentText", Parent = ErrorButtons })
            Flex(Btn)
            Corner(Btn, 7)
            Btn.MouseButton1Click:Connect(function() Library:SafeCallback(B.Callback, Loading) end)
        end
    end
    function Loading:HideError() Content.Visible, ErrorFrame.Visible = true, false end

    function Loading:Destroy()
        if Loading.Destroyed then return end
        Loading.Destroyed = true
        pcall(function() SpinTween:Cancel() end)
        Gui:Destroy()
        Library.ActiveLoading = nil
    end
    Loading.Continue = Loading.Destroy

    Loading:SetCurrentStep(Loading.CurrentStep)
    Library.ActiveLoading = Loading
    return Loading
end

--// Save manager (configs) \\--
local HttpService = GetService("HttpService")
local SaveManager = { Folder = "Evergreen", Ignore = {} }
Library.SaveManager = SaveManager

local function HasFS()
    return (writefile and readfile and isfile and isfolder and makefolder and listfiles) and true or false
end
local function EnsureFolders()
    if not HasFS() then return false end
    for _, Path in { SaveManager.Folder, SaveManager.Folder .. "/configs" } do
        if not isfolder(Path) then makefolder(Path) end
    end
    return true
end

function SaveManager:SetFolder(Folder) SaveManager.Folder = Folder; EnsureFolders() end
function SaveManager:SetIgnoreIndexes(L) for _, I in L do SaveManager.Ignore[I] = true end end

local function Skip(Idx)
    return typeof(Idx) ~= "string" or SaveManager.Ignore[Idx] or Idx:find("^EvergreenCfg") ~= nil
end

function SaveManager:Serialize()
    local Data = { toggles = {}, options = {} }
    for Idx, E in Toggles do
        if not Skip(Idx) then Data.toggles[Idx] = { value = E.Value } end
    end
    for Idx, E in Options do
        if not Skip(Idx) then
            local T = E.Type
            if T == "Slider" or T == "Input" then
                Data.options[Idx] = { type = T, value = E.Value }
            elseif T == "RangeSlider" then
                Data.options[Idx] = { type = T, value = { E.ValueMin, E.ValueMax } }
            elseif (T == "Dropdown" or T == "List") and not E.SpecialType then
                if E.Multi then
                    local L = {}
                    for K in E.Value do
                        if typeof(K) == "string" or typeof(K) == "number" then table.insert(L, K) end
                    end
                    Data.options[Idx] = { type = T, value = L }
                else
                    Data.options[Idx] = { type = T, value = E.Value }
                end
            elseif T == "KeyPicker" then
                Data.options[Idx] = { type = T, key = E.Value, mode = E.Mode }
            elseif T == "ColorPicker" then
                Data.options[Idx] = { type = T, hex = E.Value:ToHex(), alpha = E.Transparency }
            end
        end
    end
    return Data
end

function SaveManager:Apply(Data)
    for Idx, D in Data.toggles or {} do
        local E = Toggles[Idx]
        if E and not Skip(Idx) then pcall(E.SetValue, E, D.value) end
    end
    for Idx, D in Data.options or {} do
        local E = Options[Idx]
        if E and E.Type == D.type and not Skip(Idx) then
            if D.type == "ColorPicker" then
                pcall(function() E:SetValueRGB(Color3.fromHex(D.hex), tonumber(D.alpha) or 0) end)
            elseif D.type == "KeyPicker" then
                pcall(E.SetValue, E, { D.key, D.mode })
            elseif D.type == "RangeSlider" then
                pcall(E.SetValue, E, D.value)
            else
                pcall(E.SetValue, E, D.value)
            end
        end
    end
end

function SaveManager:Path(Name)
    Name = tostring(Name):gsub("[^%w%-%_ ]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return string.format("%s/configs/%s.json", SaveManager.Folder, Name)
end

function SaveManager:Save(Name)
    if not Name or Trim(Name) == "" then return false, "Config name is empty." end
    if not EnsureFolders() then return false, "Executor has no file functions." end
    local Ok, Err = pcall(function() writefile(SaveManager:Path(Name), HttpService:JSONEncode(SaveManager:Serialize())) end)
    return Ok, Err
end

function SaveManager:Load(Name)
    if not Name or Name == "" then return false, "No config selected." end
    if not HasFS() or not isfile(SaveManager:Path(Name)) then return false, "Config does not exist." end
    local Ok, Data = pcall(function() return HttpService:JSONDecode(readfile(SaveManager:Path(Name))) end)
    if not Ok then return false, "Invalid config file." end
    SaveManager:Apply(Data)
    return true
end

function SaveManager:Delete(Name)
    if not HasFS() or not isfile(SaveManager:Path(Name)) then return false, "Config does not exist." end
    return pcall(delfile, SaveManager:Path(Name))
end

function SaveManager:List()
    local Out = {}
    if not EnsureFolders() then return Out end
    for _, File in listfiles(SaveManager.Folder .. "/configs") do
        local Name = File:match("([^/\\]+)%.json$")
        if Name then table.insert(Out, Name) end
    end
    table.sort(Out)
    return Out
end

function SaveManager:SetAutoload(Name)
    if not EnsureFolders() then return false end
    writefile(SaveManager.Folder .. "/autoload.txt", Name or "")
    return true
end
function SaveManager:GetAutoload()
    if HasFS() and isfile(SaveManager.Folder .. "/autoload.txt") then
        local N = Trim(readfile(SaveManager.Folder .. "/autoload.txt"))
        if N ~= "" then return N end
    end
    return nil
end
function SaveManager:LoadAutoload()
    local N = SaveManager:GetAutoload()
    if not N then return false end
    local Ok, Err = SaveManager:Load(N)
    if Ok then
        Library:Notify({ Title = "Config", Description = "Autoloaded '" .. N .. "'", Time = 3, Icon = "save" })
    else
        Library:Notify({ Title = "Config", Description = tostring(Err), Time = 4 })
    end
    return Ok
end

-- Builds a ready-made configuration groupbox on a tab (or a page).
function SaveManager:BuildConfigSection(Tab, Side)
    local Box = Tab:AddGroupbox({ Side = Side or 2, Name = "Configuration", IconName = "save" })
    if not EnsureFolders() then
        Box:AddLabel({ Text = "Your executor does not support file functions (writefile / listfiles).", DoesWrap = true })
        return Box
    end

    local function Msg(Ok, Text, Err)
        Library:Notify({ Title = "Config", Description = Ok and Text or tostring(Err), Time = 3, Icon = "save" })
    end

    Box:AddInput("EvergreenCfgName", { Text = "Config name", Placeholder = "my-config" })
    local Dropdown = Box:AddDropdown("EvergreenCfgList", { Text = "Configs", Values = SaveManager:List(), AllowNull = true })
    local AutoLabel = Box:AddLabel("Autoload: " .. (SaveManager:GetAutoload() or "none"))

    local function Refresh() Dropdown:SetValues(SaveManager:List()); Dropdown:SetValue(nil) end

    Box:AddButton({ Text = "Create", Callback = function()
        local Name = Options.EvergreenCfgName.Value
        local Ok, Err = SaveManager:Save(Name)
        Msg(Ok, "Created '" .. tostring(Name) .. "'", Err)
        if Ok then Refresh() end
    end }):AddButton({ Text = "Load", Primary = true, Callback = function()
        local Ok, Err = SaveManager:Load(Dropdown.Value)
        Msg(Ok, "Loaded '" .. tostring(Dropdown.Value) .. "'", Err)
    end })

    Box:AddButton({ Text = "Overwrite", DoubleClick = true, Callback = function()
        local Ok, Err = SaveManager:Save(Dropdown.Value)
        Msg(Ok, "Saved '" .. tostring(Dropdown.Value) .. "'", Err)
    end }):AddButton({ Text = "Delete", Risky = true, DoubleClick = true, Callback = function()
        local Name = Dropdown.Value
        local Ok, Err = SaveManager:Delete(Name)
        Msg(Ok, "Deleted '" .. tostring(Name) .. "'", Err)
        if Ok then Refresh() end
    end })

    Box:AddButton({ Text = "Refresh", Callback = Refresh }):AddButton({ Text = "Set autoload", Callback = function()
        if not Dropdown.Value then return Msg(false, "", "Select a config first.") end
        SaveManager:SetAutoload(Dropdown.Value)
        AutoLabel:SetText("Autoload: " .. Dropdown.Value)
        Msg(true, "Autoload set to '" .. Dropdown.Value .. "'")
    end })

    return Box
end

--// Interface section (theme, accent, scale, menu key) \\--
-- Full UI settings: theme, colors, layout, effects, behavior.
-- Call on a tab: Library:BuildInterfaceSection(Tab)  or  Library:BuildSettingsTab(Window)
function Library:BuildInterfaceSection(Tab, Side)
    local Names = {}
    for N in Themes do table.insert(Names, N) end
    table.sort(Names)

    local function MakeThrottle(Delay, Fn)
        local Last, Pending, Token = 0, nil, 0
        return function(Arg)
            local Now = os.clock()
            Pending = Arg
            Token += 1
            local T = Token
            if Now - Last >= Delay then
                Last, Pending = Now, nil
                Fn(Arg)
            else
                task.delay(Delay - (Now - Last), function()
                    if T ~= Token or Pending == nil then return end
                    local V = Pending
                    Pending, Last = nil, os.clock()
                    Fn(V)
                end)
            end
        end
    end
    local ApplyAccent = MakeThrottle(0.08, function(C)
        if C:ToHex() ~= Library.Scheme.Accent:ToHex() then Library:SetAccent(C) end
    end)
    local function SyncAccentPicker()
        local P = Options.EvergreenAccent
        if P then P:SetValueRGB(Library.Scheme.Accent) end
    end
    local function SyncSchemePickers()
        local Keys = { "Window", "Sidebar", "Titlebar", "Card", "Control", "Text", "SubText", "Outline", "Track", "Popup" }
        for _, K in Keys do
            local P = Options["EvergreenScheme_" .. K]
            if P and typeof(Library.Scheme[K]) == "Color3" then pcall(P.SetValueRGB, P, Library.Scheme[K]) end
        end
        SyncAccentPicker()
    end

    --// Appearance
    local Appear = Tab:AddGroupbox({ Side = Side or 1, Name = "Appearance", IconName = "palette" })
    local ThemeNames = {}
    for _, N in Names do table.insert(ThemeNames, N) end
    for K in Themes do
        if not table.find(ThemeNames, K) then table.insert(ThemeNames, K) end
    end
    Appear:AddDropdown("EvergreenTheme", {
        Text = "Theme", Values = ThemeNames, Default = Library.ThemeName or "Dark",
        Callback = function(V)
            if not V then return end
            Library:SetTheme(V)
            SyncSchemePickers()
        end,
    })
    Appear:AddDropdown("EvergreenSkin", {
        Text = "Skin", Values = Library:GetSkins(), Default = Library:GetSkin(),
        Tooltip = "Skin sets the design; theme sets the colors",
        Callback = function(V)
            if V == nil or Library.SyncingSkin then return end
            Library:SetSkin(V)
            SyncSchemePickers()
        end,
    })

    local function SetIconPack(V)
        if V == nil then return end
        local Ok, Err = Library:SetIconProvider(V)
        if Ok then return end
        Library:Notify({ Title = "Icon pack", Description = tostring(Err or "Could not load that pack"), Icon = "triangle-alert" })
        local DD = Options.EvergreenIconPack
        if DD and typeof(DD.SetValue) == "function" then
            Library.SyncingIconPack = true
            pcall(DD.SetValue, DD, Library.IconProvider)
            Library.SyncingIconPack = false
        end
    end
    Appear:AddDropdown("EvergreenIconPack", {
        Text = "Icon pack", Values = Library:GetIconProviderValues(), Default = Library.IconProvider,
        Tooltip = "Lucide fills in any icon the selected pack is missing",
        Callback = function(V)
            if Library.SyncingIconPack then return end
            SetIconPack(V)
        end,
    })
    Appear:AddToggle("EvergreenIconFallback", {
        Text = "Lucide fallback",
        Default = Library.IconFallback ~= false,
        Tooltip = "Fall back to Lucide for icons the selected pack doesn't have",
        Callback = function(V) Library:SetIconFallback(V and "lucide" or nil) end,
    })
    Appear:AddToggle("EvergreenTabTitle", {
        Text = "Show tab title",
        Default = not (Library.Window and Library.Window.TabTitleVisible == false),
        Callback = function(V) if Library.Window then Library.Window:SetTabTitleVisible(V) end end,
    })
    Appear:AddLabel("Accent"):AddColorPicker("EvergreenAccent", {
        Default = Library.Scheme.Accent, Title = "Accent",
        Callback = ApplyAccent,
    })
    Appear:AddButton({ Text = "Reset accent", Callback = function()
        Library:ResetAccent()
        SyncAccentPicker()
    end }):AddButton({ Text = "Reset theme", Callback = function()
        -- "Reset" also unpins the theme so the skin may suggest its own palette again
        Library.ThemePinned = false
        Library:ResetAccent()
        local SkinTheme = Library.Skin and Library.Skin.DefaultTheme
        Library.ApplyingSkin = SkinTheme ~= nil
        Library:SetTheme(SkinTheme or "Dark")
        Library.ApplyingSkin = false
        SyncSchemePickers()
    end })

    --// Custom colors (override any scheme key live)
    local Colors = Tab:AddGroupbox({ Side = Side or 1, Name = "Custom colors", IconName = "pipette" })
    Colors:AddLabel({ Text = "Tweaks apply on top of the current theme.", DoesWrap = true })
    local SchemeKeys = {
        { "Window", "Window" }, { "Sidebar", "Sidebar" }, { "Titlebar", "Title bar" },
        { "Card", "Card" }, { "Control", "Control" }, { "Popup", "Popup" },
        { "Track", "Track" }, { "Outline", "Outline" },
        { "Text", "Text" }, { "SubText", "Sub text" },
    }
    for _, Pair in SchemeKeys do
        local Key, Label = Pair[1], Pair[2]
        local ApplyKey = MakeThrottle(0.08, function(C)
            Library:SetTheme({ [Key] = C })
        end)
        Colors:AddLabel(Label):AddColorPicker("EvergreenScheme_" .. Key, {
            Default = typeof(Library.Scheme[Key]) == "Color3" and Library.Scheme[Key] or Color3.new(1, 1, 1),
            Title = Label,
            Callback = ApplyKey,
        })
    end

    --// Layout
    local Layout = Tab:AddGroupbox({ Side = (Side == 1 and 2) or (Side == 2 and 1) or 2, Name = "Layout", IconName = "layout" })
    Layout:AddSlider("EvergreenScale", {
        Text = "UI scale", Min = 50, Max = 150, Default = math.floor(Library.DPIScale * 100 + 0.5), Rounding = 0, Suffix = "%",
        Deferred = true, Callback = function(V) Library:SetDPIScale(V) end,
    })
    Layout:AddSlider("EvergreenSidebarWidth", {
        Text = "Sidebar width", Min = 120, Max = 280,
        Default = (Library.Window and Library.Window.Info and Library.Window.Info.SidebarWidth) or 190,
        Rounding = 0, Suffix = "px", Deferred = true,
        Callback = function(V)
            if Library.Window and Library.Window.SetSidebarWidth then Library.Window:SetSidebarWidth(V) end
        end,
    })
    Layout:AddSlider("EvergreenCorner", {
        Text = "Corner radius", Min = 0, Max = 24,
        Default = (Library.Window and Library.Window.Info and Library.Window.Info.CornerRadius) or 12,
        Rounding = 0, Suffix = "px", Deferred = true,
        Callback = function(V)
            if Library.Window and Library.Window.SetCornerRadius then Library.Window:SetCornerRadius(V) end
        end,
    })

    --// Effects
    local Effects = Tab:AddGroupbox({ Side = (Side == 1 and 2) or (Side == 2 and 1) or 2, Name = "Effects", IconName = "sparkles" })
    Effects:AddSlider("EvergreenTransparency", {
        Text = "UI transparency", Min = 0, Max = 80, Default = math.floor(Library.UITransparency * 100 + 0.5), Rounding = 0, Suffix = "%",
        Callback = function(V) Library:SetTransparency(V / 100) end,
    })
    Effects:AddToggle("EvergreenGlass", { Text = "Glass material", Default = Library.GlassEnabled == true, Callback = function(V) Library:SetGlass(V) end })
    Effects:AddToggle("EvergreenBlur", { Text = "Blur behind UI", Default = Library.BlurEnabled == true, Callback = function(V) Library:SetBlur(V) end })
    Effects:AddSlider("EvergreenBlurSize", {
        Text = "Blur size", Min = 2, Max = 40, Default = Library.BlurSize or 16, Rounding = 0,
        Callback = function(V) Library:SetBlur(Library.BlurEnabled, V) end,
    })
    Effects:AddDropdown("EvergreenGlassMode", {
        Text = "Blur mode", Values = { { "Only behind UI", "Region" }, { "Whole screen", "Full" } }, Default = Library.GlassMode,
        Callback = function(V) if V then Library:SetGlassMode(V) end end,
    })
    Effects:AddToggle("EvergreenDock", { Text = "Top dock", Default = Library.Dock ~= nil and Library.Dock.Frame.Visible, Callback = function(V)
        if Library.Dock then Library.Dock:SetVisible(V) elseif V then Library:CreateDock() end
    end })
    Effects:AddInput("EvergreenWallpaper", {
        Text = "Wallpaper (asset id / url)", Placeholder = "rbxassetid://...", Default = Library.WallpaperImage or "",
        Finished = true, Callback = function(V)
            if V == nil or Trim(tostring(V)) == "" then Library:SetWallpaper(nil) else Library:SetWallpaper(V) end
        end,
    })
    Effects:AddSlider("EvergreenWallpaperT", {
        Text = "Wallpaper transparency", Min = 0, Max = 95,
        Default = math.floor((Library.WallpaperTransparency or 0.55) * 100 + 0.5), Rounding = 0, Suffix = "%",
        Callback = function(V) Library:SetWallpaper(Library.WallpaperImage, V / 100) end,
    })
    Effects:AddButton({ Text = "Clear wallpaper", Callback = function()
        Library:SetWallpaper(nil)
        if Options.EvergreenWallpaper then Options.EvergreenWallpaper:SetValue("") end
    end })

    --// Behavior
    local Behavior = Tab:AddGroupbox({ Side = Side or 1, Name = "Behavior", IconName = "settings" })
    Behavior:AddDropdown("EvergreenSearchStyle", {
        Text = "Search style", Values = { { "Collapsible bar", 1 }, { "Spotlight", 2 } },
        Default = Library.Window and Library.Window.SearchStyle or 1,
        Callback = function(V) if V and Library.Window and Library.Window.SetSearchStyle then Library.Window:SetSearchStyle(V) end end,
    })
    Behavior:AddDropdown("EvergreenNotifySide", {
        Text = "Notification side", Values = { "Left", "Right" }, Default = Library.NotifySide or "Right",
        Callback = function(V) if V then Library:SetNotifySide(V) end end,
    })
    Behavior:AddToggle("EvergreenKeybindList", {
        Text = "Show keybind list", Default = Library.KeybindListEnabled == true,
        Callback = function(V) Library:SetKeybindListVisible(V) end,
    })
    Behavior:AddToggle("EvergreenGroupboxDrag", {
        Text = "Drag groupboxes to pin", Default = Library.GroupboxDragEnabled ~= false,
        Tooltip = "Drag a groupbox header outside the window to pin it",
        Callback = function(V) Library.GroupboxDragEnabled = V == true end,
    })
    local Start = typeof(Library.ToggleKeybind) == "EnumItem" and Library.ToggleKeybind.Name or "RightControl"
    Behavior:AddLabel("Menu keybind"):AddKeyPicker("MenuKeybind", { Default = Start, Mode = "Press", NoUI = true, Text = "Menu" })
    Library.ToggleKeybind = Options.MenuKeybind

    return { Appearance = Appear, Colors = Colors, Layout = Layout, Effects = Effects, Behavior = Behavior }
end

-- Creates a dedicated Settings tab with every UI option.
function Library:BuildSettingsTab(Window, Info)
    Info = Info or {}
    local Tab = Window:AddTab({
        Name = Info.Name or "Settings",
        Icon = Info.Icon or "settings",
        Description = Info.Description or "Customize the UI",
    })
    Library:BuildInterfaceSection(Tab, 1)
    if SaveManager and SaveManager.BuildConfigSection and Info.Config ~= false then
        SaveManager:BuildConfigSection(Tab, 2)
    end
    return Tab
end

--// Unload \\--
function Library:Unload()
    if Library.Unloaded then return end
    Library.Unloaded = true

    for I = #Library.Signals, 1, -1 do
        local C = table.remove(Library.Signals, I)
        if C and C.Connected then C:Disconnect() end
    end
    for _, Callback in Library.UnloadSignals do Library:SafeCallback(Callback) end
    for _, E in Library.KeybindPickers do if E.Connections then for _, C in E.Connections do pcall(C.Disconnect, C) end end end

    if Library.ActiveLoading then Library.ActiveLoading:Destroy() end
    Library:DestroyBlur()
    pcall(function() ModalElement.Modal = false end)
    ScreenGui:Destroy()

    for _, T in { Labels, Buttons, Toggles, Options, Library.Tabs, Library.TabList, Library.DependencyBoxes, Library.Notifications, Library.KeybindPickers } do
        table.clear(T)
    end
    table.clear(Library.Registry)
    table.clear(Library.AppliedIcons)

    Library.Toggle = function() end
    Library.Window = nil
    getgenv().Library = nil
end

--// Player/Team dropdown refresh \\--
local function RefreshSpecialDropdowns()
    if Library.Unloaded then return end
    for _, D in Options do
        if D.Type == "Dropdown" and D.SpecialType == "Player" then
            D:SetValues(GetPlayers(D.ExcludeLocalPlayer))
        elseif D.Type == "Dropdown" and D.SpecialType == "Team" then
            D:SetValues(GetTeams())
        end
    end
end
local function HookTeamRefresh(P)
    if typeof(P) ~= "Instance" then return end
    -- Auto-disconnects when the player instance is removed.
    P:GetPropertyChangedSignal("Team"):Connect(RefreshSpecialDropdowns)
end
for _, P in Players:GetPlayers() do HookTeamRefresh(P) end
Library:GiveSignal(Players.PlayerAdded:Connect(function(P)
    HookTeamRefresh(P)
    RefreshSpecialDropdowns()
end))
Library:GiveSignal(Players.PlayerRemoving:Connect(RefreshSpecialDropdowns))
Library:GiveSignal(Teams.ChildAdded:Connect(RefreshSpecialDropdowns))
Library:GiveSignal(Teams.ChildRemoved:Connect(RefreshSpecialDropdowns))

getgenv().Library = Library
return Library
