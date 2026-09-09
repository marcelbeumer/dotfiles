#!/usr/bin/env bash
set -euo pipefail

cat > ~/.ai-jail << 'EOF'
no_save_config = true
network = true
private_home = true

ro_maps = [
  "~/.local/share/nvim/mason",
]

# Global rw_maps for easy of use.
# Could split up in [command.<command>] blocks if needed.
rw_maps = [
  "~/g/allow",
  "~/g/ask",
  "~/.config/mise",
  "~/.local/share/mise",
  "~/.local/share/rx/agents/opencode:~/.config/opencode",
  "~/.local/share/rx/agents/pi:~/.pi",
  "~/.local/share/opencode",
]
EOF
