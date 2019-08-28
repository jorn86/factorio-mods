local mode = settings.startup["hw-mode"].value
local military = require("scripts.tier_config_military")
local standard = require("scripts.tier_config_standard")

if mode == "military" then return military end
return standard
