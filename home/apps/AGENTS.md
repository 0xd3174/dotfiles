# Global Agent Guidelines

- **Tone**: Write all documentation and comments in a strict, formal, and dry technical register. Keep every piece of documentation in fluent English.

## Environment & Toolchain (NixOS)

- **Host OS**: NixOS. No compilers or runtimes exist in global paths (`/usr/bin`, `$PATH`).
- **Minimal Flakes**: Keep `flake.nix` and `devShells` strictly minimal (packages and env vars only). Delegate scripts and automation to project tools (`Makefile`, `package.json`, `cargo`), never Nix shell hooks.
- **Ephemeral Shell**: Environment variables and shells do NOT persist between tool calls. Never run standalone `nix develop`; always wrap commands via `nix develop -c <command>`.
- **Ad-hoc Tools**: For missing one-off utilities, use `nix run nixpkgs#<pkg> -- <args>`.

## Version Control (Git)

- **Initialization**: Check `git rev-parse --is-inside-work-tree` first. Initialize unversioned project directories with `git init`, but NEVER run `git init` in `$HOME` or parent directories.
- **Nix Flake Visibility**: Flakes ignore untracked files. Configure `.gitignore` first, then stage newly created project files (`git add <files>`) before invoking `nix develop` or `nix build`.
- **Non-Interactive Only**: Never run commands requiring interactive input (`git rebase -i`, `git add -i`, `git commit` without `-m`).
- **Atomic Commits**: Commit each logically complete step only after build and tests pass (`nix develop -c ...`). Follow Conventional Commits (`feat:`, `fix:`, `refactor:`, `chore:`).
- **Workspace Hygiene**: Never commit build artifacts, `.direnv/`, `result` symlinks, secrets, or `.env`.

## Code & Communication

- **Strict YAGNI**: Implement only what was directly requested. Do not add speculative abstractions or unrequested configuration.
- **Surgical Edits**: Make minimal diffs matching existing project idioms.
- **Documentation & Comments**: Comment only non-obvious invariants and architecture. Do not explain obvious mechanics.
- **Zero Fluff & Critical Stance**: No conversational filler, praise, or hedging. Evaluate user prompts, architecture, and existing code critically - point out design flaws, race conditions, edge cases, performance bottlenecks, or security issues directly.
