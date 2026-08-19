require("startup")

-- ── PROGRAMS ────────────────────────────────────────────────
local terminal         = "ghostty"
local fileManager      = "thunar"
local mainMod          = "SUPER"
local ipc              = "noctalia msg "

local noctalia_pallete = require("noctalia")
noctalia_pallete.apply_theme()

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

hl.device({
    name = "synps/2-synaptics-touchpad",
    enabled = false,
})

-- ── GENERAL ─────────────────────────────────────────────────
hl.config({
    general = {
        border_size   = 3,
        gaps_in       = 3,
        gaps_out      = 6,
        layout        = "dwindle",
        allow_tearing = false,
    }
})

-- ── DECORATION ──────────────────────────────────────────────
hl.config({
    decoration = {
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        rounding         = 0,
        blur             = {
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

hl.curve("panelEngage", {
    type = "bezier",
    points = {
        { 0.34, 1.56 },
        { 0.64, 1.0 },
    },
})

hl.animation({
    leaf    = "specialWorkspace",
    enabled = true,
    speed   = 2.5,
    bezier  = "panelEngage",
    style   = "slidefadevert",
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

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "mic-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true, repeating = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd(ipc .. "screenshot-region"))

-- Launch
hl.bind("SUPER + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind("SUPER + F", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))

-- ── SCRATCHPAD ──────────────────────────────────────────────
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ── SESSION ─────────────────────────────────────────────────
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Clipboard
hl.bind("SUPER + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))

-- Notifications
hl.bind("SUPER + N", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center notifications"))

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
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
    match = { workspace = "special:magic" },
    opacity = "0.92 override 0.82 override",
})

hl.window_rule({
    match  = { title = "Open File|Save File|Select.*File" },
    float  = true,
    center = true,
})

hl.window_rule({
    match  = {
        title = "bluetu[iI]",
    },
    float  = true,
    center = true,
    size   = { 900, 600 },
})

hl.window_rule({
    match      = { title = "nmtui" },
    fullscreen = true,
})
