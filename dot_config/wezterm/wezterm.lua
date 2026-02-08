local wezterm = require "wezterm"

local config = wezterm.config_builder()

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

config.cursor_blink_rate = 800
config.default_cursor_style = "BlinkingBar"

config.hide_tab_bar_if_only_one_tab = true

return config
