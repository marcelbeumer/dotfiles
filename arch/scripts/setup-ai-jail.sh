#!/usr/bin/env bash
set -euo pipefail

cat > ~/.ai-jail << EOF
# ai-jail sandbox configuration
# https://github.com/akitaonrails/ai-jail
# Edit freely. Regenerate with: ai-jail --clean --init

ro_maps = [
    "~/.local/share/nvim/mason",
]

rw_maps = [
    "~/g/allow:~/g/allow",
    "~/g/ask:~/g/ask",
]

no_save_config = true
network = true
private_home = true
EOF
