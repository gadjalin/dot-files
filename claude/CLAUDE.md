# Files

- Do not write special unicode symbols yourself (arrows, box drawing, em
  dashes, emoji, fancy quotes), especially in markdown. Use ASCII equivalents
  (`->`, `-`, `...`). Accented letters and other alphabets are fine.
- Leave unicode the user wrote themselves alone (e.g. vim listchars, tmux
  cosmetics, macOS Alt-key mappings in .vimrc); do not convert it to escapes.

# Git

- Never run git (or gh) commands that change repository state or history
  unless I explicitly allow that specific action: no init, add, rm, mv,
  commit, amend, rebase, reset, restore, checkout/switch, stash, merge,
  cherry-pick, tag, branch creation/deletion, fetch, pull, push, clone, or
  PR/issue creation.
- Read-only commands are fine: status, log, diff, show, blame, branch
  listing, ls-files, etc.
- When a change seems useful, suggest the command and let me run it or
  approve it.
