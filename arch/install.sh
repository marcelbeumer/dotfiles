#!/usr/bin/env bash
set -e

script_path="$(readlink -f "$0")"
script_dir="$(dirname "$script_path")"
cd "$script_dir"

link() {
  [[ -L "$2" ]] && rm "$2"
  [[ -e "$2" ]] && { echo "ERROR: $2 exists"; return 1; }
  ln -s "$1" "$2"
}

for file in dotfiles/link/*; do
  [[ -e "$file" ]] || continue
  name=$(basename "$file")
  link "$script_dir/$file" "$HOME/.$name"
done

mkdir -p "$HOME/.config"
for dir in config/link/*; do
  [[ -d "$dir" ]] || continue
  link "$script_dir/$dir" "$HOME/.config/$(basename "$dir")"
done

for dir in config/copy/*; do
  [[ -d "$dir" ]] || continue
  name=$(basename "$dir")
  rm -rf "$HOME/.config/$name"
  cp -r "$script_dir/$dir" "$HOME/.config/$name"
done


mkdir -p $HOME/.local/share/applications
for file in xdg-applications/*.desktop; do
  [[ -f "$file" ]] || continue
  name=$(basename "$file")
  [[ "$name" == "." || "$name" == ".." ]] && continue
  link "$script_dir/$file" "$HOME/.local/share/applications/$name"
done

# Expose the whole arch tree read-only at ~/.local/share/rx so that both the
# wrapper scripts (rx/bin) and the agent config (rx/agents) resolve from one
# namespace. State/auth/sessions live separately under ~/.local/state/rx.
mkdir -p "$HOME/.local/share"
link "$script_dir" "$HOME/.local/share/rx"
mkdir -p "$HOME/.local/state/rx"

# Apply theme (uses persisted theme or default).
theme=$(cat "$HOME/.local/state/rx/theme" 2>/dev/null || echo default)
"$script_dir/bin/rx-theme" "$theme"

"$script_dir/scripts/setup-ai-jail.sh"
