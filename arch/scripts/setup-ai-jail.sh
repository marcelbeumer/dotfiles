#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.local/state/rx/pi
mkdir -p ~/.local/state/rx/opencode

cat > ~/.ai-jail << EOF
no_save_config = true
network = true
private_home = true

ro_maps = [
  "~/.local/share/nvim/mason",
]

# Global rw_maps for easy of use. 
# Could split up in [command.<command>] blocks if needed.
rw_maps = [
  "~/g/allow:~/g/allow",
  "~/g/ask:~/g/ask",
  "~/.config/mise", 
  "~/.local/share/mise",
  "~/.local/share/rx/agents/opencode:~/.config/opencode",
  "~/.local/state/rx/opencode:~/.local/share/opencode",
  "~/.local/state/rx/pi:~/.pi",
  "~/.local/share/rx/agents/pi/agent/AGENTS.md:~/.pi/agent/AGENTS.md",
  "~/.local/share/rx/agents/pi/agent/models.json:~/.pi/agent/models.json",
  "~/.local/share/rx/agents/pi/agent/settings.json:~/.pi/agent/settings.json",
]

EOF
