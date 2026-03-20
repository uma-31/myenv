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

-- OS ごとの設定
if wezterm.target_triple:find("darwin") then
    -- Mac
    config.native_macos_fullscreen_mode = true
elseif wezterm.target_triple:find("windows") then
    -- Windows
    local wsl_domains = wezterm.default_wsl_domains()

    if #wsl_domains > 0 then
        config.default_domain = wsl_domains[1].name
    end

    config.launch_menu = {}
    for _, domain in ipairs(wsl_domains) do
        if domain.name ~= "WSL:docker-desktop" then
            table.insert(
                config.launch_menu,
                {
                    label = domain.name,
                    cwd = "~",
                    domain = {
                        DomainName = domain.name,
                    },
                }
            )
        end
    end
    table.insert(
        config.launch_menu,
        {
            label = "PowerShell",
            args = { "powershell.exe", "-NoLogo" },
            domain = {
                DomainName = "local",
            },
        }
    )
end

-- ショートカットキーの設定
config.keys = {
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ShowLauncherArgs {
            flags = "LAUNCH_MENU_ITEMS"
        },
    },
}

-- 環境固有設定
local ok, apply_local_config = pcall(require, "local")
if ok and type(apply_local_config) == "function" then
    apply_local_config(config, wezterm)
end

return config
