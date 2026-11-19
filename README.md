# Lomarchy

Local Omarchy changes for this machine. Omarchy updates do not overwrite these files.

## Cursor and Grok Bot in the Agents panel

`cursor-agent` keeps its login in the OS secret store. Omarchy's usage collectors only read `~/.config/cursor/auth.json`, so Cursor and Grok Bot stay out of the Agents panel.

`lib/omarchy-agents-bin/omarchy-agent-usage-update` reads that keyring item for one refresh and passes `CURSOR_AUTH_TOKEN` to the real updater. The token is not written to disk.

`config/hypr/hyprland.lua` puts `~/.local/lib/omarchy-agents-bin` ahead of `/usr/share/omarchy/bin`. Omarchy pins its own bin directory at the front of `PATH`, so a copy in `~/.local/bin` would never run.

Install:

```bash
install -D -m 755 lib/omarchy-agents-bin/omarchy-agent-usage-update \
  ~/.local/lib/omarchy-agents-bin/omarchy-agent-usage-update
cp config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua
hyprctl reload
omarchy restart shell
```

`omarchy refresh hyprland` replaces `~/.config/hypr/hyprland.lua` and drops the `PATH` block. The wrapper stays.
