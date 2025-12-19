-- Alt + Enter -> Toggle Fullscreen

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_cursor_style = "SteadyBar"

-- This is where you actually apply your config choices.
-- config.default_domain = 'WSL:Ubuntu'

config.default_cwd = "~"

-- CTRL + SHIFT + L and type wezterm.gui.enumerate_gpus()

config.front_end = "WebGpu"
config.webgpu_preferred_adapter = wezterm.gui.enumerate_gpus()[1]

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 16
config.color_scheme = "Catppuccin Mocha"

-- remove all padding from editor
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_decorations = "TITLE|RESIZE"

config.hide_tab_bar_if_only_one_tab = true

config.webgpu_power_preference = "HighPerformance"

config.window_close_confirmation = "NeverPrompt"

config.native_macos_fullscreen_mode = true
config.macos_window_background_blur = 0

-- Finally, return the configuration to wezterm:
return config
