local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- 外観設定
config.color_scheme = "GitHub Dark"
config.font = wezterm.font("HackGen Console NF")

config.background = {
    {
        source = {
            Color = "black"
        },
        width = "100%",
        height = "100%",
        opacity = 0.6,
    },
}

local background_image_candidates = wezterm.glob(
    wezterm.config_dir .. "/background-image.*"
)
if #background_image_candidates > 0 then
    table.insert(
        config.background,
        1,
        {
            source = {
                File = background_image_candidates[1]
            },
            vertical_align = "Middle",
            horizontal_align = "Center"
        }
    )
end

-- カーソル設定
config.cursor_blink_rate = 800
config.default_cursor_style = "BlinkingBar"

-- タブバー設定
config.hide_tab_bar_if_only_one_tab = true

-- Mac OS
config.native_macos_fullscreen_mode = true

-- 環境固有設定
local ok, apply_local_config = pcall(require, "local")
if ok and type(apply_local_config) == "function" then
    apply_local_config(config, wezterm)
end

return config
