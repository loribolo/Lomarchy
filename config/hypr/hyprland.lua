-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Omarchy pins its own bin directory at the front of PATH, which hides a
-- ~/.local/bin override. This directory holds a usage-update wrapper that
-- reads the Cursor keyring login for that refresh only.
local agents_bin = (os.getenv("HOME") or "") .. "/.local/lib/omarchy-agents-bin"
local omarchy_bin = (os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/bin"
local path_entries = {}
local function add_once(entry)
  if entry == "" then return end
  for _, existing in ipairs(path_entries) do
    if existing == entry then return end
  end
  table.insert(path_entries, entry)
end
add_once(agents_bin)
add_once(omarchy_bin)
for entry in (os.getenv("PATH") or ""):gmatch("[^:]+") do
  if entry ~= agents_bin and entry ~= omarchy_bin then
    add_once(entry)
  end
end
hl.env("PATH", table.concat(path_entries, ":"))
