# Global Instructions

- Keep responses concise.
- You can make commit, but never push.
- Commit Conventions
  - Use [Conventional Commits](https://www.conventionalcommits.org/) format: `type: summary`
  - Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`
  - In the commit body, summarize what was changed and why
  - End the commit body with the agent and model that produced it, e.g.: `Implemented by opencode (z-ai/glm-5.1).`

# Sandbox Environment

You are running inside a sandbox (ai-jail / container), not the real host.

- The filesystem is a filtered view of the host. Only these are writable:
  - `~/g/allow`, `~/g/ask`
  - `~/.config/mise`, `~/.local/share/mise`
  - `~/.config/opencode`, `~/.pi`, `~/.local/share/opencode`
- Most of the host is hidden or read-only. Do not assume host paths, tools,
  services, or state exist.
- No Docker socket, no systemd, no GPU, restricted network. Verify before
  relying on anything host-specific.
