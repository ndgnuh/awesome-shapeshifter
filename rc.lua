-- default font is too small...
local beautiful = require("beautiful")
beautiful.font = "sans 14"

-- load luarocks module
pcall(require, "luarocks.loader")
-- add some directory to the path
-- so that require("dir.module") can be written as require("module")
-- reason is that important folders can be restructured without
-- changing every require call in each files
-- modules in those directories will be carefully named
-- so as to not conflict with those in the rice
local gears = require"gears"
local wmdir = gears.filesystem.get_configuration_dir()
package.path = package.path .. (";" .. wmdir .. "helper/?.lua")

local Rice = require("Rice")
local display = os.getenv("DISPLAY")
if display == ":1" then
	-- if you are debugging with Xephyr
	Rice:load_rice("ricename")
else
  Rice:load_rice()
end
