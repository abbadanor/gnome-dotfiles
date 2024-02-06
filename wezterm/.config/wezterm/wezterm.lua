local wezterm = require("wezterm")

local function font_with_fallback(name, params)
    local names = { name, "Joy Pixels", "Noto Color Emoji" }
    return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font Mono"

wezterm.on('mux-startup', function()
    local tab, pane, window = mux.spawn_window {}
    pane:split { direction = 'Top' }
end)

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return {
    -- OpenGL for GPU acceleration, Software for CPU
    front_end = "OpenGL",

    unix_domains = {
        {
            name = 'dev',
            serve_command = { 'zsh' }
        }
    },

    color_scheme = 'OneDark (base16)',
    window_decorations = "NONE",
    -- window_decorations = "RESIZE",

    font = font_with_fallback 'JetBrainsMono Nerd Font Mono',
    font_rules = {
        -- For Bold-but-not-italic text, use this relatively bold font, and override
        -- its color to a tomato-red color to make bold text really stand out.
        {
            intensity = 'Bold',
            italic = false,
            font = font_with_fallback {
                family = font_name,
                weight = 700,
            },
        },

        -- Bold-and-italic
        {
            intensity = 'Bold',
            italic = true,
            font = font_with_fallback {
                family = font_name,
                italic = true,
            },
        },

        -- normal-intensity-and-italic
        {
            intensity = 'Normal',
            italic = true,
            font = font_with_fallback {
                family = font_name,
                weight = 'DemiLight',
                italic = true,
            },
        },

        {
            intensity = 'Normal',
            italic = false,
            font = font_with_fallback {
                family = font_name,
                weight = 'Regular',
            },
        },

        -- half-intensity-and-italic (half-bright or dim); use a lighter weight font
        {
            intensity = 'Half',
            italic = true,
            font = font_with_fallback {
                family = font_name,
                weight = 'Light',
                italic = true,
            },
        },

        -- half-intensity-and-not-italic
        {
            intensity = 'Half',
            italic = false,
            font = font_with_fallback {
                family = font_name,
                weight = 'Light',
            },
        },
    },

    -- Font config
    warn_about_missing_glyphs = false,
    font_size = 11,
    -- line_height = 1.0,
    -- dpi = 96.0,

    -- Cursor style
    default_cursor_style = "BlinkingUnderline",

    -- X11
    enable_wayland = false,

    -- Keybinds
    disable_default_key_bindings = true,
    keys = {
        { -- browser-like bindings for tabbing
            key = "t",
            mods = "CTRL",
            action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
        },
        {
            key = "Tab",
            mods = "CTRL",
            action = wezterm.action({ ActivateTabRelative = 1 }),
        },
        {
            key = "Tab",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivateTabRelative = -1 }),
        }, -- standard copy/paste bindings
        {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
        },
        {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
        },
        {
            key = "=",
            mods = "CTRL",
            action = "IncreaseFontSize",
        },
        {
            key = "-",
            mods = "CTRL",
            action = "DecreaseFontSize",
        },
    },

    -- Aesthetic Night Colorscheme
    bold_brightens_ansi_colors = true,
    -- Padding
    window_padding = {
        left = 12,
        right = 12,
        top = 12,
        bottom = 12,
    },

    -- Tab Bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = false,
    tab_bar_at_bottom = true,

    -- General
    automatically_reload_config = true,
    inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
    window_background_opacity = 1.0,
    window_close_confirmation = "NeverPrompt",
}
