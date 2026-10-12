# Shortcuts

What a regular Vim user would not guess in this config. Everything else works
as in stock Vim. The leader key is `Space`.

Entries marked with `*` are my additions. The rest comes from
[craftzdog's config](https://github.com/craftzdog/dotfiles).

## Stock keys that behave differently

| Key | What it does here |
| --- | --- |
| `s` | Prefix for windows (see below), no longer "substitute" |
| `;` | Prefix for pickers (see below), no longer "repeat `f`" |
| `q` `*` | Disabled: no macro recording. It still closes pickers and explorers |
| `x` | Deletes without copying |
| `dw` | Deletes the word **before** the cursor |
| `Ctrl+a` | Select the whole file |
| `Tab` / `Shift+Tab` | Next / previous tab page |
| `y`, `p` | Use the system clipboard |

Also: the mouse is off, files are formatted on save (`:ToggleFormatter`
switches it off for a buffer), and diagnostics show a message but no underline
`*`.

## Windows and tabs

| Key | Action |
| --- | --- |
| `ss` / `sv` | Split horizontally / vertically |
| `sh` `sj` `sk` `sl` | Move to the window on the left / below / above / right |
| `te` | New tab page |

## Files and search

| Key | Action |
| --- | --- |
| `sf` | Floating file explorer (Oil). Edit it like a buffer, `:w` to apply, `h` parent, `q` close |
| `;f` / `;r` | Find a file / search text in the project |
| `\\` | Open buffers |

## Code

| Key | Action |
| --- | --- |
| `gd` / `gr` | Definition / references |
| `K` | Documentation |
| `Space cr` / `Space ca` | Rename symbol / code actions |
| `Space f` | Format |
| `Ctrl+j` | Next diagnostic |
| `;e` | All diagnostics of the project |
| `Enter` | Accept a completion (`Ctrl+n` / `Ctrl+p` to move) |

## Surround `*`

`b`, `r` and `B` stand for `()`, `[]` and `{}`, handy on non-QWERTY keyboards.

| Key | Action |
| --- | --- |
| `Sb` / `Sr` / `SB` (visual) | Wrap the selection in `()` / `[]` / `{}` |
| `csbr` | Change surrounding `()` to `[]` |
| `dsb` | Remove surrounding `()` |

## Git

| Key | Action |
| --- | --- |
| `;g` | Lazygit |
| `]c` / `[c` | Next / previous hunk in the file |
| `Space gb` | Blame the line |
| `Space dv` | Diff view |
| `Space dh` | History of the file |

## Other additions `*`

- PHP/Symfony, Twig, Python, YAML, HTML and JSON language servers
- HTML, JSX and Twig tags close and rename themselves

## tmux

The prefix is `Ctrl+t` instead of `Ctrl+b`.

| Key | Action |
| --- | --- |
| `Shift+←` / `Shift+→` `*` | Previous / next window, no prefix needed |
| prefix `c` / `n` / `p` | New / next / previous window. Works with `Ctrl` held too `*` |
| prefix `-` / `%` | Split below / to the right |
| prefix `h` `j` `k` `l` | Move between panes |
| prefix `g` | Lazygit in a popup |
