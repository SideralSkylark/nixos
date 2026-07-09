require("startup")

-- ── PROGRAMS ────────────────────────────────────────────────
local terminal    = "footclient || foot"
local menu        = "fuzzel"
local fileManager = "thunar"
local mainMod     = "SUPER"

-- ── MONITOR ─────────────────────────────────────────────────
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- ── XWAYLAND ────────────────────────────────────────────────
hl.config({ xwayland = { force_zero_scaling = true } })

-- ── INPUT ───────────────────────────────────────────────────
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
    }
})

-- ── THEME — EVERFOREST HARD DARK ────────────────────────────
local colors = {
    active_border   = { colors = { "rgba(A7C080dd)" } },
    inactive_border = { colors = { "rgba(3A464Caa)" } },
}

-- ── GENERAL ─────────────────────────────────────────────────
hl.config({
    general = {
        border_size             = 2,
        ["col.active_border"]   = colors.active_border,
        ["col.inactive_border"] = colors.inactive_border,
        gaps_in                 = 3,
        gaps_out                = 6,
        layout                  = "dwindle",
        allow_tearing           = false,
    }
})

-- ── DECORATION ──────────────────────────────────────────────
hl.config({
    decoration = {
        rounding = 0,
        blur = {
            enabled = false,
        }
    }
})

-- ── ANIMATIONS ──────────────────────────────────────────────
hl.config({
    animations = {
        enabled = true,
    },
})

-- Define the bezier curve
hl.curve("snappyOut", {
    type = "bezier",
    points = {
        { 0.16, 1.0 },
        { 0.30, 1.0 },
    },
})

-- Animations
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 2,
    bezier = "snappyOut",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 2,
    bezier = "snappyOut",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 4,
    bezier = "snappyOut",
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 2,
    bezier = "snappyOut",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3,
    bezier = "snappyOut",
    style = "fade",
})
-- ── LAYOUT ──────────────────────────────────────────────────
hl.config({
    dwindle = {
        preserve_split = true,
    }
})
-- ── MISC ────────────────────────────────────────────────────
hl.config({
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    }
})

-- ── KEYBINDS ────────────────────────────────────────────────

-- Media
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio mic"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness down"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("screenshot screen"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("screenshot edit"))

-- power profile toggle
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/power-toggle"))

-- Launch
hl.bind("SUPER + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + F", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("/home/skylark/.config/hypr/scripts/reading-mode toggle"))
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/random-wallpaper"))

-- Clipboard
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))

-- Notifications
hl.bind("SUPER + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/dunst-history"))

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Focus
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

-- Move windows
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- -- Workspaces
for i = 1, 9 do
    hl.bind("SUPER + " .. i,
        hl.dsp.focus({ workspace = i }))

    hl.bind("SUPER + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + 0",
    hl.dsp.focus({ workspace = 10 }))

hl.bind("SUPER + SHIFT + 0",
    hl.dsp.window.move({ workspace = 10 }))

-- -- window rules

hl.window_rule({
    match  = {
        class = "nm-connection-editor",
    },

    float  = true,
    center = true,
    size   = { 900, 700 },
})

hl.window_rule({
    match  = {
        title = "bluetu[iI]",
    },

    float  = true,
    center = true,
    size   = { 900, 600 },
})
