-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- Window configurations
config.enable_tab_bar = false
config.window_background_opacity = 0.8

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = 'FiraCode'
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Finally, return the configuration to wezterm:
return config
