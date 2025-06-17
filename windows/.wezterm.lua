-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.default_domain = 'WSL:Ubuntu'

config.default_cwd = '~/'

config.front_end = 'WebGpu'

config.webgpu_preferred_adapter = wezterm.gui.enumerate_gpus()[2]
-- config.webgpu_preferred_adapter = {
--   backend = 'Dx12',
--   device = 10400,
--   device_type = 'DiscreteGpu',
--   name = 'NVIDIA GeForce RTX 4060 Laptop GPU',
--   vendor = 4318
-- }

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12.5
config.color_scheme = 'Catppuccin Mocha'

-- remove all padding from editor
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

--config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true

config.webgpu_power_preference = 'HighPerformance'
-- Finally, return the configuration to wezterm:
return config
